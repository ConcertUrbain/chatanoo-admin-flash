package org.concert_urbain.touratour.api.services
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.requests.DatasServiceRequest;
	import org.concert_urbain.touratour.api.vos.datas.AbstractData;

	public class DatasService extends AbstractService
	{
		public function DatasService()
		{
			super();
		}
		
		public function getDatas():String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.GET_DATAS_METHOD);
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getDatasById(dataId:int, dataType:String):String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.GET_DATAS_BY_ID_METHOD);
			request.params = [dataId, dataType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getDatasByItemId(itemId:int):String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.GET_DATAS_BY_ITEM_ID_METHOD);
			request.params = [itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getDatasByCommentId(commentId:int, itemId:int):String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.GET_DATAS_BY_COMMENT_ID_METHOD);
			request.params = [commentId, itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getDatasByMediaId(mediaId:int, mediaType:String):String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.GET_DATAS_BY_MEDIA_ID_METHOD);
			request.params = [mediaId, mediaType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getDatasByUserId(userId:int):String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.GET_DATAS_BY_USER_ID_METHOD);
			request.params = [userId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getDatasByQueryId(queryId:int):String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.GET_DATAS_BY_QUERY_ID_METHOD);
			request.params = [queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addData(data:AbstractData):String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.ADD_DATA_METHOD);
			request.params = [data];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setData(data:AbstractData):String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.SET_DATA_METHOD);
			request.params = [data];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function deleteData(dataId:int, dataType:String):String
		{
			var request:DatasServiceRequest = new DatasServiceRequest(DatasServiceRequest.DELETE_DATA_METHOD);
			request.params = [dataId, dataType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
	}
}