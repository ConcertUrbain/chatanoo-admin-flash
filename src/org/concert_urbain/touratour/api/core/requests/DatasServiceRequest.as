package org.concert_urbain.touratour.api.core.requests
{
	public class DatasServiceRequest extends AbstractServiceRequest
	{
		public static const SERVICE_NAME:String = "datas";
		
		public static const GET_DATAS_METHOD:String 				= "getDatas";
		public static const GET_DATAS_BY_ID_METHOD:String 			= "getDatasById";
		public static const GET_DATAS_BY_ITEM_ID_METHOD:String 		= "getDatasByItemId";
		public static const GET_DATAS_BY_COMMENT_ID_METHOD:String 	= "getDatasByCommentId";
		public static const GET_DATAS_BY_MEDIA_ID_METHOD:String 	= "getDatasByMediaId";
		public static const GET_DATAS_BY_USER_ID_METHOD:String 		= "getDatasByUserId";
		public static const GET_DATAS_BY_QUERY_ID_METHOD:String 	= "getDatasByQueryId";
		public static const ADD_DATA_METHOD:String 					= "addData";
		public static const SET_DATA_METHOD:String 					= "setData";
		public static const DELETE_DATA_METHOD:String 				= "deleteData";
		
		public function DatasServiceRequest(methodName:String)
		{
			super();
			_service = SERVICE_NAME;
			_method = methodName;
		}
	}
}