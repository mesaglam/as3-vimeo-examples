package com.oakwood.vimeo.common {
	/**
	 * Holds the details for each video. 
	 * 
	 * 
	//************************
	//************************
	// AT THE MOMENT THERE IS NO WAY TO GET THE DIRECT LINK TO THE VIDEO RETURNED BY THE API
	// SO WE HAVE TO PASTE THE LINK INTO THE DESCRIPTION FIELD OF EACH VIDEO MANUALLY, THEN WE CAN ACCESS IT
	//************************
	//************************
	 * 
	 * @author JBecker
	 */
	public class VimeoVideoDetails 
	{
		
		private var _id:String;
		private var _title:String;
		private var _description:String;
		private var _uploadDate:String;
		private var _modifiedDate:String;
		private var _likes:int;
		private var _plays:int;
		private var _comments:int;
		private var _width:Number;
		private var _height:Number;
		private var _duration:Number;
		private var _tags:Array =[];
		private var _videoURL:String;
		private var _mobileURL:String;
		private var _thumbnail_small: VimeoThumbnail;
		private var _thumbnail_medium : VimeoThumbnail;
		private var _thumbnail_large : VimeoThumbnail;

		public function VimeoVideoDetails(xml:XML = null) 
		{
			if(xml != null)
				populateFromXML(xml);
		}

		public function populateFromXML(xml:XML) : void 
		{
			_id = xml.@id;
			_title = xml.title;
			_description = xml.description;
			_uploadDate = xml.upload_date;
			_modifiedDate = xml.modified_date;
			_likes = int(xml.number_of_likes);
			_plays = int(xml.number_of_plays);
			_comments = int(xml.number_of_comments);
			_width = Number(xml.width);
			_height = Number(xml.height);
			_duration = Number(xml.duration);
			
			var tagList:XMLList = xml.tags;
			for each(var node:XML in tagList.*)
			{
				_tags.push(node);
			}
			
			_videoURL = xml.urls.url.(@type == "video");
			_mobileURL = xml.urls.url.(@type == "mobile");
			
			var arr:Array = ["small","medium","large"];
			var n:int =0;
			var thumbnails:XML =  XML(xml.thumbnails);

			for each( var thumb:XML in thumbnails.*)
			{

				//create the thumbnail objects to be added to this VimeoAlbumDetails object
				
				//************************
				//************************
				// AT THE MOMENT THERE IS NO WAY TO GET THE DIRECT LINK TO THE VIDEO RETURNED BY THE API
				// SO WE HAVE TO PASTE THE LINK INTO THE DESCRIPTION FIELD OF EACH VIDEO MANUALLY, THEN WE CAN ACCESS IT
				//************************
				//************************
				
				this["_thumbnail_"+arr[n]] = new VimeoThumbnail(VimeoThumbnail.TYPE_ALBUM, _description, Number(thumb.@height),Number(thumb.@width),thumb);
				n++;

			}

		}

		public function get id() : String {
			return _id;
		}

		public function set id(id : String) : void {
			_id = id;
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

		public function get uploadDate() : String {
			return _uploadDate;
		}

		public function set uploadDate(uploadDate : String) : void {
			_uploadDate = uploadDate;
		}

		public function get modifiedDate() : String {
			return _modifiedDate;
		}

		public function set modifiedDate(modifiedDate : String) : void {
			_modifiedDate = modifiedDate;
		}

		public function get likes() : int {
			return _likes;
		}

		public function set likes(likes : int) : void {
			_likes = likes;
		}

		public function get plays() : int {
			return _plays;
		}

		public function set plays(plays : int) : void {
			_plays = plays;
		}

		public function get comments() : int {
			return _comments;
		}

		public function set comments(comments : int) : void {
			_comments = comments;
		}

		public function get width() : Number {
			return _width;
		}

		public function set width(width : Number) : void {
			_width = width;
		}

		public function get height() : Number {
			return _height;
		}

		public function set height(height : Number) : void {
			_height = height;
		}

		public function get duration() : Number {
			return _duration;
		}

		public function set duration(duration : Number) : void {
			_duration = duration;
		}

		public function get tags() : Array {
			return _tags;
		}

		public function set tags(tags : Array) : void {
			_tags = tags;
		}

		public function get videoURL() : String {
			return _videoURL;
		}

		public function set videoURL(videoURL : String) : void {
			_videoURL = videoURL;
		}

		public function get mobileURL() : String {
			return _mobileURL;
		}

		public function set mobileURL(mobileURL : String) : void {
			_mobileURL = mobileURL;
		}

		public function get thumbnail_small() : VimeoThumbnail {
			return _thumbnail_small;
		}

		public function set thumbnail_small(thumbnail_small : VimeoThumbnail) : void {
			_thumbnail_small = thumbnail_small;
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
		
	}
}
