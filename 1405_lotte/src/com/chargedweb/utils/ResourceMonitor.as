// //////////////////////////////////////////////////////////////////////////////
//
// Copyright 2009 Julius Loa | jloa@chargedweb.com
// All Rights Reserved.
// license: GNU {http://www.opensource.org/licenses/gpl-2.0.php}
// notice: just keep the header plz
//
// //////////////////////////////////////////////////////////////////////////////
package com.chargedweb.utils {
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;

	/**
	 * ResourceMonitor class provides the fps and used memory information
	 * represented in a textfield instance;
	 * @author Julius Lomako, Jloa
	 * @version 1.0
	 */
	public class ResourceMonitor extends Sprite {
		/** Current memory amount used by FlashPlayer [mb] */
		public var memory : Number = 0;
		/** Current fps value */
		public var fps : int = 0;
		/** The current average fps value according to the history records (if showFpsAVG=true)*/
		public var fpsAVG : int = 0;
		/** Shows the textfield with resource info [@default=true] */
		public var showText : Boolean = true;
		/** Shows the graph monitor [@default=false] */
		public var showGraph : Boolean = false;
		/** Shows the graph grid [@see graphStyle.gridColor] [@default=false] */
		public var showGrid : Boolean = false;
		/** Shows the average fps according to the history records [@default=false] */
		public var showFpsAVG : Boolean = false;
		/** 
		 * Defines the style to apply to the graph 
		 * Properties: {width:int,height:int,gridColor:uint,bgColor:uint, lineColor:uint,lineSize:int}
		 * [mind: works only if showGraph=true]
		 */
		public var graphStyle : Object = {width:80, height:40, gridColor:0xFFFFFF, bgColor:0x000000, lineColor:0xFFCC00, lineSize:2};
		private var info : String = "";
		private var tf : TextField;
		private var to : TextFormat = new TextFormat("Verdana", "9", 0x000000);
		private var frames : uint = 0;
		private var init : Boolean = true;
		private var graph : Sprite = new Sprite();
		private var graphFps : Sprite = new Sprite();
		private var fpsMax : uint = 0;
		private var historyLength : int = 0;
		private var history : Array;
		private var avg : Number;
		private var n : int;
		private var interval : uint;

		/**
		 * Constructor
		 * @param showText:Boolean shows the text info (if set true) or not (false) [@default=true]
		 * @param showGraph:Boolean shows the graphic monitor (if set true) or not (false) [@default=false]
		 * @param historyLength:int defines the max number of stored history records [@default=15]
		 */
		public function ResourceMonitor(showText : Boolean = true, showGraph : Boolean = false, historyLength : int = 15) {
			super();
			this.showText = showText;
			this.showGraph = showGraph;
			this.historyLength = historyLength;
		}

		// ////////////////////////////////////////
		//
		// PUBLIC
		//
		// ////////////////////////////////////////
		/**
		 * Inits the monitor
		 */
		public function monitor() : void {
			if (stage) {
				if (getChildByName("label")) removeChild(tf);
				if (getChildByName("graph")) removeChild(graph);
				clearInterval(interval);
				removeEventListener(Event.ENTER_FRAME, countFrames);

				initHistory();
				if (showText) {
					tf = new TextField();
					tf.name = "label";
					tf.defaultTextFormat = to;
					tf.width = graphStyle.width;
					tf.multiline = true;
					tf.selectable = false;
					tf.autoSize = TextFieldAutoSize.LEFT;
					addChild(tf);
				}
				if (showGraph) {
					graph.name = "graph";
					graph.graphics.beginFill(graphStyle.bgColor, 1);
					graph.graphics.moveTo(0, 0);
					graph.graphics.lineTo(graphStyle.width, 0);
					graph.graphics.lineTo(graphStyle.width, graphStyle.height);
					graph.graphics.lineTo(0, graphStyle.height);
					graph.graphics.lineTo(0, 0);
					graph.graphics.endFill();
					if (showGrid) {
						drawGrid();
					}
					addChild(graph);
					graph.addChild(graphFps);
					graph.visible = false;
				}
				interval = setInterval(monitorResources, 1000);
				addEventListener(Event.ENTER_FRAME, countFrames);
			} else {
				throw new Error("**ResourceMonitor ** class instance not found in the DisplayObject list. Use addChild() method before using the public monitor() method.", 0);
			}
		}

		/** 
		 * Returns the string representation of the class name, the current fps,mem values;
		 * @return String - string representation '[[ResourceMonitor memory: <i>memory<i> fps: <i>fps<i> fpsAVG: <i>fpsAVG<i>]'
		 */
		override public function toString() : String {
			return "[ResourceMonitor memory: " + memory + " fps: " + fps + " fpsAVG: " + fpsAVG + "]";
		}

		/** 
		 * TextField reference
		 */
		public function get label() : TextField {
			return tf;
		}

		// ////////////////////////////////////////
		//
		// PRIVATE
		//
		// ////////////////////////////////////////
		/** @private counts the fps, memory */
		private function monitorResources() : void {
			fpsMax = stage.frameRate;
			fps = (frames > fpsMax) ? fpsMax : frames;
			fpsAVG = countFpsAVG();
			frames = 0;
			memory = Math.floor(System.totalMemory / (1024 * 1024) * 100) / 100;
			if (fpsMax / fps < 2) {
				info = "MEM: " + memory + "mb</font><br/>FPS: " + fps + "/" + fpsMax;
			} else {
				info = "MEM: " + memory + "mb</font><br/>FPS: <font color='#DD0000'>" + fps + "</font>/" + fpsMax;
			}
			if (showFpsAVG) {
				info += "<br/>FPS AVG: " + fpsAVG;
			}
			if (showText) {
				tf.htmlText = info;
			}
			if (showGraph) {
				history.splice(0, 1);
				history.push({fps:fps, memory:memory});
				drawGraph();
			}
			if (init) {
				dispatchEvent(new Event(Event.INIT));
				init = false;
				graph.visible = true;
			} else {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		/** @private frame counter */
		private function countFrames(event : Event) : void {
			frames++;
		}

		/** @private draws the graph */
		private function drawGraph() : void {
			graph.y = (showText) ? int(tf.height + 1) : 0;
			graphFps.graphics.clear();
			graphFps.graphics.lineStyle(graphStyle.lineSize, graphStyle.lineColor, 1, true, "normal", CapsStyle.SQUARE, JointStyle.MITER, 3);
			for (var i : int = 0; i < history.length; i++) {
				if (i == 0) {
					graphFps.graphics.moveTo(0, (((history[i].fps > 0) ? history[i].fps : fpsMax) / fpsMax) * graphStyle.height);
				} else {
					graphFps.graphics.lineTo(Math.round((graphStyle.width / history.length) * i), (((history[i].fps > 0) ? history[i].fps : fpsMax) / fpsMax) * graphStyle.height);
				}
			}
			graphFps.graphics.endFill();
		}

		/** @private draws the graph grid */
		private function drawGrid() : void {
			for (var i : int = 0;i < historyLength;i++) {
				graph.graphics.lineStyle(1, graphStyle.gridColor, .3);
				graph.graphics.moveTo((graphStyle.width / historyLength) * i, 0);
				graph.graphics.lineTo((graphStyle.width / historyLength) * i, graphStyle.height);
				graph.graphics.endFill();
			}
		}

		/** @private creates the history array */
		private function initHistory() : void {
			history = new Array(historyLength);
			for (var i : int = 0;i < historyLength;i++) {
				history[i] = {fps:-1, memory:-1};
			}
		}

		/** @private maths the average fps value according to the history records */
		private function countFpsAVG() : Number {
			avg = 0;
			n = 0;
			for (var i : int = 0;i < historyLength;i++) {
				avg += (history[i].fps < 0) ? 0 : history[i].fps;
				if (history[i].fps < 0) {
					n++;
				}
			}
			return Math.round(avg / (historyLength - n));
		}
	}
}