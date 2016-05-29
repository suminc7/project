package com.does.lotte.controller {
	import com.framework.loader.MP3Loader;
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	/**
	 * ...
	 * @author yuna_tab
	 */
	public class SoundController {
		private static var path : String;
		private static var _instance : SoundController;
		private var _heart : MP3Loader;
		private var _friend : MP3Loader;
		private var _walk : MP3Loader;
		private var _invincible : MP3Loader;
		private var _minusLife : MP3Loader;
		private var _failed : MP3Loader;
		private var _counter : MP3Loader;
		private var _main : MP3Loader;
		private var _success : MP3Loader;
		private var _rouletteSuccess : MP3Loader;
		private var _rouletteFailed : MP3Loader;
		private var _rouletteClick : MP3Loader;
		private var _rouletteDrag : MP3Loader;
		private var _rouletteRotation : MP3Loader;
		private var _scoreStart : MP3Loader;
		private var sTransform : SoundTransform = new SoundTransform();

		public function SoundController(root : DisplayObject) : void {
			// path = SecurityUse.getSwfParentPath(root) + "sound/";

			path = "http://data.enriching.co.kr/sound/";

			_main = new MP3Loader();
			_main.loadMP3(path + "main.mp3", 999);
			_main.volume = 1;

			// _main.pause();

			// _stage1 = new MP3Loader();
			// _stage1.loadMP3(path + "stage1.mp3", 999);
			// _stage1.volume = .2;
			// _stage1.pause();
			//
			// _stage2 = new MP3Loader();
			// _stage2.loadMP3(path + "stage2.mp3", 999);
			// _stage2.volume = .2;
			// _stage2.pause();
			//
			// _stage3 = new MP3Loader();
			// _stage3.loadMP3(path + "stage3.mp3", 999);
			// _stage3.volume = .2;
			// _stage3.pause();

			_heart = new MP3Loader();
			_heart.loadMP3(path + "eating_heart.mp3", 1);
			_heart.volume = .5;
			_heart.pause();

			_friend = new MP3Loader();
			_friend.loadMP3(path + "eating_friend.mp3", 1);
			_friend.volume = .5;
			_friend.pause();

			_walk = new MP3Loader();
			_walk.loadMP3(path + "walking.mp3", 1);
			_walk.volume = .5;
			_walk.pause();

			_invincible = new MP3Loader();
			_invincible.loadMP3(path + "invincible.mp3", 1);
			_invincible.volume = .5;
			_invincible.pause();

			_minusLife = new MP3Loader();
			_minusLife.loadMP3(path + "minus_life.mp3", 1);
			_minusLife.volume = .5;
			_minusLife.pause();

			_failed = new MP3Loader();
			_failed.loadMP3(path + "failed.mp3", 1);
			_failed.volume = .5;
			_failed.pause();

			_counter = new MP3Loader();
			_counter.loadMP3(path + "counter.mp3", 1);
			_counter.volume = .5;
			_counter.pause();

			_success = new MP3Loader();
			_success.loadMP3(path + "success.mp3", 1);
			_success.volume = .5;
			_success.pause();

			_rouletteSuccess = new MP3Loader();
			_rouletteSuccess.loadMP3(path + "roulette_success.mp3", 1);
			_rouletteSuccess.volume = .5;
			_rouletteSuccess.pause();

			_rouletteFailed = new MP3Loader();
			_rouletteFailed.loadMP3(path + "roulette_failed.mp3", 1);
			_rouletteFailed.volume = .5;
			_rouletteFailed.pause();

			_rouletteClick = new MP3Loader();
			_rouletteClick.loadMP3(path + "roulette_click.mp3", 1);
			_rouletteClick.volume = .5;
			_rouletteClick.pause();

			_rouletteDrag = new MP3Loader();
			_rouletteDrag.loadMP3(path + "roulette_drag.mp3", 1);
			_rouletteDrag.volume = .5;
			_rouletteDrag.pause();

			_rouletteRotation = new MP3Loader();
			_rouletteRotation.loadMP3(path + "roulette_rotation.mp3", 1);
			_rouletteRotation.volume = .5;
			_rouletteRotation.pause();

			_scoreStart = new MP3Loader();
			_scoreStart.loadMP3(path + "score_start_01.mp3", 1);
			_scoreStart.volume = .5;
			_scoreStart.pause();
		}

		public function volumeUp() : void {
			TweenMax.to(currentStageSound, .5, {volume:1});
			killTween();
		}

		public function volumeDown() : void {
			TweenMax.to(currentStageSound, .5, {volume:.3});
			killTween();
		}

		private function killTween() : void {
		}

		public function get currentStageSound() : MP3Loader {
			var loader : MP3Loader;

			loader = _main;

			return loader;
		}

		public function counter() : void {
			TweenMax.delayedCall(.5, onComplete);

			function onComplete() : void {
				_counter.resume();
			}
		}

		public function scoreStart() : void {
			_scoreStart.resume();
		}

		public function rouletteRotation() : void {
			_rouletteRotation.resume();
		}

		public function rouletteClick() : void {
			_rouletteClick.resume();
		}

		public function rouletteDrag() : void {
			_rouletteDrag.resume();
		}

		public function rouletteSuccess() : void {
			_rouletteSuccess.resume();
		}

		public function rouletteFailed() : void {
			_rouletteFailed.resume();
		}

		public function success() : void {
			_success.resume();
		}

		public function minusLifeSound() : void {
			_minusLife.resume();
		}

		public function failedSound() : void {
			_failed.resume();
		}

		public function eatingFriend() : void {
			_friend.resume();
		}

		public function eatingHeart() : void {
			_heart.resume();
		}

		public function minusLife() : void {
			_heart.resume();
		}

		public function invincible() : void {
			_invincible.resume();
		}

		public function offSoundAll() : void {
			TweenMax.to(sTransform, 1, {volume:0, onUpdate:soundUpdate});
		}

		public function onSoundAll() : void {
			TweenMax.to(sTransform, 1, {volume:1, onUpdate:soundUpdate});
		}

		private function soundUpdate() : void {
			SoundMixer.soundTransform = sTransform;
		}

		static public function instance(root : DisplayObject) : SoundController {
			if (_instance == null) {
				_instance = new SoundController(root);
			}
			return _instance;
		}
	}
}














