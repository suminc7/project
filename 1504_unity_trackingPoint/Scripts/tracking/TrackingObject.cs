using System;

namespace tracking
{
	public class TrackingObject
	{

		public int frame;
		public int x;
		public int y;

		public TrackingObject (string frame, string x, string y)
		{
			int.TryParse (frame, out this.frame);
			int.TryParse (x, out this.x);
			int.TryParse (y, out this.y);

		}
	}
}

