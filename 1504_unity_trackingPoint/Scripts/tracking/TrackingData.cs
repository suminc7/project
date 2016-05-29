using UnityEngine;
using System;
using System.Collections.Generic;

namespace tracking {

	public struct CheckFrames { 
		public int firstFrame; 
		public int lastFrame; 
	} 

	public struct TrackPosition { 
		public int frame;
		public float x;
		public float y;
	} 
	
	public class TrackingData {

		private float currentFrame;

		private List<List<TrackPosition>> trackingList;
		private List<CheckFrames> checkFrames;


		public TrackingData () {
			trackingList = new List<List<TrackPosition>>();
			checkFrames = new List<CheckFrames> ();
		}

		public void LoadData(string[] txtFiles){
			for (int i = 0; i < txtFiles.Length; i++) {

				TextAsset txt = (TextAsset)Resources.Load(txtFiles[i], typeof(TextAsset));
				string content = txt.text;
				string[] arr = content.Split(new string[] {"\n"}, System.StringSplitOptions.None);

				List<TrackPosition> list = new List<TrackPosition>();

				int j;
				for (j = 0; j < arr.Length; j++) {

					string[] split = arr[j].Split(new string[] {"\t"}, System.StringSplitOptions.RemoveEmptyEntries);

					TrackPosition position = new TrackPosition();
					position.frame = int.Parse(split[0]);
					position.x = float.Parse(split[1]);
					position.y = float.Parse(split[2]);
					list.Add(position);
					
				}
				trackingList.Add(list);
				int firstFrame = trackingList[i][0].frame;
				int lastFrame = trackingList[i][j-1].frame;
				Debug.Log(firstFrame);
				Debug.Log(lastFrame);

				CheckFrames frames = new CheckFrames();
				frames.firstFrame = firstFrame;
				frames.lastFrame = lastFrame;
				checkFrames.Add(frames);

			}
		}


		public List<TrackPosition> Process(double playPosition){


			double f = playPosition * 15;
			float frame = Mathf.Floor((float)f);

			List<TrackPosition> list = new List<TrackPosition>();

			if (frame != currentFrame) {

				for (int i = 0; i < trackingList.Count; i++) {
					
					int firstFrame = checkFrames[i].firstFrame;
					int lastFrame = checkFrames[i].lastFrame;
					
					int startFrame = (int)frame - firstFrame;
					int endFrame = (int)frame - lastFrame;
					
					if (-1 < startFrame && frame <= lastFrame) {
						TrackPosition position = (TrackPosition)trackingList[i][startFrame];
						list.Add(position);
					}

				}

				currentFrame = frame;
			}



			return list;

		}


	}
}

