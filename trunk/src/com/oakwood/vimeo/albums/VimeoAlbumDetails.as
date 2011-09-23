package com.oakwood.vimeo.albums {
	import com.oakwood.vimeo.common.VimeoVideoDetails;
	import com.oakwood.vimeo.common.VimeoThumbnail;
	/**
	 * @author JBecker
	 */
	public class VimeoAlbumDetails {
		
		private var _id:String;
		private var _title:String;
		private var _description:String;
		private var _created_on:String;
		private var _total_vids:int;
		private var _url:String;
		private var _thumbnail_video_id:String;
		private var _thumbnail_video_title:String;
		private var _thumbnail_small: VimeoThumbnail;
		private var _thumbnail_medium : VimeoThumbnail;
		private var _thumbnail_large : VimeoThumbnail;
		private var _contents:Vector.<VimeoVideoDetails> = new Vector.<VimeoVideoDetails>;

		public function VimeoAlbumDetails(id:String="",t:String="",d:String="",c:String="",vid:int=0,url:String="",vid_id:String="",vid_title:String="",t_s:VimeoThumbnail=null,t_m:VimeoThumbnail=null,t_l:VimeoThumbnail=null) 
		{
			_id = id;
			_title = t;
			_description = d;
			_created_on = c;
			_total_vids = vid;
			_url = url;
			_thumbnail_video_id = vid_id;
			_thumbnail_video_title = vid_title;
			_thumbnail_small = t_s;
			_thumbnail_medium = t_m;
			_thumbnail_large = t_l;
		}

		public function get title() : String {
			return _title;
		}

		public function set title(title : String) : void {
			_title = title;
		}

		public function get description() : String {
			return _description;
		}

		public function set description(description : String) : void {
			_description = description;
		}

		public function get created_on() : String {
			return _created_on;
		}

		public function set created_on(created_on : String) : void {
			_created_on = created_on;
		}

		public function get total_vids() : int {
			return _total_vids;
		}

		public function set total_vids(total_vids : int) : void {
			_total_vids = total_vids;
		}

		public function get url() : String {
			return _url;
		}

		public function set url(url : String) : void {
			_url = url;
		}

		public function get thumbnail_video_id() : String {
			return _thumbnail_video_id;
		}

		public function set thumbnail_video_id(thumbnail_video_id : String) : void {
			_thumbnail_video_id = thumbnail_video_id;
		}

		public function get thumbnail_small() : VimeoThumbnail {
			return _thumbnail_small;
		}

		public function set thumbnail_small(thumbnail_sml : VimeoThumbnail) : void {
			_thumbnail_small = thumbnail_sml;
		}

		public function get thumbnail_medium() : VimeoThumbnail {
			return _thumbnail_medium;
		}

		public function set thumbnail_medium(thumbnail_medium : VimeoThumbnail) : void {
			_thumbnail_medium = thumbnail_medium;
		}

		public function get thumbnail_large() : VimeoThumbnail {
			return _thumbnail_large;
		}

		public function set thumbnail_large(thumbnail_large : VimeoThumbnail) : void {
			_thumbnail_large = thumbnail_large;
		}

		public function get id() : String {
			return _id;
		}

		public function set id(id : String) : void {
			_id = id;
		}

		public function get contents() : Vector.<VimeoVideoDetails> {
			return _contents;
		}

		public function set contents(contents : Vector.<VimeoVideoDetails>) : void {
			_contents = contents;
		}
		
		
	}
}
