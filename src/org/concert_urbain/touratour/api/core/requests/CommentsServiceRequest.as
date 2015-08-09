package org.concert_urbain.touratour.api.core.requests
{
	public class CommentsServiceRequest extends AbstractServiceRequest
	{
		public static const SERVICE_NAME:String = "comments";
		
		public static const GET_COMMENTS_METHOD:String 				= "getComments";
		public static const GET_COMMENT_BY_ID_METHOD:String 		= "getCommentById";
		public static const GET_COMMENTS_BY_ITEM_ID_METHOD:String 	= "getCommentsByItemId";
		public static const ADD_COMMENT_METHOD:String 				= "addComment";
		public static const SET_COMMENT_METHOD:String 				= "setComment";
		public static const SET_ITEM_OF_COMMENT_METHOD:String 		= "setItemOfComment";
		public static const DELETE_COMMENT_METHOD:String	 		= "deleteComment";
		public static const GET_USER_OF_COMMENT_METHOD:String 		= "getUserOfVo";
		public static const GET_COMMENTS_BY_USER_ID_METHOD:String 	= "getVosByUserId";
		public static const VALIDATE_COMMENT_METHOD:String 			= "validateVo";
		public static const ADD_DATA_INTO_COMMENT_METHOD:String 	= "addDataIntoVo";
		public static const REMOVE_DATA_FORM_COMMENT_METHOD:String 	= "removeDataFromVo";
		
		public function CommentsServiceRequest(methodName:String)
		{
			super();
			_service = SERVICE_NAME;
			_method = methodName;
		}
	}
}