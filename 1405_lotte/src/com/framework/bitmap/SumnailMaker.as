/*
draw date : 20080402 drew
drawing : dragmove
contact : dragmove@hotmail.com

redraw date : 
redraw person : 
redraw detail : 

========================================

::::::::  Class 기능 Description ::::::::

+ 부가설명 : 
로드할 이미지의 url, 로드한 이미지를 이용하여 생성할 sumnail의 width값, height값의 3가지 정보를 이용하여
해당 크기의 sumnail Bitmap 을 생성합니다.

+ Event 정보 :
- 이미지 로드 중 발생하는 이벤트
이미지 load 과정 중 loading bar 등의 외부 구현을 위해, contentLoaderInfo 속성의 접근 경로를 제공합니다.

- sumnail 생성 완료시 발생하는 이벤트
SumnailMaker.COMPLETE 이벤트 발생
(생성 완료된 sumnail의 외부 이용을 위해, sumnail 속성의 접근 경로를 제공합니다.)


메서드설명 :
- 1. 메서드명(파라미터와 리턴값 정보 포함하여 정리)


::::::::  Class 사용 Sample  ::::::::

import dragmove_AS3.bitmap.SumnailMaker;
import flash.display.LoaderInfo;
import flash.events.ProgressEvent;
import flash.events.Event;

var bmp_width:Number = 127//image_frame_mc.mask_sumnail.width;
var bmp_height:Number = 116//image_frame_mc.mask_sumnail.height;

var sumnail_info:SumnailMaker = new SumnailMaker("http://www.dragmove.com/test_starcity/img/dragmove_1_img.png", bmp_width, bmp_height);
sumnail_info.addEventListener(SumnailMaker.COMPLETE, onLoadComplete_hd);

var sumnail_Loader:LoaderInfo = sumnail_info.contentLoaderInfo;
sumnail_Loader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress_hd);

// 이미지 로드 진행률 체크
function onLoadProgress_hd(e:ProgressEvent):void {
	trace("e.bytesLoaded :", e.bytesLoaded);
	trace("e.bytesTotal :", e.bytesTotal);
}

// sumnail 생성 완료 이벤트 발생, 완성된 sumnail을 이용할 수 있다.
function onLoadComplete_hd(e:Event):void {
	var sumnail_bmp:Bitmap = e.target.sumnailBmp
	
	sumnail_bmp.x = 11;
	sumnail_bmp.y = 10;
	image_frame_mc.addChild(sumnail_bmp);
	sumnail_bmp.mask = image_frame_mc.mask_sumnail;
	
	sumnail_info = null;
	// e.target = null;
	trace(sumnail_info);
}

 */
package com.framework.bitmap {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	public class SumnailMaker extends Loader {
		// public static var PROGRESS:String = "progress_sumnail_maker";
		static public var COMPLETE : String = "complete_sumnail_maker";
		private var url_Request : URLRequest = new URLRequest();
		private var loaded_bmpData : DisplayObject;
		// 로드된 bitmap 데이터
		private var sumnail_width : Number;
		// 로드한 bmp 이미지를 붙일 width 크기
		private var sumnail_height : Number;
		// 로드한 bmp 이미지를 붙일 height 크기
		private var sumnail_bmpData : BitmapData;
		// sumnail BitmapData
		private var sumnail_bmp : Bitmap;
		// 완성된 sumnail Bitmap
		private var load_img_flag : Boolean = false;

		// 로드하는 이미지의 로드 완료 여부
		// SumnailMaker 클래스 외부에서, 로드되는 이미지의 로드 진행 이벤트를 이용하여,
		// 별도의 기능을 구현할 수 있도록 contentLoaderInfo 속성을 제공합니다.
		public function get Loader_info() : LoaderInfo {
			return this.contentLoaderInfo;
		}

		// SumnailMaker 클래스 내부에서 완성된 sumnail_bmp를 참조할 수 있는 경로를 제공합니다.
		public function get sumnailBmp() : Bitmap {
			return sumnail_bmp;
		}

		// Sumnail 이미지를 생성하기 위한 source 이미지의 로드 완료 여부 정보를 제공합니다.
		public function get img_loadComplete_flag() : Boolean {
			return load_img_flag;
		}

		// 생성자
		public function SumnailMaker(link_img_url : String, trg_width : Number, trg_height : Number) : void {
			sumnail_width = trg_width;
			// sumnail 이미지의 width 값
			sumnail_height = trg_height;
			// sumnail 이미지의 height 값

			// trace("만들 sumnail 이미지의 width값 :", sumnail_width);
			// trace("만들 sumnail 이미지의 height값 :", sumnail_height);

			url_Request.url = link_img_url;
			this.load(url_Request);

			// img_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress_hd);
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete_hd);
		}

		public function destroy() : void {
			// sumnail_width = null;
			// sumnail_height = null;

			sumnail_bmpData.dispose();
			sumnail_bmpData = null;
			sumnail_bmp = null;
		}

		public function makeSumnail(link_img_url : String, trg_width : Number, trg_height : Number) : void {
			sumnail_width = trg_width;
			// sumnail 이미지의 width 값
			sumnail_height = trg_height;
			// sumnail 이미지의 height 값

			url_Request.url = link_img_url;
			// trace("url_Request.url :", url_Request.url);

			this.load(url_Request);
		}

		/*
		// 이미지 LoadProgress 핸들러
		private function onLoadProgress_hd(e:ProgressEvent):void {
		// var percent:Number = int(e.bytesLoaded / e.bytesTotal * 100.0) ;
		}
		 */
		// 이미지 LoadComplete 핸들러
		private function onLoadComplete_hd(e : Event) : void {
			loaded_bmpData = e.target.content;
			// 로드된 비트맵을 저장한다.

			// trace(loaded_bmpData.width); // 로드한 비트맵의 width값
			// trace(loaded_bmpData.height); // 로드한 비트맵의 height값

			// 생성하려는 sumnail 이미지 크기의 BitmapData 생성
			sumnail_bmpData = new BitmapData(sumnail_width, sumnail_height);

			// 로드된 BitmapData의 실제 width, height 대비 sumnail width, height 크기가 큰 쪽에 맞춰 썸네일 크기 조절, 중앙 정렬 프로세스 진행
			var max_scale : Number = Math.max(sumnail_width / loaded_bmpData.width, sumnail_height / loaded_bmpData.height);

			var trans_x : Number = (max_scale * loaded_bmpData.width - sumnail_width) / 2;
			var trans_y : Number = (max_scale * loaded_bmpData.height - sumnail_height) / 2;

			// sumnail 크기 조절 후, 중앙 정렬을 위한 matrix 생성
			var trans_mat : Matrix = new Matrix();
			trans_mat.scale(max_scale, max_scale);
			trans_mat.translate(-trans_x, -trans_y);

			// matrix 정보를 이용하여 sumnail_bmpData에 로드된 비트맵을 그려준다.
			sumnail_bmpData.draw(loaded_bmpData, trans_mat);

			// 만들어진 sumnail_bmpData를 Bitmap 데이터로 생성하여, 외부에서 참조할 수 있도록 한다.
			sumnail_bmp = new Bitmap(sumnail_bmpData);

			// addChild(bitmap);
			// img_loader = null;
			url_Request = null;

			// dispatchEvent(new Event(SumnailMaker.COMPLETE));

			shout_loadComplete();
		}

		// sumnail의 생성이 끝났음을 알린다.
		private function shout_loadComplete() : void {
			load_img_flag = true;
			dispatchEvent(new Event(SumnailMaker.COMPLETE));
		}
	}
}