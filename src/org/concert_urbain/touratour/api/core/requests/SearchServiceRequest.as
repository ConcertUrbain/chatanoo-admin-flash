package org.concert_urbain.touratour.api.core.requests
{
	public class SearchServiceRequest extends AbstractServiceRequest
	{
		public static const SERVICE_NAME:String = "search";
		
		public static const GET_METAS_METHOD:String 			= "getMetas";
		public static const GET_METAS_BY_VO_METHOD:String 		= "getMetasByVo";
		public static const GET_META_BY_ID_METHOD:String 		= "getMetaById";
		public static const GET_META_BY_CONTENT_METHOD:String 	= "getMetaByContent";
		public static const ADD_META_METHOD:String 				= "addMeta";
		public static const SET_META_METHOD:String 				= "setMeta";
		public static const DELETE_META_METHOD:String 			= "deleteMeta";
		public static const SEARCH_METHOD:String 				= "search";
		
		public function SearchServiceRequest(methodName:String)
		{
			super();
			_service = SERVICE_NAME;
			_method = methodName;
		}
	}
}