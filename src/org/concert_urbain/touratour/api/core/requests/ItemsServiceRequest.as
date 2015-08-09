package org.concert_urbain.touratour.api.core.requests
{
	public class ItemsServiceRequest extends AbstractServiceRequest
	{
		public static const SERVICE_NAME:String = "items";
		
		public static const GET_ITEMS_METHOD:String 				= "getItems";
		public static const GET_ITEM_BY_ID_METHOD:String 			= "getItemById";
		public static const GET_ITEMS_BY_QUERY_ID_METHOD:String 	= "getItemsByQueryId";
		public static const ADD_ITEM_METHOD:String 					= "addItem";
		public static const SET_ITEM_METHOD:String 					= "setItem";
		public static const DELETE_ITEM_METHOD:String 				= "deleteItem";
		public static const ADD_COMMENT_INTO_ITEM_METHOD:String 	= "addCommentIntoItem";
		public static const REMOVE_COMMENT_FROM_ITEM_METHOD:String 	= "removeCommentFormItem";
		public static const ADD_MEDIA_INTO_ITEM_METHOD:String 		= "addMediaIntoItem";
		public static const REMOVE_MEDIA_FROM_ITEM_METHOD:String 	= "removeMediaFromItem";
		public static const VALIDATE_ITEM_METHOD:String 			= "validateVo";
		public static const ADD_META_INTO_ITEM_METHOD:String 		= "addMetaIntoVo";
		public static const REMOVE_META_FROM_ITEM_METHOD:String 	= "removeMetaFromVo";
		public static const GET_USER_FROM_ITEM_METHOD:String 		= "getUserFromVo";
		public static const SET_USER_OF_ITEM_METHOD:String 			= "setUserOfVo";
		public static const GET_ITEMS_BY_USER_ID_METHOD:String 		= "getVosByUserId";
		public static const ADD_DATA_INTO_ITEM_METHOD:String 		= "addDataIntoVo";
		public static const REMOVE_DATA_FROM_ITEM_METHOD:String 	= "removeDataFromVo";
		public static const GET_RATE_OF_ITEM_METHOD:String 			= "getRateOfItem";
		
		public function ItemsServiceRequest(methodName:String)
		{
			super();
			_service = SERVICE_NAME;
			_method = methodName;
		}
	}
}