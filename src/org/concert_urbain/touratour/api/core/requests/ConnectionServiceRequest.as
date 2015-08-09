﻿package org.concert_urbain.touratour.api.core.requests{	import com.adobe.serialization.json.JSON;		import flash.net.URLRequest;	import flash.net.URLRequestHeader;	import flash.net.URLRequestMethod;		import org.concert_urbain.touratour.api.TAT;	public class ConnectionServiceRequest extends AbstractServiceRequest	{		public static const SERVICE_NAME:String = "connection";				public static const LOGIN_METHOD:String = "login";		public static const LOGOUT_METHOD:String = "logout";				public function ConnectionServiceRequest(methodName:String)		{			super();			_service = SERVICE_NAME;			_method = methodName;		}				override public function getJSONRequest():URLRequest		{			var url:URLRequest = new URLRequest(TAT.getInstance().url + "/services/" + _service + "/json");			url.method = URLRequestMethod.POST;			url.requestHeaders = [new URLRequestHeader("Content-Type", "application/json")];						var data:Object = {				method: method,				params: params,				id: generateID()			};			url.data = com.adobe.serialization.json.JSON.encode(data);						return url;		}	}}