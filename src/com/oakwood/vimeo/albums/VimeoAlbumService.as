package com.oakwood.vimeo.albums {
	import com.oakwood.vimeo.common.VimeoRequest;
	import com.oakwood.vimeo.common.VimeoThumbnail;
	import com.oakwood.vimeo.common.VimeoVideoDetails;

	import org.osflash.signals.Signal;

	import flash.events.Event;
	import flash.net.URLLoader;

	/**
	 * @author      Jez Becker (jeremy.becker@oakwood-dc.com)
	 */
	public class VimeoAlbumService {
		
		public static const METHOD_ALL_ALBUMS:String = "METHOD_ALL_ALBUMS";
		public static const METHOD_LOADBYID:String = "METHOD_LOADBYID";
		
		public var allAlbums:Vector.<VimeoAlbumDetails> = new Vector.<VimeoAlbumDetails>;
		public var loadSignal:Signal = new Signal();
		private var url_xml_loader:URLLoader = new URLLoader();
		private var _xml:XML = new XML ;
		private var _selectedAlbum:VimeoAlbumDetails;
		private var _thumb_s:VimeoThumbnail;
		private var _thumb_m:VimeoThumbnail;
		private var _thumb_l:VimeoThumbnail;
		
		//
		public function VimeoAlbumService()
		{		
		}

		/**
		 * loads all albums associated with this user
		 */
		public function loadAllAlbums() : void {
			
			//build the request
			var _requestParams:Object = new Object();
			_requestParams["method"] = VimeoRequest.VIMEO_ALBUMS_GETALL;
			_requestParams["user_id"] = VimeoRequest.VIMEO_PARAMS_USERID;
			var vimReq:VimeoRequest = new VimeoRequest(_requestParams);

			url_xml_loader.load(vimReq.request);
			url_xml_loader.addEventListener(Event.COMPLETE, loadAllAlbums_parse);
		}

		public function loadAlbumByID(id:String) : void 
		{
			//build the request
			var _requestParams:Object = new Object();
			_requestParams["method"] = VimeoRequest.VIMEO_ALBUMS_GETVIDEOS;
			_requestParams["userid"] = VimeoRequest.VIMEO_PARAMS_USERID;
			_requestParams["album_id"] = id;
			_requestParams["full_response"] = "full";
			var vimReq:VimeoRequest = new VimeoRequest(_requestParams);
			_selectedAlbum = getAlbumByID(id);
			url_xml_loader.addEventListener(Event.COMPLETE, loadAlbumByID_parse);
			url_xml_loader.load(vimReq.request);
		}
		
		private function getAlbumByID(id:String) : VimeoAlbumDetails 
		{
			var n:int = allAlbums.length;
			while(n--)
				if(allAlbums[n].id == id) return allAlbums[n];
				
			return null;
		}

		private function loadAlbumByID_parse(event : Event) : void 
		{
			url_xml_loader.removeEventListener(Event.COMPLETE, loadAlbumByID_parse);
			_xml = new XML(event.target.data);
			var videosXML:XMLList = _xml.videos;
			for each(var videoXML:XML in videosXML.*)
			{
				 _selectedAlbum.contents.push (new VimeoVideoDetails(videoXML));
			}
			trace("album contents", _selectedAlbum.contents.length,_selectedAlbum.contents[0].thumbnail_small.url);
			
			loadSignal.dispatch(METHOD_LOADBYID,_selectedAlbum);
		}
		
		private function loadAllAlbums_parse(event:Event):void
		{
			url_xml_loader.removeEventListener(Event.COMPLETE, loadAllAlbums_parse);
			_xml = new XML(event.target.data);
			
			var albumsXML:XMLList = _xml.albums;
			var album:VimeoAlbumDetails;
			var arr:Array = ["s","m","l"];
			var n:int;
			var thumbnails:XML;
			
			
			for each( var albumXML:XML in albumsXML.*)
			{
				thumbnails =  XML(albumXML.thumbnail_video.thumbnails);
				n=0;
				for each( var thumb:XML in thumbnails.*)
				{
					//create the thumbnail objects to be added to this VimeoAlbumDetails object
					this["_thumb_"+arr[n]] = new VimeoThumbnail(VimeoThumbnail.TYPE_ALBUM, albumXML.@id, Number(thumb.@height),Number(thumb.@width),thumb);
					n++;
				}
				
				album = new VimeoAlbumDetails(albumXML.@id,
												albumXML.title,
												albumXML.description,
												albumXML.created_on,
												int(albumXML.totalvideos),
												albumXML.url,
												albumXML.thumbnail_video.@id,
												albumXML.thumbnail_video.title,
												_thumb_s,_thumb_m,_thumb_l);	
				
				allAlbums.push(album);
			}
			
			loadSignal.dispatch(METHOD_ALL_ALBUMS);
		}

		
	}
		

}

