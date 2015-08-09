package org.concert_urbain.touratour.api.services
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.requests.SessionsServiceRequest;
	import org.concert_urbain.touratour.api.vos.Meta;
	import org.concert_urbain.touratour.api.vos.Query;
	import org.concert_urbain.touratour.api.vos.Session;

	public class SessionsService extends AbstractService
	{
		public function SessionsService()
		{
			super();
		}
		
		public function getSessions():String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.GET_SESSIONS_METHOD);
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getSessionById(sessionId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.GET_SESSION_BY_ID_METHOD);
			request.params = [sessionId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getSessionsByQueryId(queryId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.GET_SESSIONS_BY_QUERY_ID_METHOD);
			request.params = [queryId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addSession(session:Session):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.ADD_SESSION_METHOD);
			request.params = [session];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setSession(session:Session):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.SET_SESSION_METHOD);
			request.params = [session];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function deleteSession(sessionId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.DELETE_SESSION_METHOD);
			request.params = [sessionId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addQueryIntoSession(query:Query, sessionId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.ADD_QUERY_INTO_SESSION_METHOD);
			request.params = [query, sessionId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeQueryFromSession(queryId:int, sessionId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.REMOVE_QUERY_FROM_SESSION_METHOD);
			request.params = [queryId, sessionId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getUserFromSession(sessionId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.GET_USER_FROM_SESSION_METHOD);
			request.params = [sessionId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function setUserOfSession(userId:int, sessionId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.SET_USER_OF_SESSION_METHOD);
			request.params = [userId, sessionId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function getSessionsByUserId(userId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.GET_SESSIONS_BY_USER_ID_METHOD);
			request.params = [userId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function addMetaIntoSession(meta:Meta, sessionId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.ADD_META_INTO_SESSION_METHOD);
			request.params = [meta, sessionId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
		public function removeMetaFromSession(metaId:int, sessionId:int):String
		{
			var request:SessionsServiceRequest = new SessionsServiceRequest(SessionsServiceRequest.REMOVE_META_FROM_SESSION_METHOD);
			request.params = [metaId, sessionId];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
		
	}
}