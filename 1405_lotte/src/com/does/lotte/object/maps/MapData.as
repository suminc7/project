package com.does.lotte.object.maps {
	import flash.geom.Point;

	/**
	 * @author chaesumin
	 */
	public class MapData {
		private static var nx : int;
		private static var ny : int;
		public static var fx : int = 13;
		public static var fy : int = 22;
		public static var bw : int = 40;
		public static var bh : Number = 25.3;

		public static function setTile(ntx : Number, nty : Number) : void {
			nx = ntx;
			ny = nty;
		}

		public static function getTilePosition(ax : Number, ay : Number) : Point {
			ax = ax - nx;
			ay = ay + ny;
			var tx : Number = fx + bw * (ay + ax);
			var ty : Number = fy + bh * (ay - ax);
			return new Point(tx, ty);
		}

		public static function getArrayPosition(x : Number, y : Number) : Point {
			var nx : Number = Math.round((x - fx) / bw) ;
			var ny : Number = Math.round((y - fy) / bh) ;

			var ax : int;
			var ay : int;

			for (var i : int = 0;i < ny;i++) {
				var by : int = ny - i;
				var bx : int = by - ny;

				if (by + bx == nx && by - bx == ny) {
					ay = by - 3;
					ax = bx + 11;
					break;
				}
			}

			return new Point(ax, ay);
		}
	}
}
