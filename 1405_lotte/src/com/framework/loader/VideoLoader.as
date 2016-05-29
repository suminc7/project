package com.framework.loader {
	import com.framework.debug.Debug;
	import com.framework.events.VideoLoaderEvent;
	import com.framework.types.CamType;
	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.ObjectEncoding;

	/**
	 * @author sumin
	 */
	public class VideoLoader extends Sprite {
		public var nc : NetConnection;
		public var ns : NetStream;
		public var metaData : Object;
		public var xmpData : Object;
		public var video : Video;
		public var mic : Microphone;
		public var cam : Camera;
		public var seekBar : MovieClip;
		public var seekBtn : MovieClip;
		public var seekProgressBar : MovieClip;
		public var scrubbing : Boolean;
		public var seekBarCheck : Boolean;
		private var url : String;
		private var wid : int;
		private var hei : int;
		private var fps : int;
		private var quality : int;
		private var rtmpFile : String;
		private var camType : String;
		private var sound : SoundTransform = new SoundTransform();
		public var duration : Number;

		public function VideoLoader() {
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
		}

		private function initRemoveStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			nc.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			nc.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncError);
			ns.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			ns.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncError);
			removeEventListener(Event.ENTER_FRAME, onProgress);
		}

		/*
		 * init
		 */
		private function initConnection(url : String) : void {
			nc = new NetConnection();
			nc.client = this;
			nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncError);
			nc.objectEncoding = ObjectEncoding.AMF3;
			nc.connect(url);
		}

		private function initNetStream() : void {
			ns = new NetStream(nc);
			ns.client = this;
			video.attachNetStream(ns);
			sound = ns.soundTransform;
			ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			ns.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncError);

			if (rtmpFile) {
				ns.play(rtmpFile);
			} else {
				ns.play(url);
			}

			if (camType) {
				initConnectCam();
			}
			dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.ON_NET_STREAM, true));
		}

		private function initVideo() : void {
			video = new Video(wid, hei);
			addChild(video);
		}

		private function initConnectCam() : void {
			if (camType == CamType.All) {
				CamTypeMic();
				CamTypeCamera();
			} else if (camType == CamType.Microphones) {
				CamTypeMic();
			} else if (camType == CamType.Cameras) {
				CamTypeCamera();
			}
		}

		private function CamTypeMic() : void {
			if (Microphone.getMicrophone() != null) {
				mic = Microphone.getMicrophone();
				ns.attachAudio(mic);
			}
		}

		private function CamTypeCamera() : void {
			cam = Camera.getCamera();
			cam.setMode(wid, hei, fps, true);
			cam.setQuality(0, quality);
			ns.attachCamera(cam);
			video.attachCamera(cam);
		}

		public function get micActivityLevel() : int {
			return int(mic.activityLevel);
		}

		public function load(url : String = null, wid : int = 320, hei : int = 240) : void {
			Debug.tracer(url + " : file loading has initialized.", null, Debug.LEVEL_INFO);
			this.url = url;
			this.wid = wid;
			this.hei = hei;
			initVideo();

			initConnection(null);
		}

		public function loadRtmp(url : String = null, rtmpFile : String = null, wid : int = 320, hei : int = 240, camType : String = CamType.None, fps : Number = 30, quality : int = 100) : void {
			Debug.tracer(url + " : file loading has initialized.", null, Debug.LEVEL_INFO);
			this.url = url;
			this.wid = wid;
			this.hei = hei;
			initVideo();

			this.rtmpFile = rtmpFile;
			this.camType = camType;
			this.fps = fps;
			this.quality = quality;
			initConnection(url);
		}

		/**
		 * dispose
		 */
		public function dispose() : void {
			ns.close();
			nc.close();
		}

		/**
		 * on MetaData callback by NetStream Object
		 */
		public function onMetaData(info : Object) : void {
			metaData = info;
			// Debug.delimiter();
			// for(var propName:String in info) {
			// Debug.tracer(propName + " = " + info[propName]);
			// }
			// Debug.delimiter();
			duration = metaData["duration"];
			dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.ON_META_DATA, true));
		}

		public function onXMPData(info : Object) : void {
			dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.ON_XMP_DATA, true));
		}

		public function onBWDone(... rest) : void {
		}

		/**
		 * onPlayStatus event handler
		 */
		public function onPlayStatus(info : Object) : void {
		}

		/**
		 * on NetStatus event handler
		 */
		private function onNetStatus(event : NetStatusEvent) : void {
			// Debug.tracer('info.code: ' + (event.info.code));
			// trace('event: ' + (event.info.code));
			switch(event.info.code) {
				case "NetConnection.Connect.Success":
					initNetStream();
					break;
				case "NetStream.Play.Start":
					dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.ON_PLAY_STARTED, true));
					break;
				case "NetStream.Buffer.Full":
					dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.NETSTREAM_BUFFER_FULL, true));
					break;
				case "NetStream.Buffer.Empty":
					break;
				case "NetStream.Play.Stop":
					dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.ON_PLAY_FINISHED, true));
					break;
				case "NetStream.FileStructureInvalid":
					break;
				case "NetStream.NoSupportedTrackFound":
					break;
			}
		}

		private function securityError(event : SecurityErrorEvent) : void {
			trace("SecurityError : " + event);
		}

		private function asyncError(event : AsyncErrorEvent) : void {
			trace("asyncError : " + event);
		}

		/**
		 * seek
		 */
		public function seek(offset : Number) : void {
			ns.seek(offset);
			dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.SEEK, true, {offset:offset}));
		}

		public function setSeekBar(seekBar : MovieClip, seekProgressBar : MovieClip, seekBtn : MovieClip = null) : void {
			this.seekBar = seekBar;
			this.seekProgressBar = seekProgressBar;
			if (seekBtn) this.seekBtn = seekBtn;

			seekBar.addEventListener(MouseEvent.CLICK, seekBarClick);
			seekProgressBar.mouseEnabled = false;

			if (seekBtn) seekBtn.buttonMode = true;
			if (seekBtn) seekBtn.addEventListener(MouseEvent.MOUSE_DOWN, seekBtnDown);

			addEventListener(Event.ENTER_FRAME, onProgress);
		}

		protected function seekBarClick(event : MouseEvent) : void {
			seek((event.stageX - seekBar.localToGlobal(new Point(0, 0)).x) / seekBar.width * duration);
		}

		protected function onProgress(event : Event) : void {
			if (seekBar) {
				if (scrubbing) {
				} else {
					if (seekBtn) seekBtn.x = ns.time / duration * seekBar.width + seekBar.x;
					seekProgressBar.scaleX = ns.time / duration;
				}
			}
		}

		protected function seekBtnMove(event : MouseEvent) : void {
			seek((seekBtn.x - seekBar.x) / seekBar.width * duration);
			seekProgressBar.width = seekBtn.x - seekBar.x;
		}

		private function seekBtnDown(event : MouseEvent) : void {
			scrubbing = true;
			var rec : Rectangle = new Rectangle(seekBar.x, seekBtn.y, seekBar.width, 0);
			seekBtn.startDrag(false, rec);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, seekBtnMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, seekBtnUp);
			ns.pause();
		}

		private function seekBtnUp(event : MouseEvent) : void {
			scrubbing = false;
			seekBtn.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, seekBtnMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, seekBtnUp);
			ns.resume();
		}

		/**
		 * play
		 */
		public function resume() : void {
			ns.resume();
		}

		/**
		 * pause
		 */
		public function pause() : void {
			ns.pause();
		}

		/**
		 * toggle pause
		 */
		public function togglePause() : void {
			ns.togglePause();
		}

		/**
		 * 현재 플레이되는 무비의 time을 second 형식으로 리턴
		 */
		public function get time() : Number {
			try {
				return ns.time;
			} catch(e : Error) {
				return 0;
			}
			return 0;
		}

		/**
		 * 무비의 길이를 second형식으로 리턴
		 */
		// public function get duration() : Number {
		// return metaData["duration"];
		// }
		/**
		 * netStream 객체 리턴
		 */
		public function get netStream() : NetStream {
			return ns;
		}

		public function volume(v : Number, t : Number = 1) : void {
			TweenMax.to(sound, t, {volume:v, onUpdate:sndUpdate});
		}

		private function sndUpdate() : void {
			ns.soundTransform = sound;
		}

		/*
		 * cam 관련
		 */
		public function streamAttach() : void {
			video.attachNetStream(ns);
		}

		public function streamPlay(name : String) : void {
			ns.play(name);
		}

		public function streamClose() : void {
			ns.close();
		}

		public function connectClose() : void {
			nc.close();
		}

		public function streamPublish(name : String, type : String = "record") : void {
			ns.publish(name, type);
		}

		/**
		 * IOError event handler
		 */
		private function onIOError(event : IOErrorEvent) : void {
			Debug.tracer("IOError : " + event.text, null, Debug.LEVEL_ERROR);
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
	}
}
