package org.concert_urbain.touratour.api.core.requests
{
	public class QueriesServiceRequest extends AbstractServiceRequest
	{
		public static const SERVICE_NAME:String = "queries";
		
		public static const GET_QUERIES_METHOD:String 					= "getQueries";
		public static const GET_QUERY_BY_ID_METHOD:String 				= "getQueryById";
		public static const GET_QUERIES_BY_SESSIONS_ID_METHOD:String 	= "getQueriesBySessionId";
		public static const GET_QUERIES_BY_ITEM_ID_METHOD:String 		= "getQueriesByItemId";
		public static const ADD_QUERY_METHOD:String 					= "addQuery";
		public static const SET_QUERY_METHOD:String 					= "setQuery";
		public static const DELETE_QUERY_METHOD:String 					= "deleteQuery";
		public static const ADD_ITEM_FROM_QUERY_METHOD:String 			= "addItemIntoQuery";
		public static const REMOVE_ITEM_INTO_QUERY_METHOD:String 		= "removeItemFromQuery";
		public static const ADD_MEDIA_INTO_QUERY_METHOD:String 			= "addMediaIntoQuery";
		public static const REMOVE_MEDIA_FROM_QUERY_METHOD:String 		= "removeMediaFromQuery";
		public static const ADD_META_INTO_QUERY_METHOD:String 			= "addMetaIntoVo";
		public static const REMOVE_META_FROM_QUERY_METHOD:String 		= "removeMetaFromVo";
		public static const GET_USER_FROM_QUERY_METHOD:String 			= "getUserFromVo";
		public static const SET_USER_OF_QUERY_METHOD:String 			= "setUserOfVo";
		public static const GET_QUERIES_BY_USER_ID_METHOD:String 		= "getVosByUserId";
		public static const VALIDATE_QUERY_METHOD:String 				= "validateVo";
		public static const ADD_DATA_INTOQUERY_METHOD:String 			= "addDataIntoVo";
		public static const REMOVE_DATA_FROM_QUERY_METHOD:String 		= "removeDataFromVo";
		
		public function QueriesServiceRequest(methodName:String)
		{
			super();
			_service = SERVICE_NAME;
			_method = methodName;
		}
	}
}