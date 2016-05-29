package com.framework.loader {
	import com.framework.debug.Debug;
	import com.framework.events.MP3LoaderEvent;

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	/**
	 * @author : kylekaturn (http://kyle-katurn.com)
	 * @class : MP3Loader.as
	 * @write_date : 2008. 02. 21
	 * @version : V1.0
	 */
	public class MP3Loader extends Sound {
		private var soundUrl : String;
		private var _position : Number = 0;
		private var _length : Number = 0;
		private var _duration : Number = 0;
		private var loop : int;
		private var seekBar : MovieClip;
		private var seekProgressBar : MovieClip;
		private var seekDownloadBar : MovieClip;
		private var isPlay : Boolean = true;
		private var _channel : SoundChannel = new SoundChannel();

		/**
		 * constructor method
		 */
		public function MP3Loader() {
			addEventListener(Event.ID3, id3Handler);
			addEventListener(ProgressEvent.PROGRESS, onProgress);
			addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			addEventListener(Event.COMPLETE, onLoadComplete);
		}

		/**
		 * MP3 파일 로드
		 * @param url MP3 file url
		 */
		public function loadMP3(soundUrl : String, loop : int = 999) : void {
			this.soundUrl = soundUrl;
			this.loop = loop;

			Debug.tracer(soundUrl + " : file loading has started.", null, Debug.LEVEL_INFO);

			try {
				load(new URLRequest(soundUrl));
				_channel = play(0, loop);
				isPlay = true;
			} catch (err : Error) {
				Debug.tracer(err.message);
			}
		}

		public function pause() : void {
			_position = _channel.position;
			_channel.stop();
			isPlay = false;
			if (seekBar) seekBar.removeEventListener(Event.ENTER_FRAME, enterFrame);
			dispatchEvent(new MP3LoaderEvent(MP3LoaderEvent.PAUSE, true));
		}

		public function resume() : void {
			_channel.stop();
			_channel = play(_position, loop);
			if (seekBar) seekBar.addEventListener(Event.ENTER_FRAME, enterFrame);
			isPlay = true;
			dispatchEvent(new MP3LoaderEvent(MP3LoaderEvent.RESUME, true));
		}

		public function stop() : void {
			_position = 0;
			_channel.stop();
			if (seekBar) seekBar.removeEventListener(Event.ENTER_FRAME, enterFrame);
			setSeekProgressBarScale(0);
			isPlay = false;
			dispatchEvent(new MP3LoaderEvent(MP3LoaderEvent.STOP, true));
		}

		public function setSeek(seekBar : MovieClip, seekProgressBar : MovieClip, seekDownloadBar : MovieClip) : void {
			this.seekBar = seekBar;
			this.seekProgressBar = seekProgressBar;
			this.seekDownloadBar = seekDownloadBar;
			this.seekProgressBar.mouseEnabled = false;
			this.seekDownloadBar.mouseEnabled = false;

			this.seekBar.addEventListener(Event.ENTER_FRAME, enterFrame);
			this.seekBar.addEventListener(MouseEvent.CLICK, seekBarClick);

			dispatchEvent(new MP3LoaderEvent(MP3LoaderEvent.START, true));
		}

		protected function seekBarClick(event : MouseEvent) : void {
			var position : Number = (event.stageX - seekBar.localToGlobal(new Point(0, 0)).x) / seekBar.width * _length;
			if (isPlay) {
				_channel.stop();
				_channel = play(position, 0, _channel.soundTransform);
				if (!seekBar.hasEventListener(Event.ENTER_FRAME)) seekBar.addEventListener(Event.ENTER_FRAME, enterFrame);
			}
			_position = position;
			setSeekProgressBarScale(_position);
			dispatchEvent(new MP3LoaderEvent(MP3LoaderEvent.SEEK, true));
		}

		private function soundComplete(event : Event) : void {
			trace('event: ' + (event));
		}

		private function enterFrame(event : Event) : void {
			var per : Number = bytesLoaded / bytesTotal;
			_length = length;

			if (bytesTotal > 0) {
				_length /= per;
				_position = _channel.position;
				setSeekProgressBarScale(_position);
				trace('_length: ' + (_length));
				trace('_position: ' + (_position));
				if (Math.floor(_length / 1000) == Math.floor(_position / 1000)) {
					dispatchEvent(new MP3LoaderEvent(MP3LoaderEvent.SOUND_COMPLETE, true));
					stop();
				}
				dispatchEvent(new MP3LoaderEvent(MP3LoaderEvent.PLAY, true));
			}
		}

		private function setSeekProgressBarScale(num : Number) : void {
			seekProgressBar.scaleX = num / _length;
		}

		/**
		 * 볼륨 set method
		 */
		public function set volume(num : Number) : void {
			var transform : SoundTransform = _channel.soundTransform;
			transform.volume = num;
			_channel.soundTransform = transform;
		}

		/**
		 * 볼륨 get method
		 */
		public function get volume() : Number {
			return _channel.soundTransform.volume;
		}

		public function set position(num : Number) : void {
			_position = num;
		}

		public function get position() : Number {
			return _position;
		}

		/**************************************************************************
		 * event handler
		 ***************************************************************************/
		/**
		 * id3 event handler
		 */
		private function id3Handler(event : Event) : void {
			dispatchEvent(new MP3LoaderEvent(MP3LoaderEvent.ID3, true));
			// Debug.delimiter();
			// Debug.tracer("Recieved " + soundUrl + " id3 information");
			// for(var propName:String in id3) {
			// Debug.tracer(propName + " = " + id3[propName]);
			// Debug.tracer("Artist : " + id3.artist);
			// Debug.tracer("Song name : " + id3.songName);
			// Debug.tracer("Album : " + id3.album);	
			// }
			// Debug.delimiter();
		}

		/**
		 * IOError 발생시
		 */
		private function onIOError(event : IOErrorEvent) : void {
			Debug.tracer("-----------------------------------------------------------", null, Debug.LEVEL_ERROR);
			Debug.tracer(soundUrl + " IOError occured " + event.text, null, Debug.LEVEL_ERROR);
			Debug.tracer("-----------------------------------------------------------", null, Debug.LEVEL_ERROR);
		}

		/**
		 * sound complete
		 */
		private function onLoadComplete(event : Event) : void {
			_duration = _length / 1000;
			Debug.tracer(soundUrl + " : file loading has completed.", null, Debug.LEVEL_INFO);
		}

		/**
		 * progress event handler
		 */
		private function onProgress(event : ProgressEvent) : void {
			if (seekDownloadBar) {
				seekDownloadBar.scaleX = event.bytesLoaded / event.bytesTotal;
			}
		}

		public function get channel() : SoundChannel {
			return _channel;
		}

		public function set channel(channel : SoundChannel) : void {
			_channel = channel;
		}

		public function removeListener() : void {
			removeEventListener(Event.ID3, id3Handler);
			removeEventListener(ProgressEvent.PROGRESS, onProgress);
			removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			removeEventListener(Event.COMPLETE, onLoadComplete);
			seekBar.removeEventListener(Event.ENTER_FRAME, enterFrame);
			seekBar.removeEventListener(MouseEvent.CLICK, seekBarClick);
			seekBar = null;
			seekProgressBar = null;
			seekDownloadBar = null;
		}
	}
}
