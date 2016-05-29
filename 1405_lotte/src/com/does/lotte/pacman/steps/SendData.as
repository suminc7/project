package com.does.lotte.pacman.steps {
	import com.framework.string.StringUtils;
	import com.does.lotte.global.User;
	import com.framework.serialization.json.JSON;
	import com.does.lotte.global.Score;

	import flash.net.URLRequestMethod;

	import com.framework.math.Rnd;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.LoaderMax;

	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * @author chaesumin
	 */
	public class SendData {
		private static var insertScore : DataLoader;
		private static var eventSubmit : DataLoader;

		public static function load(callback : Function) : void {
			if (ExternalInterface.objectID) {
				var url : String = ExternalInterface.call("GAME.insertURL");

				var request : URLRequest = new URLRequest(url);
				var variables : URLVariables = new URLVariables();
				variables.score1 = Score.stage1Score;
				variables.score2 = Score.stage2Score;
				variables.score3 = Score.stage3Score;
				variables.totalscore = Score.totalScore;
				request.data = variables;
				request.method = URLRequestMethod.POST;

				insertScore = new DataLoader(request, {name:"score", onComplete:onComplete});
				insertScore.load();
			}

			function onComplete(event : LoaderEvent) : void {
				var binary : String = LoaderMax.getContent("score");

				var obj : Object = JSON.decode(binary);

				Score.bestScore = int(obj.mybestscore);
				callback.call();

				// ExternalInterface.call("console.log", "mybestscore2:"+obj.mybestscore);
				// ExternalInterface.call(binary);
			}
		}
		
		public static function check(callback : Function) : void {
			if (ExternalInterface.objectID) {
				var url : String = ExternalInterface.call("GAME.checkURL");

				var request : URLRequest = new URLRequest(url);
				var variables : URLVariables = new URLVariables();
				variables.score1 = Score.stage1Score;
				variables.score2 = Score.stage2Score;
				variables.score3 = Score.stage3Score;
				variables.totalscore = Score.totalScore;
				request.data = variables;
				request.method = URLRequestMethod.POST;

				insertScore = new DataLoader(request, {name:"score", onComplete:onComplete});
				insertScore.load();
			}

			function onComplete(event : LoaderEvent) : void {
				//var binary : String = LoaderMax.getContent("score");

//				var obj : Object = JSON.decode(binary);
//
//				Score.bestScore = int(obj.mybestscore);
				callback.call();

				// ExternalInterface.call("console.log", "mybestscore2:"+obj.mybestscore);
				// ExternalInterface.call(binary);
			}
		}

		public static function event(eventName : String, eventPhone1 : String, eventPhone2 : String, eventPhone3 : String, callback : Function) : void {
			if (ExternalInterface.objectID) {
				var url : String = ExternalInterface.call("GAME.joinEventSubmitURL");

				var request : URLRequest = new URLRequest(url);
				var variables : URLVariables = new URLVariables();
				variables.userName = eventName;
				variables.userPhone1 = eventPhone1;
				variables.userPhone2 = eventPhone2;
				variables.userPhone3 = eventPhone3;
				variables.device = "m";
				request.data = variables;
				request.method = URLRequestMethod.POST;

				eventSubmit = new DataLoader(request, {name:"event", onComplete:onComplete});
				eventSubmit.load();
			}

			function onComplete(event : LoaderEvent) : void {
				var binary : String = LoaderMax.getContent("event");
				var str : String = StringUtils.jsonpToJson(binary);
				var obj : Object = JSON.decode(str);
				
				ExternalInterface.call(binary);
				callback.call(null, obj);

			}
		}

		public static function updateStatus(message : String, callback : Function) : void {
			ExternalInterface.addCallback("updateStatusComplete", onComplete);
			ExternalInterface.call("GAME.updateStatus", message);

			function onComplete(data : String) : void {
				var obj : Object = JSON.decode(data);
				if (obj['result'] == "success") {
					callback.call(null, obj);
				}
			}
		}

		public static function inviteFriend(id : String, name : String, callback : Function) : void {
			ExternalInterface.addCallback("sendFeedComplete", onComplete);
			ExternalInterface.call("GAME.sendFeed", id, name);

			function onComplete(data : String) : void {
				var obj : Object = JSON.decode(data);
				if (obj['data']) {
					callback.call(null, obj);
				}
			}
		}
	}
}
