package com.oakwood.vimeo.common {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * @author JBecker
	 */
	public class VimeoThumbnail extends Sprite
	{
		public static const TYPE_ALBUM:String = "TYPE_ALBUM";
		public static const TYPE_VIDEO:String = "TYPE_VIDEO";
	
		public static const SML_HEIGHT:Number = 75;
		public static const SML_WIDTH:Number = 100;
		
		public static const MID_HEIGHT:Number = 150;
		public static const MID_WIDTH:Number = 200;
		
		public static const LRG_HEIGHT:Number = 360;
		public static const LRG_WIDTH:Number = 640;
			

		private var _url:String;
		private var _imgLoader:Loader;
		private var _thumbHeight:Number;
		private var _thumbWidth:Number;
		private var _id:String;
		private var _type:String;
		
		public function VimeoThumbnail(type:String="",id:String="", h:Number=0, w:Number=0, url:String="",load:Boolean = false ) 
		{
			_id = id;
			_type = type;
			_thumbHeight = h;
			_thumbWidth = w;
			_url = url;
			if(load)loadBitmap();
		}

		public function loadBitmap() : void 
		{
			var urlReq:URLRequest = new URLRequest(_url);
			_imgLoader = new Loader();
			_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, bitmapLoaded);	
			_imgLoader.load(urlReq);
					
		}

		private function bitmapLoaded(event : Event) : void 
		{
			_imgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, bitmapLoaded);	
			addChild(_imgLoader.contentLoaderInfo.content);		
		}

		public function get url() : String {
			return _url;
		}

		public function set url(url : String) : void {
			_url = url;
		}

		public function get thumbHeight() : Number {
			return _thumbHeight;
		}

		public function set thumbHeight(thumbHeight : Number) : void {
			_thumbHeight = thumbHeight;
		}

		public function get thumbWidth() : Number {
			return _thumbWidth;
		}

		public function set thumbWidth(thumbWidth : Number) : void {
			_thumbWidth = thumbWidth;
		}

		public function get id() : String {
			return _id;
		}

		public function set id(id : String) : void {
			_id = id;
		}

		public function get type() : String {
			return _type;
		}

		public function set type(type : String) : void {
			_type = type;
		}
		
	}
}
