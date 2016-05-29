package com.framework.display {
	import flash.display.Stage;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * document class 에서 flash.display.MovieClilp 대신 이 클래스를 base class 로 지정한다
	 * root, stage 를 static 변수로 기억하므로 
	 * displayObject 를 상속받지 않은 다른 클래스에서도 root, stage 접근이 가능하다
	 * 
	 * @author : kylekaturn (http://kyle-katurn.com)
	 * @class : Root.as
	 * @write_date : 2008. 02. 27
	 * @version : V1.0
	 */
	public class Root extends MovieClip {
		public static var root : DisplayObject;
		public static var stage : Stage;

		public function Root() {
			Root.stage = this.stage;
			Root.root = this;
		}

		/**
		 * @param refer	아무 displayObject 를 전달하여 Root 에서 root, stage 에 대한 reference 를 저장할수 있게 한다.
		 */
		public static function init(refer : DisplayObject) : void {
			root = refer.root;
			stage = refer.stage;
		}
	}
}
