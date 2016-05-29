package com.framework.youtube {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;

	public class YoutubePlayer extends Sprite {
		var player : Object;
		// the object wich will have the player loaded to
		var loader : Loader;
		// the loader wich will load the player
		var id : String;
		// the video's id
		var _width : Number;
		// the video's id
		var _height : Number;
		// the video's id
		var title : String;
		// the video's id
		var playerStatus : String;
		// returns the players current playing status
		var playerStartBytes : Number;
		// returns the players current playing status
		var progressRatio : Number;
		// returns the ratio difference between the bytes loaded and the bytes total, from 0 to 1, (usefull for the progress bar)
		var fullnessRatio : Number;
		// returns the ratio difference between the playhead and the total seconds, from 0 to 1, (usefull for the fullness bar)
		var startRatio : Number;
		// returns the ratio difference between the playhead and the total seconds, from 0 to 1, (usefull for the fullness bar)
		var ismuted : Boolean;

		// returns true if player is muted
		/*
		example
		player = new YoutubePlayer(Path.youtube01_1, 520, 415);
		player.x = 206;
		player.y = 51;
		addChild(player);
		  
		  
		- reload
		player.loadVideoById(Path.youtube01_3);
		 
		- stopvideo
		player.stopVideo();
		 
		 */
		public function YoutubePlayer($id = "GI6CfKcMhjY", $width = 400, $height = 300) {
			Security.allowDomain("www.youtube.com");
			// allow access from youtube
			id = $id;
			_width = $width;
			_height = $height;
			title = "";
			loader = new Loader();
			// instanciates the loader
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
			// After loading, calls onLoaderInit
			loader.load(new URLRequest("http://www.youtube.com/v/" + id + "&version=3&autohide=0"));
			// starts loading process
		}

		private function onLoaderInit(event : Event) : void {
			addChild(loader);
			trace('loader: ' + (loader.parent.parent));
			// adds the loader to stage
			loader.content.addEventListener("onReady", onPlayerReady);
			// called when the player is ready
			loader.content.addEventListener("onError", onPlayerError);
			// called when the player has errors
			loader.content.addEventListener("onStateChange", onPlayerStateChange);
			// called when the playing state is changed
		}

		private function onPlayerReady(event : Event) : void {
			player = loader.content;
			// sets the player
			player.setSize(_width, _height);
			// sets the dispplay size
			player.loadVideoById(id);
			// loads the video by the id
			addEventListener(Event.ENTER_FRAME, updatePlayer);
			// updates the player
			dispatchEvent(new YoutubeStatusEvent(YoutubeStatusEvent.PLAYERSTATUS, true, "onReady"));
		}

		private function onPlayerError(event : Event) : void {
			// trace("player error:", Object(event).data);
			dispatchEvent(new YoutubeStatusEvent(YoutubeStatusEvent.PLAYERSTATUS, true, "onError"));
		}

		private function onPlayerStateChange(event : Event) : void {
			// trace("player state:", Object(event).data);
			// dispatchEvent(new YoutubeStatusEvent(YoutubeStatusEvent.PLAYERSTATUS, true, "onStateChange"));
		}

		// Wrappers for outside controlling
		public function setSize($width : Number, $height : Number) : void {
			player.setSize(width, height);
		}

		public function loadVideoById($id : String) : void {
			id = $id;
			player.loadVideoById(id);
		}

		public function playVideo() {
			player.playVideo();
			addEventListener(Event.ENTER_FRAME, updatePlayer);
		}

		public function pauseVideo() {
			if (player) player.pauseVideo();
		}

		public function stopVideo() {
			if (player) player.stopVideo();
			removeEventListener(Event.ENTER_FRAME, updatePlayer);
		}

		public function muteVideo() {
			player.mute();
		}

		public function unmuteVideo() {
			player.unMute();
		}

		public function setSeek(ratio : Number) {
			var time : Number = player.getDuration() * ratio;
			player.seekTo(time, true);
			addEventListener(Event.ENTER_FRAME, updatePlayer);
		}

		public function setVolume(ratio : Number) {
			player.setVolume(ratio);
		}

		public function getVideoStartBytes() : Number {
			return player.getVideoStartBytes();
		}

		public function getVideoEmbedCode() : String {
			return player.getVideoEmbedCode();
		}

		public function getVolume() : Number {
			return player.getVolume();
		}

		public function getVideoBytesTotal() : Number {
			return player.getVideoBytesTotal();
		}

		public function getPlaybackQuality() : String {
			return player.getPlaybackQuality();
		}

		public function getCurrentTime() : String {
			return player.getCurrentTime();
		}

		public function setPlaybackQuality($suggestedQuality : String) {
			player.setPlaybackQuality($suggestedQuality);
		}

		public function destroy() {
			removeEventListener(Event.ENTER_FRAME, updatePlayer);
			if (player) player.stopVideo();
			if (player) player.destroy();
		}

		public function share($snsName : String) {
			switch($snsName) {
				case "twitter":
					navigateToURL(new URLRequest("http://twitter.com/intent/tweet?text=" + title + "&url=http://youtu.be/" + id));
					break;
				case "facebook":
					navigateToURL(new URLRequest("http://www.facebook.com/sharer.php?u=http://youtu.be/" + id));
					break;
				case "blogger":
					navigateToURL(new URLRequest("http://www.blogger.com/blog-this.g?n=" + title + "&source=youtube&b=%3Cobject%20width%3D%22425%22%20height%3D%22344%22%3E%3Cparam%20name%3D%22movie%22%20value%3D%22http%3A//www.youtube.com/v/" + id + "%3Ffs%3D1%26hl%3Dko_KR%22%3E%3C/param%3E%3Cparam%20name%3D%22allowFullScreen%22%20value%3D%22true%22%3E%3C/param%3E%3Cparam%20name%3D%22allowscriptaccess%22%20value%3D%22always%22%3E%3C/param%3E%3Cembed%20src%3D%22http%3A//www.youtube.com/v/" + id + "%3Ffs%3D1%26hl%3Dko_KR%22%20type%3D%22application/x-shockwave-flash%22%20width%3D%22425%22%20height%3D%22344%22%20allowscriptaccess%3D%22always%22%20allowfullscreen%3D%22true%22%3E%3C/embed%3E%3C/object%3E&eurl=http://i4.ytimg.com/vi/" + id + "/hqdefault.jpg"));
					break;
				case "myspace":
					navigateToURL(new URLRequest("http://www.myspace.com/Modules/PostTo/Pages/?t=" + title + "&c=%3Cobject%20width%3D%22425%22%20height%3D%22344%22%3E%3Cparam%20name%3D%22movie%22%20value%3D%22http%3A//www.youtube.com/v/" + id + "%3Ffs%3D1%26hl%3Dko_KR%22%3E%3C/param%3E%3Cparam%20name%3D%22allowFullScreen%22%20value%3D%22true%22%3E%3C/param%3E%3Cparam%20name%3D%22allowscriptaccess%22%20value%3D%22always%22%3E%3C/param%3E%3Cembed%20src%3D%22http%3A//www.youtube.com/v/" + id + "%3Ffs%3D1%26hl%3Dko_KR%22%20type%3D%22application/x-shockwave-flash%22%20width%3D%22425%22%20height%3D%22344%22%20allowscriptaccess%3D%22always%22%20allowfullscreen%3D%22true%22%3E%3C/embed%3E%3C/object%3E&u=http%3A//www.youtube.com/watch%3Fv%3D" + id + "&l=1"));
					break;
				case "orkut":
					navigateToURL(new URLRequest("http://www.orkut.com/FavoriteVideos.aspx?u=http://www.youtube.com/watch?v=" + id));
					break;
				case "livespaces":
					navigateToURL(new URLRequest("http://spaces.live.com/BlogIt.aspx?SourceURL=http://www.youtube.com/watch?v=" + id + "&description=%3Cobject%20width%3D%22425%22%20height%3D%22344%22%3E%3Cparam%20name%3D%22movie%22%20value%3D%22http%3A//www.youtube.com/v/" + id + "%3Ffs%3D1%26hl%3Dko_KR%22%3E%3C/param%3E%3Cparam%20name%3D%22allowFullScreen%22%20value%3D%22true%22%3E%3C/param%3E%3Cparam%20name%3D%22allowscriptaccess%22%20value%3D%22always%22%3E%3C/param%3E%3Cembed%20src%3D%22http%3A//www.youtube.com/v/" + id + "%3Ffs%3D1%26hl%3Dko_KR%22%20type%3D%22application/x-shockwave-flash%22%20width%3D%22425%22%20height%3D%22344%22%20allowscriptaccess%3D%22always%22%20allowfullscreen%3D%22true%22%3E%3C/embed%3E%3C/object%3E"));
					break;
				case "buzz":
					navigateToURL(new URLRequest("http://www.google.com/buzz/post?url=http://www.youtube.com/watch?v=" + id));
					break;
				case "stumbleupon":
					navigateToURL(new URLRequest("http://www.stumbleupon.com/submit?url=http://www.youtube.com/watch?v=" + id));
					break;
				case "cyworld":
					navigateToURL(new URLRequest("http://api.cyworld.com/openscrap/video/v1/?vu=http://www.youtube.com/watch?v=" + id));
					break;
				case "digg":
					navigateToURL(new URLRequest("http://digg.com/submit?phase=2&url=http://www.youtube.com/watch?v=" + id));
					break;
				case "me2day":
					navigateToURL(new URLRequest("http://me2day.net/plugins/post/new?new_post[body]=" + title + "http://youtu.be/" + id));
					break;
				case "yozm":
					navigateToURL(new URLRequest("http://yozm.daum.net/api/popup/prePost?prefix=" + title + "&link=http://youtu.be/" + id));
					break;
			}
		}

		public function updatePlayer(e) {
			ismuted = player.isMuted() ;
			// returns true if muted
			// sets the progress ratio
			progressRatio = player.getVideoBytesLoaded() / player.getVideoBytesTotal();
			startRatio = player.getVideoStartBytes() / player.getVideoBytesTotal();
			// sets the fullness ratio
			fullnessRatio = player.getCurrentTime() / player.getDuration();
			dispatchEvent(new YoutubeStatusEvent(YoutubeStatusEvent.PLAYERSTATUS, true, player.getPlayerState(), progressRatio, fullnessRatio, player.getVolume()));
			// sets the playerStatus for outside use
			switch(player.getPlayerState()) {
				case -1:
					playerStatus = "unstarted";
					break;
				case 0:
					playerStatus = "ended";
					break;
				case 1:
					playerStatus = "playing";
					break;
				case 2:
					playerStatus = "paused";
					break;
			}
			// trace("player.getVideoStartBytes() : " +player.getVideoStartBytes(),player.getVideoBytesTotal(),player.getVideoBytesLoaded() );
			playerStartBytes = player.getVideoStartBytes();
		}
	}
}