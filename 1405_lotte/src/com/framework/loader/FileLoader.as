package com.framework.loader {
	import flash.display.Bitmap;

	import com.framework.events.FileLoaderEvent;

	import flash.display.DisplayObject;
	import flash.net.FileFilter;
	import flash.display.Loader;
	import flash.events.SecurityErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.net.FileReference;

	/**
	 * @author suminc7
	 */
	public class FileLoader extends FileReference {
		private var loader : Loader;

		public function FileLoader() {
			initFile();
		}

		private function initFile() : void {
			addEventListener(Event.SELECT, selectHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			addEventListener(Event.OPEN, openHandler);
			addEventListener(ProgressEvent.PROGRESS, progressHandler);
			addEventListener(Event.COMPLETE, completeHandler);
		}

		private function selectHandler(event : Event) : void {
			load();
		}

		private function openHandler(event : Event) : void {
		}

		private function progressHandler(event : ProgressEvent) : void {
		}

		private function completeHandler(event : Event) : void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileLoadComplete);
			loader.loadBytes(data);
		}

		private function fileLoadComplete(event : Event) : void {
			var bitmap : Bitmap = loader.content as Bitmap;
			bitmap.smoothing = true;
			dispatchEvent(new FileLoaderEvent(FileLoaderEvent.FILE_LOAD_COMPLETE, false, bitmap));
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
		}

		private function getImageTypeFilter() : Array {
			return new Array(new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png"));
		}

		public function browseFile() : void {
			browse(getImageTypeFilter());
		}
	}
}
