package com.does.lotte.global {

	/**
	 * @author chaesumin
	 */
	public class Score {
		public static const heartScore : int = 100;
		public static const friendScore : int = 1000;
		public static const timeScore : int = 100;
		private static var _s1myRoulette : int;
		private static var _s2myRoulette : int;
		private static var _s3myRoulette : int;
		private static var _s1myTime : Number;
		private static var _s2myTime : Number;
		private static var _s3myTime : Number;
		private static var _s1myFriend : int;
		private static var _s2myFriend : int;
		private static var _s3myFriend : int;
		private static var _s1myHeart : int;
		private static var _s2myHeart : int;
		private static var _s3myHeart : int;
		public static var bestScore : int;

		static public function get totalScore() : int {
			return stage1Score + stage2Score + stage3Score;
		}

		static public function get beforeTotalScore() : int {
			if (GameData.currentStep == 1) {
				return 0;
			} else if (GameData.currentStep == 2) {
				return stage1Score;
			} else if (GameData.currentStep == 3) {
				return stage1Score + stage2Score;
			} else {
				return 0;
			}
		}

		static public function get currentStepScore() : int {
			var heart : int = myHeart * heartScore;
			var friend : int = myFriend * friendScore;
			var times : int = myTime * timeScore;

			var total : int = heart + friend + times;

			total = getRouletteScore(total, myRoulette);

			return total;
		}

		public static function reset() : void {
			_s1myHeart = _s2myHeart = _s3myHeart = 0;
			_s1myFriend = _s2myFriend = _s3myFriend = 0;
			_s1myTime = _s2myTime = _s3myTime = 0;
			_s1myRoulette = _s2myRoulette = _s3myRoulette = 0;
			
		}

		public static function get myTime() : Number {
			if (GameData.currentStep == 1) {
				return _s1myTime;
			} else if (GameData.currentStep == 2) {
				return _s2myTime;
			} else if (GameData.currentStep == 3) {
				return _s3myTime;
			} else {
				return 0;
			}
		}

		public static function set myTime(myTime : Number) : void {
			if (GameData.currentStep == 1) {
				_s1myTime = myTime;
			} else if (GameData.currentStep == 2) {
				_s2myTime = myTime;
			} else if (GameData.currentStep == 3) {
				_s3myTime = myTime;
			}
		}

		public static function get myFriend() : int {
			if (GameData.currentStep == 1) {
				return _s1myFriend;
			} else if (GameData.currentStep == 2) {
				return _s2myFriend;
			} else if (GameData.currentStep == 3) {
				return _s3myFriend;
			} else {
				return 0;
			}
		}

		public static function set myFriend(myFriend : int) : void {
			if (GameData.currentStep == 1) {
				_s1myFriend = myFriend;
			} else if (GameData.currentStep == 2) {
				_s2myFriend = myFriend;
			} else if (GameData.currentStep == 3) {
				_s3myFriend = myFriend;
			}
		}

		public static function get myHeart() : int {
			if (GameData.currentStep == 1) {
				return _s1myHeart;
			} else if (GameData.currentStep == 2) {
				return _s2myHeart;
			} else if (GameData.currentStep == 3) {
				return _s3myHeart;
			} else {
				return 0;
			}
		}

		public static function set myHeart(myHeart : int) : void {
			if (GameData.currentStep == 1) {
				_s1myHeart = myHeart;
			} else if (GameData.currentStep == 2) {
				_s2myHeart = myHeart;
			} else if (GameData.currentStep == 3) {
				_s3myHeart = myHeart;
			}
		}


		public static function get myRoulette() : int {
			if (GameData.currentStep == 1) {
				return _s1myRoulette;
			} else if (GameData.currentStep == 2) {
				return _s2myRoulette;
			} else if (GameData.currentStep == 3) {
				return _s3myRoulette;
			} else {
				return 0;
			}
		}

		public static function set myRoulette(myRoulette : int) : void {
			if (GameData.currentStep == 1) {
				_s1myRoulette = myRoulette;
			} else if (GameData.currentStep == 2) {
				_s2myRoulette = myRoulette;
			} else if (GameData.currentStep == 3) {
				_s3myRoulette = myRoulette;
			}
		}

		static public function get stage1Score() : int {
			var heart : int = _s1myHeart * heartScore;
			var friend : int = _s1myFriend * friendScore;
			var times : Number = _s1myTime * timeScore;

			var total : int = heart + friend + times;

			total = getRouletteScore(total, _s1myRoulette);

			return total;
		}

		static public function get stage2Score() : int {
			var heart : int = _s2myHeart * heartScore;
			var friend : int = _s2myFriend * friendScore;
			var times : Number = _s2myTime * timeScore;

			var total : int = heart + friend + times;

			total = getRouletteScore(total, _s2myRoulette);

			return total;
		}

		static public function get stage3Score() : int {
			var heart : int = _s3myHeart * heartScore;
			var friend : int = _s2myFriend * friendScore;
			var times : Number = _s3myTime * timeScore;

			var total : int = heart + friend + times;

			total = getRouletteScore(total, _s3myRoulette);

			return total;
		}

		private static function getRouletteScore(total : int, myRoulette : int) : int {
			if (myRoulette == 0) {
			} else if (myRoulette == 1) {
				total = total + 3000;
			} else if (myRoulette == 2) {
				total = total + 10000;
			} else if (myRoulette == 3) {
				total = total * 3;
			} else if (myRoulette == 4) {
				total = total + 0;
			} else if (myRoulette == 5) {
				total = total + 5000;
			} else if (myRoulette == 6) {
				total = total * 2;
			} else if (myRoulette == 7) {
				total = total + 7000;
			} else if (myRoulette == 8) {
				total = total + 1000;
			}
			return total;
		}

		public static function getRouletteText() : String {
			var roulette : int;

			if (GameData.currentStep == 1) {
				roulette = _s1myRoulette;
			} else if (GameData.currentStep == 2) {
				roulette = _s2myRoulette;
			} else if (GameData.currentStep == 3) {
				roulette = _s3myRoulette;
			}

			var rouletteText : String = "";

			if (roulette == 0) {
				rouletteText = "0";
			} else if (roulette == 1) {
				rouletteText = "+3000";
			} else if (roulette == 2) {
				rouletteText = "+10000";
			} else if (roulette == 3) {
				rouletteText = "x3";
			} else if (roulette == 4) {
				rouletteText = "0";
			} else if (roulette == 5) {
				rouletteText = "+5000";
			} else if (roulette == 6) {
				rouletteText = "x2";
			} else if (roulette == 7) {
				rouletteText = "+7000";
			} else if (roulette == 8) {
				rouletteText = "+1000";
			}
			return rouletteText;
		}
	}
}
