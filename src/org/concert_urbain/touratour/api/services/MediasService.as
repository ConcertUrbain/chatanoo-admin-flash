package org.concert_urbain.touratour.api.services
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.requests.MediasServiceRequest;
	import org.concert_urbain.touratour.api.vos.Meta;
	import org.concert_urbain.touratour.api.vos.datas.AbstractData;
	import org.concert_urbain.touratour.api.vos.medias.AbstractMedia;

	
	public class MediasService extends AbstractService
	{
		public function MediasService()
		{
			super();
		}
		
		public function getMedias():String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.GET_MEDIAS_METHOD);
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getMediaById(mediaId:int, mediaType:String):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.GET_MEDIA_BY_ID_METHOD);
			request.params = [mediaId, mediaType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getMediasByItemId(itemId:int):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.GET_MEDIAS_BY_ITEM_ID_METHOD);
			request.params = [itemId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getMediasByQueryId(queryId:int):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.GET_MEDIAS_BY_QUERY_ID_METHOD);
			request.params = [queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addMedia(media:AbstractMedia):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.ADD_MEDIA_METHOD);
			request.params = [media];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setMedia(media:AbstractMedia):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.SET_MEDIA_METHOD);
			request.params = [media];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function deleteMedia(mediaId:int, mediaType:String):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.DELETE_MEDIA_METHOD);
			request.params = [mediaId, mediaType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getUserFromMedia(mediaId:int, mediaType:String):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.GET_USER_FROM_MEDIA_METHOD);
			request.params = [mediaId, mediaType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setUserOfMedia(userId:int, mediaId:int, mediaType:String):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.SET_USER_OF_MEDIA_METHOD);
			request.params = [userId, mediaId, mediaType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getMediasByUserId(userId:int):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.GET_MEDIAS_BY_USER_ID_METHOD);
			request.params = [userId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addMetaIntoMedia(meta:Meta, mediaId:int, mediaType:String):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.ADD_META_INTO_MEDIA_METHOD);
			request.params = [meta, mediaId, mediaType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeMetaFromMedia(metaId:int, mediaId:int, mediaType:String):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.REMOVE_META_FORM_MEDIA_METHOD);
			request.params = [metaId, mediaId, mediaType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function validateMedia(mediaId:int, mediaType:String, trueOrFalse:Boolean):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.VALIDATE_MEDIA_METHOD);
			request.params = [mediaId, mediaId, trueOrFalse];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addDataIntoMedia(data:AbstractData, mediaId:int, mediaType:int):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.ADD_DATA_INTO_MEDIA_METHOD);
			request.params = [data, mediaId, mediaType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeDataFromMedia(dataId:int, dataType:String, mediaId:int, mediaType:String):String
		{
			var request:MediasServiceRequest = new MediasServiceRequest(MediasServiceRequest.REMOVE_DATA_FROM_MEDIA_METHOD);
			request.params = [dataId, dataType, mediaId, mediaType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
	}
}