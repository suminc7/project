package com.framework.xml {
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	import com.framework.system.SecurityUse;

	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class XMLParser {
		public static var xml : XML;
		private var func : Function;
		private var root : DisplayObject;

		public function XMLParser(func : Function, root : DisplayObject) {
			this.func = func;
			this.root = root;
			initXML();
		}

		private function initXML() : void {
			if (xml) {
				run();
			} else {
				var loader : XMLLoader = new XMLLoader(SecurityUse.getSwfParentPath(root) + "xml/data.xml", {name:"xml", onComplete:xmlLoadComplete});
				loader.load();
			}
		}

		private function xmlLoadComplete(event : Event) : void {
			xml = LoaderMax.getContent("xml");
			run();
		}

		private function run() : void {
			func();
		}

		public static function to(func : Function, root : DisplayObject) : XMLParser {
			return new XMLParser(func, root);
		}
	}
}
