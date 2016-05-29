package com.framework.utils {
	import flash.display.MovieClip;

	/**
	 * @author chaesumin
	 */
	public class MovieClipUtil {
		public static function stop(mc : MovieClip) : void {
			mc.addFrameScript(0, mcStop);
			mc.addFrameScript(mc.totalFrames - 1, mcStop);

			function mcStop() : void {
				mc.stop();
			}
		}
	}
}
