package com.oakwood.vimeo.common {
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;

	import flash.net.URLRequest;

	/**
	 * 
	 * @author JBecker
	 */
	public class VimeoRequest{
		
		public static var VIMEO_BASE_URL:String = "http://vimeo.com/api/rest/v2";
		public static const VIMEO_API_URL:String = "http://vimeo.com/api/rest/v2";
		public static const VIMEO_TOKEN_REQUEST_URL:String = "http://vimeo.com/oauth/request_token";
		public static const VIMEO_ACCESS_TOKEN_URL:String = "http://vimeo.com/oauth/access_token";
		public static const VIMEO_AUTH_URL:String = "http://vimeo.com/oauth/authorize";
		
		//TODO - Enter your details below
		public static var VIMEO_CONSUMER_KEY:String = "YOURKEYGOESHERE";
		public static const VIMEO_CONSUMER_SECRET:String = "YOURSECRETGOES HERE";
		public static const VIMEO_PARAMS_USERID:String = "YOURUSERIDGOESHERE";

		// you can look in com.oakwood.vimeo.GenerateAuthTokenExample.as for some help on generating your access token
		public static const VIMEO_AUTHORISE_TOKEN:String = "YOURACCESSTOKENGOESHERE";
		public static const VIMEO_AUTHORISE_TOKEN_SECRET:String = "YOURACCESSTOKENSECRETGOESHERE";
		
		public static const VIMEO_ALBUMS_GETALL:String ="vimeo.albums.getAll";
		public static const VIMEO_ALBUMS_GETVIDEOS:String ="vimeo.albums.getVideos";
		
		

		public var _request:URLRequest;
		
		public function VimeoRequest(params:Object = null) 
		{
			if(params != null)
				buildRequest(params);
		}
		
		public function buildRequest(params:Object):URLRequest
		{
			var oAuthReq:OAuthRequest = new OAuthRequest(OAuthRequest.HTTP_MEHTOD_GET, VIMEO_BASE_URL);
			var sigMethod:OAuthSignatureMethod_HMAC_SHA1 = new OAuthSignatureMethod_HMAC_SHA1();
			var oauthCon:OAuthConsumer = new OAuthConsumer(VIMEO_CONSUMER_KEY,VIMEO_CONSUMER_SECRET);
			oAuthReq.consumer = oauthCon;	
			//this if statement is so the request class can be used with the GenerateAuthTokenExample class as well as
			// once the VIMEO_AUTHORISE_TOKEN value is set by using the token generated by that class
			if(params.oauth_token)
			{
				var tok:OAuthToken = new OAuthToken(params.oauth_token,params.oauth_token_secret);
				oAuthReq.token = tok;
			}
			else if (VIMEO_AUTHORISE_TOKEN != "YOURACCESSTOKENGOESHERE")
				oAuthReq.token = new OAuthToken(VIMEO_AUTHORISE_TOKEN,VIMEO_AUTHORISE_TOKEN_SECRET);
				
			oAuthReq.requestParams = params;
			var req:* = oAuthReq.buildRequest(sigMethod,OAuthRequest.RESULT_TYPE_URL_STRING);
			_request = new URLRequest(req);
			return _request;
		}

		public function get request() : URLRequest {
			return _request;
		}

	}
}
