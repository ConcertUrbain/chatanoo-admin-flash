package org.concert_urbain.touratour.api.services
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.requests.QueriesServiceRequest;
	import org.concert_urbain.touratour.api.vos.Item;
	import org.concert_urbain.touratour.api.vos.Meta;
	import org.concert_urbain.touratour.api.vos.Query;
	import org.concert_urbain.touratour.api.vos.datas.AbstractData;
	import org.concert_urbain.touratour.api.vos.medias.AbstractMedia;

	
	public class QueriesService extends AbstractService
	{
		public function QueriesService()
		{
			super();
		}
		
		public function getQueries():String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.GET_QUERIES_METHOD);
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getQueryById(queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.GET_QUERY_BY_ID_METHOD);
			request.params = [queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getQueriesBySessionId(sessionId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.GET_QUERIES_BY_SESSIONS_ID_METHOD);
			request.params = [sessionId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getQueriesByItemId(itemId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.GET_QUERIES_BY_ITEM_ID_METHOD);
			request.params = [itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addQuery(query:Query):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.ADD_QUERY_METHOD);
			request.params = [query];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setQuery(query:Query):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.SET_QUERY_METHOD);
			request.params = [query];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function deleteQuery(queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.DELETE_QUERY_METHOD);
			request.params = [queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addItemIntoQuery(item:Item, queryId:int, param:* = null):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.ADD_ITEM_FROM_QUERY_METHOD);
			request.params = [item, queryId, param];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeItemFromQuery(itemId:int, queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.REMOVE_ITEM_INTO_QUERY_METHOD);
			request.params = [itemId, queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addMediaIntoQuery(media:AbstractMedia, queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.ADD_MEDIA_INTO_QUERY_METHOD);
			request.params = [media, queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeMediaFromQuery(mediaId:int, mediaType:String, queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.REMOVE_MEDIA_FROM_QUERY_METHOD);
			request.params = [mediaId, mediaType, queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addMetaIntoQuery(meta:Meta, queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.ADD_META_INTO_QUERY_METHOD);
			request.params = [meta, queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeMetaFromQuery(metaId:int, queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.REMOVE_META_FROM_QUERY_METHOD);
			request.params = [metaId, queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getUserFromQuery(queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.GET_USER_FROM_QUERY_METHOD);
			request.params = [queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setUserOfQuery(userId:int, queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.SET_USER_OF_QUERY_METHOD);
			request.params = [userId, queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getQueriesByUserId(userId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.GET_QUERIES_BY_USER_ID_METHOD);
			request.params = [userId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function validateQuery(queryId:int, trueOrFalse:Boolean, all:Boolean = false):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.VALIDATE_QUERY_METHOD);
			request.params = [queryId, trueOrFalse, all];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addDataIntoQuery(data:AbstractData, queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.ADD_DATA_INTOQUERY_METHOD);
			request.params = [data, queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeDataFromQuery(dataId:int, dataType:String, queryId:int):String
		{
			var request:QueriesServiceRequest = new QueriesServiceRequest(QueriesServiceRequest.REMOVE_DATA_FROM_QUERY_METHOD);
			request.params = [dataId, dataType, queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
	}
}