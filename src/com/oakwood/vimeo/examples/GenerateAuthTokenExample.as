package com.oakwood.vimeo.examples {
	import flash.events.IOErrorEvent;
	import com.oakwood.vimeo.common.VimeoRequest;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	
	/**
	 * This is just a helper class to mkake some calls for generating authorise tokens for vimeo
	 * If you want to use it you need to uncomment the functions in the init one at a time , recompiling for each step
	 * I know its sketchy - but wadja want for free?
	 * 
	 * @author JBecker
	 */
	public class GenerateAuthTokenExample extends Sprite{
		
		private var url_xml_loader:URLLoader = new URLLoader();
		
		public function GenerateAuthTokenExample() 
		{
			//1. uncomment below to request token and keep trace output
			//requestToken();
			
			//2. paste the token into the url http://vimeo.com/oauth/authorize?oauth_token=YOURTOKENHERE&permission=read
			// make sure you have the right permission level you wish to give users - read, write or delete
			//example return oauth_token= oauth_token=YOURTOKEN&oauth_token_secret=YOURTOKENSECRET&oauth_callback_confirmed=true
			
			//3. uncomment below and use verification code from login page and the token secret from the trace outpu in step 1.
			//verifyCode("community-1234567","YOURTOKEN","YOURTOKENSECRET");
			
			//4. paste the returned access token into the VimeoRequest Constants 
			//and voila your authorised functions will work
		}

		
		private function requestToken():void
		{
			VimeoRequest.VIMEO_BASE_URL = VimeoRequest.VIMEO_TOKEN_REQUEST_URL;
			var vimReq:VimeoRequest = new VimeoRequest(new Object());
			
			url_xml_loader.addEventListener(Event.COMPLETE, oAuth_parse);
			url_xml_loader.load(vimReq.request);
		}
		
		private function verifyCode(verificationCode : String,tokenKey:String, tokenSecret:String) : void 
		{
			VimeoRequest.VIMEO_BASE_URL = VimeoRequest.VIMEO_ACCESS_TOKEN_URL;
			 var _requestParams:Object = new Object();
			_requestParams["oauth_token"] = tokenKey;
			_requestParams["oauth_token_secret"] = tokenSecret;
			_requestParams["oauth_verifier"] = verificationCode;
			var vimReq:VimeoRequest = new VimeoRequest(_requestParams);
			url_xml_loader.addEventListener(Event.COMPLETE, oAuth_verified);
			url_xml_loader.addEventListener(IOErrorEvent.IO_ERROR, oAuth_error);
			url_xml_loader.load(vimReq.request);
		}

		private function oAuth_error(event : IOErrorEvent) : void 
		{
			
			trace("error", event)
		}

		private function oAuth_verified(event : Event) : void {
			//and your access token is.....
			trace("ACCESS TOKEN:",event.target.data);
		}
		
		
		private function oAuth_parse(event : Event) : void 
		{
			//this returns the tokens - copy and paste the token into the url, 
			//login and authorise then get the verification code
			trace("AUTH RESPONSE:",event.target.data);
			//Example AUTH RESPONSE: oauth_token=c408a64657c314843d3fd361bc430c45&oauth_token_secret=b3d580edfaa43a1208a3a1116b71e29a85ada34a&oauth_callback_confirmed=true
			//Example of using token in a url (which gets pasted into browser) http://vimeo.com/oauth/authorize?oauth_token=c408a64657c314843d3fd361bc430c45&permission=read 
			//example verification code from login page: community-12345678911
		}

	}
}
