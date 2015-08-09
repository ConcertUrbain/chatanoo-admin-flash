package org.concert_urbain.touratour.api.services
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.requests.CommentsServiceRequest;
	import org.concert_urbain.touratour.api.vos.Comment;
	import org.concert_urbain.touratour.api.vos.datas.AbstractData;

	public class CommentsService extends AbstractService
	{
		public function CommentsService()
		{
			super();
		}
		
		public function getComments():String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.GET_COMMENTS_METHOD);
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getCommentById(commentId:int):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.GET_COMMENT_BY_ID_METHOD);
			request.params = [commentId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getCommentByItemId(itemId:int):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.GET_COMMENTS_BY_ITEM_ID_METHOD);
			request.params = [itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addComment(comment:Comment):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.ADD_COMMENT_METHOD);
			request.params = [comment];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setComment(comment:Comment):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.SET_COMMENT_METHOD);
			request.params = [comment];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setItemOfComment(comment:Comment, itemId:int):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.SET_ITEM_OF_COMMENT_METHOD);
			request.params = [comment, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function deleteComment(commentId:int):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.DELETE_COMMENT_METHOD);
			request.params = [commentId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getUserOfComment(commentId:int):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.GET_USER_OF_COMMENT_METHOD);
			request.params = [commentId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getCommentsByUserId(userId:int):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.GET_COMMENTS_BY_USER_ID_METHOD);
			request.params = [userId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function validateComment(commentId:int, value:Boolean, all:Boolean = false):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.VALIDATE_COMMENT_METHOD);
			request.params = [commentId, value, all];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addDataIntoComment(data:AbstractData, commentId:int, vote:Number, itemId:int = -1):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.ADD_DATA_INTO_COMMENT_METHOD);
			request.params = itemId == -1 ? [data, commentId, vote] : [data, commentId, vote, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeDataFromComment(dataId:int, dataType:String, commentId:int):String
		{
			var request:CommentsServiceRequest = new CommentsServiceRequest(CommentsServiceRequest.REMOVE_DATA_FORM_COMMENT_METHOD);
			request.params = [dataId, dataType, commentId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
	}
}