package org.concert_urbain.touratour.api.core.requests
{
	public class MediasServiceRequest extends AbstractServiceRequest
	{
		public static const SERVICE_NAME:String = "medias";
		
		public static const GET_MEDIAS_METHOD:String 				= "getMedias";
		public static const GET_MEDIA_BY_ID_METHOD:String 			= "getMediaById";
		public static const GET_MEDIAS_BY_ITEM_ID_METHOD:String 	= "getMediasByItemId";
		public static const GET_MEDIAS_BY_QUERY_ID_METHOD:String 	= "getMediasByQueryId";
		public static const ADD_MEDIA_METHOD:String 				= "addMedia";
		public static const SET_MEDIA_METHOD:String 				= "setMedia";
		public static const DELETE_MEDIA_METHOD:String 				= "deleteMedia";
		public static const GET_USER_FROM_MEDIA_METHOD:String 		= "getUserFromMedia";
		public static const SET_USER_OF_MEDIA_METHOD:String 		= "setUserOfMedia";
		public static const GET_MEDIAS_BY_USER_ID_METHOD:String 	= "getMediasByUserId";
		public static const ADD_META_INTO_MEDIA_METHOD:String 		= "addMetaIntoMedia";
		public static const REMOVE_META_FORM_MEDIA_METHOD:String 	= "removeMetaFromMedia";
		public static const VALIDATE_MEDIA_METHOD:String 			= "validateMedia";
		public static const ADD_DATA_INTO_MEDIA_METHOD:String 		= "addDataIntoMedia";
		public static const REMOVE_DATA_FROM_MEDIA_METHOD:String 	= "removeDataFromMedia";
		
		public function MediasServiceRequest(methodName:String)
		{
			super();
			_service = SERVICE_NAME;
			_method = methodName;
		}
	}
}