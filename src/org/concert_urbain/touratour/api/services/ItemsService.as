package org.concert_urbain.touratour.api.services
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.requests.ItemsServiceRequest;
	import org.concert_urbain.touratour.api.vos.Comment;
	import org.concert_urbain.touratour.api.vos.Item;
	import org.concert_urbain.touratour.api.vos.Meta;
	import org.concert_urbain.touratour.api.vos.datas.AbstractData;
	import org.concert_urbain.touratour.api.vos.medias.AbstractMedia;

	public class ItemsService extends AbstractService
	{
		public function ItemsService()
		{
			super();
		}
		
		public function getItems():String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.GET_ITEMS_METHOD);
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getItemById(itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.GET_ITEM_BY_ID_METHOD);
			request.params = [itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getItemsByQuery(queryId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.GET_ITEMS_BY_QUERY_ID_METHOD);
			request.params = [queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addItem(item:Item):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.ADD_ITEM_METHOD);
			request.params = [item];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setItem(item:Item):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.SET_ITEM_METHOD);
			request.params = [item];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function deleteItem(itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.DELETE_ITEM_METHOD);
			request.params = [itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addCommentIntoItem(comment:Comment, itemId:int, lastVote:Number = NaN):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.ADD_COMMENT_INTO_ITEM_METHOD);
			request.params = isNaN(lastVote) ? [comment, itemId] : [comment, itemId, lastVote];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeCommentFormItem(commentId:int, itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.REMOVE_COMMENT_FROM_ITEM_METHOD);
			request.params = [commentId, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addMediaIntoItem(media:AbstractMedia, itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.ADD_MEDIA_INTO_ITEM_METHOD);
			request.params = [media, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeMediaFromItem(mediaId:int, itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.REMOVE_MEDIA_FROM_ITEM_METHOD);
			request.params = [mediaId, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function validateItem(itemId:int, trueOrFalse:Boolean, all:Boolean = false):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.VALIDATE_ITEM_METHOD);
			request.params = [itemId, trueOrFalse, all];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addMetaIntoItem(meta:Meta, itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.ADD_META_INTO_ITEM_METHOD);
			request.params = [meta, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeMetaFromItem(metaId:int, itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.REMOVE_META_FROM_ITEM_METHOD);
			request.params = [metaId, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getUserFromItem(itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.GET_USER_FROM_ITEM_METHOD);
			request.params = [itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setUserOfItem(userId:int, itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.SET_USER_OF_ITEM_METHOD);
			request.params = [userId, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getItemsByUserId(userId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.GET_ITEMS_BY_USER_ID_METHOD);
			request.params = [userId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addDataIntoItem(data:AbstractData, itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.ADD_DATA_INTO_ITEM_METHOD);
			request.params = [data, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeDataFromItem(dataId:int, dataType:String, itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.REMOVE_DATA_FROM_ITEM_METHOD);
			request.params = [dataId, dataType, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getRateOfItem(itemId:int):String
		{
			var request:ItemsServiceRequest = new ItemsServiceRequest(ItemsServiceRequest.GET_RATE_OF_ITEM_METHOD);
			request.params = [itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
	}
}