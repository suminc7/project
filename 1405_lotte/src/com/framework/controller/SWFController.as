package com.framework.controller {
	import com.greensock.events.LoaderEvent;
	import com.greensock.TweenMax;
	import com.greensock.layout.ScaleMode;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.display.ContentDisplay;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.text.TextField;

	/**
	 * @author suminc7
	 * 
	 * controller 안에 seekBar, seekProgressBar, playBtn
	 * 
	 */
	public class SWFController extends Sprite {
		private var url : String;
		private var wid : int;
		private var hei : int;
		private var controller : MovieClip;
		private var point : Point = new Point();
		private var autoPlay : Boolean;
		private var isDrag : Boolean;
		private var sound : SoundTransform = new SoundTransform();
		private var isSound : Boolean = true;
		private var sndBtn : MovieClip;
		private var seekProgressBar : MovieClip;
		private var seekBtn : MovieClip;
		private var seekBar : MovieClip;
		private var playBtn : MovieClip;
		private var stopBtn : MovieClip;
		private var time : TextField;
		private var swf : MovieClip;
		private var isPlay : Boolean;

		public function SWFController(url : String, wid : int, hei : int, controller : MovieClip, autoPlay : Boolean = true) {
			this.url = url;
			this.wid = wid;
			this.hei = hei;
			this.controller = controller;
			this.autoPlay = autoPlay;
			this.playBtn = controller.playBtn;
			this.stopBtn = controller.stopBtn;
			this.seekBar = controller.seekBar;
			this.seekBtn = controller.seekBtn;
			this.seekProgressBar = controller.seekProgressBar;
			this.sndBtn = controller.sndBtn;
			this.time = controller.time;

			init();
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
			start();
		}

		private function initRemoveStage(event : Event) : void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, seekBtnMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, seekBtnUp);
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function init() : void {
			initMovieClip();
			initVideo();
		}

		private function start() : void {
		}

		private function initMovieClip() : void {
			if (seekProgressBar) {
				seekProgressBar.mouseEnabled = false;
			}
			if (stopBtn) {
				stopBtn.buttonMode = true;
				stopBtn.addEventListener(MouseEvent.MOUSE_DOWN, stopBtnClick);
			}
			if (seekBtn) {
				seekBtn.buttonMode = true;
				seekBtn.addEventListener(MouseEvent.MOUSE_DOWN, seekBtnDown);
			}

			if (seekBar) {
				seekBar.addEventListener(MouseEvent.CLICK, seekBarClick);
			}

			if (playBtn) {
				playBtn.stop();
				playBtn.buttonMode = true;
				playBtn.addEventListener(MouseEvent.CLICK, togglePause);
			}

			if (sndBtn) {
				sndBtn.stop();
				sndBtn.buttonMode = true;
				sndBtn.addEventListener(MouseEvent.CLICK, soundControll);
			}
		}

		private function stopBtnClick(event : MouseEvent) : void {
			stopVideo();
		}

		public function volume(v : Number, t : Number = 1) : void {
			TweenMax.to(sound, t, {volume:v, onUpdate:sndUpdate});
		}

		private function sndUpdate() : void {
			soundTransform = sound;
		}

		private function soundControll(event : MouseEvent) : void {
			if (isSound) {
				volume(0, 0);
				sndBtn.gotoAndStop(2);
			} else {
				volume(1, 0);
				sndBtn.gotoAndStop(1);
			}
			isSound = !isSound;
		}

		private function seekBtnDown(event : MouseEvent) : void {
			isDrag = true;
			swf.stop();
			var rec : Rectangle = new Rectangle(seekBar.x, seekBtn.y, seekBar.width, 0);
			seekBtn.startDrag(false, rec);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, seekBtnMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, seekBtnUp);
		}

		protected function seekBtnMove(event : MouseEvent) : void {
			var n : int = Math.floor((seekBtn.x - seekBar.x) / seekBar.width * swf.totalFrames) + 1;
			swf.gotoAndStop(n);
			seekProgressBar.width = seekBtn.x - seekBar.x;
		}

		private function seekBtnUp(event : MouseEvent) : void {
			isDrag = false;
			seekBtn.stopDrag();
			if (isPlay) swf.play();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, seekBtnMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, seekBtnUp);
		}

		private function initVideo() : void {
			var loader : SWFLoader = new SWFLoader(url, {onInit:initListener, name:"swfVideo", smoothing:true, container:this, x:0, y:0, width:wid, height:hei, bgColor:0xcccccc, scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, autoPlay:autoPlay, volume:1, requireWithRoot:this.root, estimatedBytes:75000});
			loader.load();
		}

		private function initListener(event : LoaderEvent) : void {
			swf = ContentDisplay(LoaderMax.getContent("swfVideo")).rawContent;
			dispatchEvent(event);

			addEventListener(Event.ENTER_FRAME, enterFrame);
		}

		private function enterFrame(event : Event) : void {
			if (isDrag) return;
			seekProgressBar.scaleX = swf.currentFrame / swf.totalFrames;
			seekBtn.x = seekProgressBar.x + seekProgressBar.width;

			if (swf.currentFrame == swf.totalFrames) {
				pauseVideo();
			}
		}

		private function playProgress(event : LoaderEvent) : void {
			// if (!isDrag && seekBtn) seekBtn.x = seekProgressBar.width + seekProgressBar.x;
			// if (!isDrag && seekProgressBar) seekProgressBar.scaleX = video.playProgress;
			// if (!isDrag && time) time.text = MathUtils.getSecondToClockString(Math.floor(video.videoTime) * 1000);
		}

		private function togglePause(event : MouseEvent) : void {
			if (isPlay) {
				pauseVideo();
			} else {
				playVideo();
			}
		}

		protected function seekBarClick(event : MouseEvent) : void {
			var n : int = Math.floor((event.stageX - seekBar.localToGlobal(new Point()).x) / seekBar.width * swf.totalFrames) + 1;
			if (isPlay) {
				swf.gotoAndPlay(n);
			} else {
				swf.gotoAndStop(n);
			}
		}

		public function stopVideo() : void {
			playBtn.gotoAndStop(1);
			swf.gotoAndStop(1);
			isPlay = false;
		}

		public function pauseVideo() : void {
			playBtn.gotoAndStop(1);
			swf.stop();
			isPlay = false;
		}

		public function playVideo() : void {
			playBtn.gotoAndStop(2);
			swf.play();
			isPlay = true;
		}
	}
}
