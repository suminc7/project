package com.framework.string {
	import com.framework.math.Rnd;

	/**
	 * @author : kylekaturn (http://kyle-katurn.com)
	 * @class : StringUtils.as
	 * @write_date : 2008. 01. 30
	 * @version : V1.0
	 */
	public class StringUtils {
		
		
		
		
		/**
		 * jsonp 객체에서 함수 제거후 json객체로 리턴
		 * @param str	jsonp 객체
		 * @return		json 객체
		 */
		public static function jsonpToJson(str : String) : String {
			str = str.substring(str.indexOf("(") + 1, str.lastIndexOf(")"));
			return str;
		}
		
		
		/**
		 * 전달된 파일경로에서 파일명 제거후 디렉토리 만 리턴
		 * @param str	파일경로
		 * @return		파일명이 제거된 순수한 폴더 경로
		 */
		public static function getDirectory(str : String) : String {
			if (str.lastIndexOf("\\") != -1) {
				str = str.substring(0, str.lastIndexOf("\\")) + "\\";
			} else {
				str = str.substring(0, str.lastIndexOf("/")) + "/";
			}
			return str;
		}

		/**
		 * 전달된 파일경로에서 파일명 제거후 디렉토리 만 리턴
		 * @param str	파일경로
		 * @return		파일명이 제거된 순수한 폴더 경로
		 */
		public static function getDirectoryParent(str : String) : String {
			if (str.lastIndexOf("\\") != -1) {
				str = str.substring(0, str.lastIndexOf("\\"));
				str = str.substring(0, str.lastIndexOf("\\")) + "\\";
			} else {
				str = str.substring(0, str.lastIndexOf("/"));
				str = str.substring(0, str.lastIndexOf("/")) + "/";
			}
			return str;
		}

		/**----------------------------------------------------------------------------------
		 *@description : 문자열 공백 길이 체크
		 * @param inStr :String, 공백체크할 문자열
		 * @return 공백 문자열 길이 반환
		 *------------------------------------------------------------------------------------*/
		public static function strlengthEmpty(inStr : String) : Number {
			var emptyLength : int = 0;
			for (var i : int = 0 ;i <= inStr.length - 1 ;i++) {
				if (inStr.charAt(i) == " ") {
					emptyLength++;
				}
			}
			return emptyLength;
		}

		/**-------------------------------------------------------------------------
		@description 원하는 문자열로 교체 
		@param source :String, 원본 문자열
		@param remove : String, 제거할 문자열
		@param replace : String, 교체할 문자열
		@example 
		<code>
		StringUtils.replace("This is my String", "my", "not a"); 
		// returns "This is not a String"
		</code>
		 *--------------------------------------------------------------------------*/
		public static function replace(inSource : String, inRemove : String, inReplace : String) : String {
			var index : Number = inSource.indexOf(inRemove);
			while (index >= 0) {
				inSource = inSource.substr(0, index) + inReplace + inSource.substr(index + inRemove.length);
				index = inSource.indexOf(inRemove, index + 1);
			}
			return inSource;
		}

		/*
		 * @description 태그 제거
		 */
		public static function removeTags(str : String) : String {
			var leftNum : Number = str.indexOf("<");
			if (leftNum != -1) {
				var rightNum : Number = str.indexOf(">", leftNum);
				if (rightNum != -1) {
					str = str.substring(0, leftNum) + str.substring(rightNum + 1);
					str = removeTags(str);
				}
			}
			return str;
		}

		/**
		@description 문자열 ture 또는 false 를 실제 boolean 값으로 변환
		 */
		public static function convertBoolean(str : String) : Boolean {
			var result : Boolean = (str == "true") ? true : false;
			return result;
		}

		/*
		 * @description 문자열에서 개행문자를 삭제
		 */
		public static function removeNewLine(str : String) : String {
			var replacedStr : String = str;
			replacedStr = replace(replacedStr, "\n", "");
			return replacedStr;
		}

		public static function removeEscapeNewLine(str : String) : String {
			var replacedStr : String = escape(str);
			replacedStr = replace(replacedStr, "%0D", "");
			return unescape(replacedStr);
		}

		public static function removeSpace(str : String) : String {
			var replacedStr : String = escape(str);
			replacedStr = replace(replacedStr, "%20", "");
			return unescape(replacedStr);
		}

		public static function getRandomLetter(str : String) : String {
			return str.substr(Rnd.integer(0, str.length), 1);
		}

		public static function striptags(value : String) : String {
			return value.replace(/<.*?>/g, "");
		}

		public static function stripHtmlTags(str : String, tags : String = null) : String {
			var pattern : RegExp = /<\/?[a-zA-Z0-9]+.*?>/gim;
			// strips all tags

			if (tags != null) {
				var getChars : RegExp = /(<)([^>]*)(>)/gim;
				var stripPattern : String = tags.replace(getChars, "$2|");
				stripPattern = stripPattern.substr(0, -1);
				stripPattern = "<(?!/?(" + stripPattern + ")(?=[^a-zA-Z0-9]))\/?[a-zA-Z0-9]+.*?/?>";
				pattern = new RegExp(stripPattern, "gim");
			}

			return  str.replace(pattern, "").replace(/&.*?;/g, "");
		}

		public static function strAddDot(str : String, length : int) : String {
			var s : String = str.length > length ? str.substr(0, length) + ".." : str;
			return s;
		}
	}
}
