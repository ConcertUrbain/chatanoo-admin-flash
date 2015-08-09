package org.concert_urbain.touratour.api.services
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.requests.SearchServiceRequest;
	import org.concert_urbain.touratour.api.vos.Meta;

	public class SearchService extends AbstractService
	{
		public function SearchService()
		{
			super();
		}
		
		public function getMetas():String
		{
			var request:SearchServiceRequest = new SearchServiceRequest(SearchServiceRequest.GET_METAS_METHOD);
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getMetasByVo(voId:int, voType:String):String
		{
			var request:SearchServiceRequest = new SearchServiceRequest(SearchServiceRequest.GET_METAS_BY_VO_METHOD);
			request.params = [voId, voType];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getMetaById(metaId:int):String
		{
			var request:SearchServiceRequest = new SearchServiceRequest(SearchServiceRequest.GET_META_BY_ID_METHOD);
			request.params = [metaId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getMetaByContent(content:String):String
		{
			var request:SearchServiceRequest = new SearchServiceRequest(SearchServiceRequest.GET_META_BY_CONTENT_METHOD);
			request.params = [content];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addMeta(meta:Meta):String
		{
			var request:SearchServiceRequest = new SearchServiceRequest(SearchServiceRequest.ADD_META_METHOD);
			request.params = [meta];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setMeta(meta:Meta):String
		{
			var request:SearchServiceRequest = new SearchServiceRequest(SearchServiceRequest.SET_META_METHOD);
			request.params = [meta];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function deleteMeta(metaId:int):String
		{
			var request:SearchServiceRequest = new SearchServiceRequest(SearchServiceRequest.DELETE_META_METHOD);
			request.params = [metaId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function search(request:String, section:String = 'Default'):String
		{
			var req:SearchServiceRequest = new SearchServiceRequest(SearchServiceRequest.SEARCH_METHOD);
			req.params = [request, section];
			TAT.getInstance().sendRequest(req);
			return req.id;
		}
		
	}
}