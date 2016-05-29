package com.framework.color {
	/**
	 * @author suminc7
	 */
	public class ColorUtils {
		public static function lighten(color : Number, ratio : Number) : Number {
			var rgb : Object = getRGB(color);
			for (var ele in rgb) {
				rgb[ele] += (255 - rgb[ele]) * ratio;
			}
			return getHex(rgb.r, rgb.g, rgb.b);
		}

		public static function darken(color : Number, ratio : Number) : Number {
			var rgb : Object = getRGB(color);
			for (var ele in rgb) {
				rgb[ele] = rgb[ele] * (1 - ratio);
			}
			return (getHex(rgb.r, rgb.g, rgb.b));
		}

		public static function getHex(r : Number, g : Number, b : Number) : Number {
			var rgb : String = "0x" + (r < 16 ? "0" : "") + r.toString(16) + (g < 16 ? "0" : "") + g.toString(16) + (b < 16 ? "0" : "") + b.toString(16);
			return Number(rgb);
		}

		public static function getRGB(color : Number) : Object {
			var r = color >> 16 & 0xFF;
			var g = color >> 8 & 0xFF;
			var b = color & 0xFF;
			return {r:r, g:g, b:b};
		}

		public static function blend(color1 : Number, color2 : Number, ratio : Number) : Number {
			var rgb1 : Object = getRGB(color1);
			var rgb2 : Object = getRGB(color2);
			for (var ele in rgb1) {
				rgb1[ele] = rgb1[ele] + (rgb2[ele] - rgb1[ele]) * ratio;
				if (rgb1[ele] > 255) rgb1[ele] = 255;
				if (rgb1[ele] < 0) rgb1[ele] = 0;
			}
			return getHex(rgb1.r, rgb1.g, rgb1.b);
		}
	}
}
