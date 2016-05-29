package com.framework.controller {
	import com.framework.math.MathUtils;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.ScaleMode;
	import com.greensock.loading.VideoLoader;

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
	public class VideoController extends Sprite {
		public var video : VideoLoader;
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

		public function VideoController(url : String, wid : int, hei : int, controller : MovieClip, autoPlay : Boolean = true) {
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
				setPlayBtn(autoPlay);
				playBtn.buttonMode = true;
				playBtn.addEventListener(MouseEvent.CLICK, togglePause);
			}

			if (sndBtn) {
				sndBtn.buttonMode = true;
				sndBtn.addEventListener(MouseEvent.CLICK, soundControll);
			}
		}

		private function stopBtnClick(event : MouseEvent) : void {
			video.playProgress = 0;
			pauseVideo();
			setSeekBtn();
		}

		public function volume(v : Number, t : Number = 1) : void {
			TweenMax.to(sound, t, {volume:v, onUpdate:sndUpdate});
		}

		private function sndUpdate() : void {
			video.netStream.soundTransform = sound;
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
			video.netStream.pause();
			var rec : Rectangle = new Rectangle(seekBar.x, seekBtn.y, seekBar.width, 0);
			seekBtn.startDrag(false, rec);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, seekBtnMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, seekBtnUp);
		}

		protected function seekBtnMove(event : MouseEvent) : void {
			video.playProgress = (seekBtn.x - seekBar.x) / seekBar.width;
			seekProgressBar.width = seekBtn.x - seekBar.x;
			video.netStream.pause();
		}

		private function seekBtnUp(event : MouseEvent) : void {
			isDrag = false;
			video.netStream.resume();
			seekBtn.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, seekBtnMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, seekBtnUp);
		}

		private function initVideo() : void {
			video = new VideoLoader(url, {name:"video", container:this, width:wid, height:hei, bgColor:0x000000, scaleMode:ScaleMode.PROPORTIONAL_INSIDE, autoPlay:autoPlay, volume:1, requireWithRoot:this.root, estimatedBytes:75000});
			video.addEventListener(VideoLoader.VIDEO_COMPLETE, videoComplete);
			video.addEventListener(VideoLoader.PLAY_PROGRESS, playProgress);
			video.load();
		}

		private function videoComplete(event : LoaderEvent) : void {
			setPlayBtn(!video.videoPaused);
			video.playProgress = 0;
			setSeekBtn();
		}

		private function playProgress(event : LoaderEvent) : void {
			if (!isDrag && seekBtn) seekBtn.x = seekProgressBar.width + seekProgressBar.x;
			if (!isDrag && seekProgressBar) seekProgressBar.scaleX = video.playProgress;
			if (!isDrag && time) time.text = MathUtils.getSecondToClockString(Math.floor(video.videoTime) * 1000);
		}

		private function togglePause(event : MouseEvent) : void {
			video.videoPaused = !video.videoPaused;
			setPlayBtn(!video.videoPaused);
		}

		protected function seekBarClick(event : MouseEvent) : void {
			if (seekBar) video.playProgress = (event.stageX - seekBar.localToGlobal(point).x) / seekBar.width;
			setSeekBtn();
		}

		private function setSeekBtn() : void {
			if (seekBtn) seekBtn.x = seekProgressBar.width + seekProgressBar.x;
		}

		private function setPlayBtn(check : Boolean) : void {
			if (check) {
				playBtn.gotoAndStop(2);
			} else {
				playBtn.gotoAndStop(1);
			}
		}

		public function pauseVideo() : void {
			playBtn.gotoAndStop(1);
			video.pauseVideo();
		}

		public function playVideo() : void {
			playBtn.gotoAndStop(2);
			video.playVideo();
		}
	}
}
