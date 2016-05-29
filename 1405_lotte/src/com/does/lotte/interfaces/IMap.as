package com.does.lotte.interfaces {
	import com.does.lotte.pacman.ui.TimerView;
	import com.does.lotte.object.character.Character;
	import com.does.lotte.pacman.ui.FriendsView;
	import com.does.lotte.pacman.ui.HeartView;
	import com.does.lotte.pacman.ui.ScoreView;

	/**
	 * @author chaesumin
	 */
	public interface IMap {
		function getMapData() : Array;

		function checkMap(ax : int, ay : int) : void;

		function setScoreView(view : ScoreView) : void;

		function setHeartView(heartView : HeartView) : void;

		function setFriendsView(view : FriendsView) : void;

		function setCharacter(char : Character) : void;

		function setTimerView(timerView : TimerView) : void;

		function startGame() : void;

	}
}
