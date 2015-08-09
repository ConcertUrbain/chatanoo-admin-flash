package org.concert_urbain.touratour.api.core.requests
{
	public class SessionsServiceRequest extends AbstractServiceRequest
	{
		public static const SERVICE_NAME:String = "sessions";
		
		public static const GET_SESSIONS_METHOD:String 				= "getSessions";
		public static const GET_SESSION_BY_ID_METHOD:String 		= "getSessionById";
		public static const GET_SESSIONS_BY_QUERY_ID_METHOD:String 	= "getSessionsByQueryId";
		public static const ADD_SESSION_METHOD:String 				= "addSession";
		public static const SET_SESSION_METHOD:String 				= "setSession";
		public static const DELETE_SESSION_METHOD:String 			= "deleteSession";
		public static const ADD_QUERY_INTO_SESSION_METHOD:String 	= "addQueryIntoSession";
		public static const REMOVE_QUERY_FROM_SESSION_METHOD:String	= "removeQueryFromSession";
		public static const GET_USER_FROM_SESSION_METHOD:String 	= "getUserFromVo";
		public static const SET_USER_OF_SESSION_METHOD:String 		= "setUserOfVo";
		public static const GET_SESSIONS_BY_USER_ID_METHOD:String 	= "getVosByUserId";
		public static const ADD_META_INTO_SESSION_METHOD:String 	= "addMetaIntoVo";
		public static const REMOVE_META_FROM_SESSION_METHOD:String 	= "removeMetaFromVo";
		
		public function SessionsServiceRequest(methodName:String)
		{
			super();
			_service = SERVICE_NAME;
			_method = methodName;
		}
	}
}