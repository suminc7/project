package com.framework.math {
	import flash.geom.Point;

	/**
	 * 수학관련 라이브러리 클래스
	 * @author kylekaturn (http://kyle-katurn.com)
	 * @class : MathUtils.as
	 * @write_date : 2008. 02. 23
	 * @version : V1.0
	 */
	public class MathUtils {
		/**
		 * 라디언을 각도로 반환
		 */
		public static function RadianToAngle(rad : Number) : Number {
			return rad * 180 / Math.PI;
		}

		/**
		 * 각도를 라디언으로 반환
		 */
		public static function AngleToRadian(rad : Number) : Number {
			return rad * Math.PI / 180;
		}

		/*
		 * @description 숫자에 컴마를 붙여서 리턴
		 * @param num:Number 컴마를 붙일 숫자
		 */
		public static function putComma(num : Number) : String {
			var len : int = String(num).length;
			var str : String = String(num);
			var result : String;

			if (str.length > 3) {
				var mod : int = str.length % 3;
				var ret : String = (mod > 0 ? (str.substring(0, mod)) : "");
				for (var i : int = 0 ; i < Math.floor(str.length / 3); i++) {
					if ((mod == 0) && (i == 0)) {
						ret += str.substring(mod + 3 * i, mod + 3 * i + 3);
					} else {
						ret += "," + str.substring(mod + 3 * i, mod + 3 * i + 3);
					}
				}
				result = ret;
				return result;
			} else {
				return String(num);
			}
		}

		/**
		 * 주어진 숫자를 자릿수에 해당하는 문자열로 리턴
		 * ex ) 9 --> 009
		 * @param num 		변환할 숫자
		 * @param level 	자릿수
		 * @return 			결과 문자열
		 */
		public static function numToString(num : int, level : int) : String {
			if (Math.pow(10, level) > num) {
				return String(Math.pow(10, level) + num).substr(1);
			} else {
				return String(num);
			}

			// var temp:int = Math.pow(10,level) + num;
			// while(level){
			// 
			// }
		}

		// 초를 시계같은 형식으로 만들기
		// ex : 90 -> 01:30
		public static function getSecondToClockString(value : Number) : String {
			var second : Number = Math.floor(value) / 1000;
			var minute : Number = 0;
			var hour : Number = 0;
			var day : Number = 0;
			var returnStr : String = "";

			while (second > 60) {
				minute++;
				second -= 60;
			}

			while (minute > 60) {
				hour++;
				minute -= 60;
			}

			while (hour > 24) {
				day++;
				hour -= 24;
			}

			if (second == 60) {
				second = 0;
				minute++;
			}

			if (minute == 60) {
				minute = 0;
				hour++;
			}

			if (0 < day) returnStr += (day < 10) ? "0" + String(day) : String(day);
			if (0 < day) returnStr += ":";
			if (0 < hour) returnStr += (hour < 10) ? "0" + String(hour) : String(hour);
			if (0 < hour) returnStr += ":";
			returnStr += (minute < 10) ? "0" + String(minute) : String(minute);
			returnStr += ":";
			returnStr += (second < 10) ? "0" + String(second) : String(second);

			return returnStr;
		}

		/*
		 * @description 각도값을 360 밑으로 리턴
		 */
		public static function getAngleUnder360(ang : Number) : Number {
			while (ang > 360) {
				ang -= 360;
			}
			while (ang < 0) {
				ang += 360;
			}
			return ang;
		}

		/*
		 * @description
		 */
		public static function getRotationNum(num : int, rot : int) : int {
			while (num > rot || num < 0) {
				if (num > 0) {
					num -= rot;
					continue;
				}
				if (num < 0) {
					num += rot;
					continue;
				}
			}
			if (num == 0) num = rot;

			return num;
		}

		/*
		 * @description - 두개의 포인트 사이의 각도 리턴함
		 * @param : point1:Point - 포인트1
		 * @param : point2:Point - 포인트 2
		 */
		public static function getAngle(point1 : Point, point2 : Point) : Number {
			var disX : Number = point2.x - point1.x;
			var disY : Number = point2.y - point1.y;
			var angle : Number = Math.atan2(disY, disX);
			return RadianToAngle(angle);
		}

		/*
		 * @description angl
		 */
		public static function polarAngle(len : Number, angle : Number) : Point {
			return Point.polar(len, AngleToRadian(angle - 90));
		}
	}
}
