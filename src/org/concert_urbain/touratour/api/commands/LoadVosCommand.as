package org.concert_urbain.touratour.api.commands
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.commands.AbstractCommand;
	import org.concert_urbain.touratour.api.core.commands.CommandEvent;
	import org.concert_urbain.touratour.api.core.commands.ICommand;
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.services.AbstractService;
	import org.concert_urbain.touratour.api.vos.Comment;
	import org.concert_urbain.touratour.api.vos.IVo;
	import org.concert_urbain.touratour.api.vos.Item;
	import org.concert_urbain.touratour.api.vos.Meta;
	import org.concert_urbain.touratour.api.vos.Query;
	import org.concert_urbain.touratour.api.vos.Session;
	import org.concert_urbain.touratour.api.vos.User;
	import org.concert_urbain.touratour.api.vos.collections.MultiVoCollection;
	import org.concert_urbain.touratour.api.vos.collections.VoCollection;
	import org.concert_urbain.touratour.api.vos.datas.AbstractData;
	import org.concert_urbain.touratour.api.vos.factory.VoFactory;
	import org.concert_urbain.touratour.api.vos.medias.AbstractMedia;
	
	public class LoadVosCommand extends AbstractCommand implements ICommand
	{
		public static const DATAS_CHILDREN_TYPE:String = 'LoadVosCommand_datas_childrenType';
		public static const MEDIAS_CHILDREN_TYPE:String = 'LoadVosCommand_medias_childrenType';
		public static const METAS_CHILDREN_TYPE:String = 'LoadVosCommand_metas_childrenType';
		public static const QUERIES_CHILDREN_TYPE:String = 'LoadVosCommand_queries_childrenType';
		public static const ITEMS_CHILDREN_TYPE:String = 'LoadVosCommand_items_childrenType';
		public static const COMMENTS_CHILDREN_TYPE:String = 'LoadVosCommand_comments_childrenType';
		public static const SESSIONS_CHILDREN_TYPE:String = 'LoadVosCommand_sessions_childrenType';
		
		private var _vo:IVo;
		private var _childrenType:String;
		
		private var _successType:String;
		private var _errorType:String;
		private var _action:Function;
		private var _service:AbstractService;
		private var _params:Array;
		
		private var _uiid:String;
		
		private var _result:*;
		
		public function LoadVosCommand(vo:IVo, childrenType:String)
		{
			_vo = vo;
			_childrenType = childrenType;
			switch(true)
			{
				case _vo is Comment:
					switch(childrenType)
					{
						case DATAS_CHILDREN_TYPE:
							_successType = ServiceEvent.DATAS_GET_DATAS_BY_COMMENT_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.DATAS_GET_DATAS_BY_COMMENT_ID_METHOD_ERROR;
							_service = TAT.getInstance().datasService;
							_action = TAT.getInstance().datasService.getDatasByCommentId;
							_params = [_vo.id];
							break;
					}
					break;
				case _vo is Item:
					switch(childrenType)
					{
						case QUERIES_CHILDREN_TYPE:
							_successType = ServiceEvent.QUERIES_GET_QUERIES_BY_ITEM_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.QUERIES_GET_QUERIES_BY_ITEM_ID_METHOD_ERROR;
							_service = TAT.getInstance().queriesService;
							_action = TAT.getInstance().queriesService.getQueriesByItemId;
							_params = [_vo.id];
							break;
						case COMMENTS_CHILDREN_TYPE:
							_successType = ServiceEvent.COMMENTS_GET_COMMENTS_BY_ITEM_ID_SUCCESS;
							_errorType = ServiceEvent.COMMENTS_GET_COMMENTS_BY_ITEM_ID_ERROR;
							_service = TAT.getInstance().commentsService;
							_action = TAT.getInstance().commentsService.getCommentByItemId;
							_params = [_vo.id];
							break;
						case MEDIAS_CHILDREN_TYPE:
							_successType = ServiceEvent.MEDIAS_GET_MEDIAS_BY_ITEM_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.MEDIAS_GET_MEDIAS_BY_ITEM_ID_METHOD_ERROR;
							_service = TAT.getInstance().mediasService;
							_action = TAT.getInstance().mediasService.getMediasByItemId;
							_params = [_vo.id];
							break;
						case METAS_CHILDREN_TYPE:
							_successType = ServiceEvent.SEARCH_GET_METAS_BY_VO_METHOD_SUCCESS;
							_errorType = ServiceEvent.SEARCH_GET_METAS_BY_VO_METHOD_ERROR;
							_service = TAT.getInstance().searchService;
							_action = TAT.getInstance().searchService.getMetasByVo;
							_params = [_vo.id, 'Item'];
							break;
						case DATAS_CHILDREN_TYPE:
							_successType = ServiceEvent.DATAS_GET_DATAS_BY_ITEM_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.DATAS_GET_DATAS_BY_ITEM_ID_METHOD_ERROR;
							_service = TAT.getInstance().datasService;
							_action = TAT.getInstance().datasService.getDatasByItemId;
							_params = [_vo.id];
							break;
					}
					break;
				case _vo is Meta:
					break;
				case _vo is Query:
					switch(childrenType)
					{
						case ITEMS_CHILDREN_TYPE:
							_successType = ServiceEvent.ITEMS_GET_ITEMS_BY_QUERY_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.ITEMS_GET_ITEMS_BY_QUERY_ID_METHOD_ERROR;
							_service = TAT.getInstance().itemsService;
							_action = TAT.getInstance().itemsService.getItemsByQuery;
							_params = [_vo.id];
							break;
						case MEDIAS_CHILDREN_TYPE:
							_successType = ServiceEvent.MEDIAS_GET_MEDIAS_BY_QUERY_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.MEDIAS_GET_MEDIAS_BY_QUERY_ID_METHOD_ERROR;
							_service = TAT.getInstance().mediasService;
							_action = TAT.getInstance().mediasService.getMediasByQueryId;
							_params = [_vo.id];
							break;
						case METAS_CHILDREN_TYPE:
							_successType = ServiceEvent.SEARCH_GET_METAS_BY_VO_METHOD_SUCCESS;
							_errorType = ServiceEvent.SEARCH_GET_METAS_BY_VO_METHOD_ERROR;
							_service = TAT.getInstance().searchService;
							_action = TAT.getInstance().searchService.getMetasByVo;
							_params = [_vo.id, 'Query'];
							break;
						case DATAS_CHILDREN_TYPE:
							_successType = ServiceEvent.DATAS_GET_DATAS_BY_QUERY_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.DATAS_GET_DATAS_BY_QUERY_ID_METHOD_ERROR;
							_service = TAT.getInstance().datasService;
							_action = TAT.getInstance().datasService.getDatasByQueryId;
							_params = [_vo.id];
							break;
					}
					break;
				case _vo is Session:
					switch(childrenType)
					{
						case QUERIES_CHILDREN_TYPE:
							_successType = ServiceEvent.QUERIES_GET_QUERIES_BY_SESSIONS_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.QUERIES_GET_QUERIES_BY_SESSIONS_ID_METHOD_ERROR;
							_service = TAT.getInstance().queriesService;
							_action = TAT.getInstance().queriesService.getQueriesBySessionId;
							_params = [_vo.id];
							break;
						case METAS_CHILDREN_TYPE:
							_successType = ServiceEvent.SEARCH_GET_METAS_BY_VO_METHOD_SUCCESS;
							_errorType = ServiceEvent.SEARCH_GET_METAS_BY_VO_METHOD_ERROR;
							_service = TAT.getInstance().searchService;
							_action = TAT.getInstance().searchService.getMetasByVo;
							_params = [_vo.id, 'Session'];
							break;
					}
					break;
				case _vo is User:
					switch(childrenType)
					{
						case DATAS_CHILDREN_TYPE:
							_successType = ServiceEvent.DATAS_GET_DATAS_BY_USER_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.DATAS_GET_DATAS_BY_USER_ID_METHOD_ERROR;
							_service = TAT.getInstance().datasService;
							_action = TAT.getInstance().datasService.getDatasByUserId;
							_params = [_vo.id];
							break;
						
						case COMMENTS_CHILDREN_TYPE:
							_successType = ServiceEvent.COMMENTS_GET_COMMENTS_BY_USER_ID_SUCCESS;
							_errorType = ServiceEvent.COMMENTS_GET_COMMENTS_BY_USER_ID_ERROR;
							_service = TAT.getInstance().commentsService;
							_action = TAT.getInstance().commentsService.getCommentsByUserId;
							_params = [_vo.id];
							break;
						case ITEMS_CHILDREN_TYPE:
							_successType = ServiceEvent.ITEMS_GET_ITEMS_BY_USER_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.ITEMS_GET_ITEMS_BY_USER_ID_METHOD_ERROR;
							_service = TAT.getInstance().itemsService;
							_action = TAT.getInstance().itemsService.getItemsByUserId;
							_params = [_vo.id];
							break;
						case MEDIAS_CHILDREN_TYPE:
							_successType = ServiceEvent.MEDIAS_GET_MEDIAS_BY_USER_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.MEDIAS_GET_MEDIAS_BY_USER_ID_METHOD_ERROR;
							_service = TAT.getInstance().mediasService;
							_action = TAT.getInstance().mediasService.getMediasByUserId;
							_params = [_vo.id];
							break;
						case QUERIES_CHILDREN_TYPE:
							_successType = ServiceEvent.QUERIES_GET_QUERIES_BY_USER_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.QUERIES_GET_QUERIES_BY_USER_ID_METHOD_ERROR;
							_service = TAT.getInstance().queriesService;
							_action = TAT.getInstance().queriesService.getQueriesByUserId;
							_params = [_vo.id];
							break;
						case SESSIONS_CHILDREN_TYPE:
							_successType = ServiceEvent.SESSIONS_GET_SESSIONS_BY_USER_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.SESSIONS_GET_SESSIONS_BY_USER_ID_METHOD_ERROR;
							_service = TAT.getInstance().sessionsService;
							_action = TAT.getInstance().sessionsService.getSessionsByUserId;
							_params = [_vo.id];
							break;
					}
					break;
				case _vo is AbstractData:
					break;
				case _vo is AbstractMedia:
					switch(childrenType)
					{
						case METAS_CHILDREN_TYPE:
							_successType = ServiceEvent.SEARCH_GET_METAS_BY_VO_METHOD_SUCCESS;
							_errorType = ServiceEvent.SEARCH_GET_METAS_BY_VO_METHOD_ERROR;
							_service = TAT.getInstance().searchService;
							_action = TAT.getInstance().searchService.getMetasByVo;
							_params = [_vo.id, "Media_" + AbstractMedia(_vo).getType()];
							break;
						case DATAS_CHILDREN_TYPE:
							_successType = ServiceEvent.DATAS_GET_DATAS_BY_MEDIA_ID_METHOD_SUCCESS;
							_errorType = ServiceEvent.DATAS_GET_DATAS_BY_MEDIA_ID_METHOD_ERROR;
							_service = TAT.getInstance().datasService;
							_action = TAT.getInstance().datasService.getDatasByMediaId;
							_params = [_vo.id, AbstractMedia(_vo).getType()];
							break;
					}
					break;
			}
		}
		
		public function execute():void
		{
			TAT.getInstance().addEventListener(_successType, _successHandler);
			TAT.getInstance().addEventListener(_errorType, _errorHandler);
			_uiid = _action.apply(_service, _params) as String;
		}
		
		private function _successHandler(event:ServiceEvent):void
		{
			if(event.id != _uiid)
				return;
			
			TAT.getInstance().removeEventListener(_successType, _successHandler);
			TAT.getInstance().removeEventListener(_errorType, _errorHandler);
			
			switch(true)
			{
				case event.result is Array:
					_result = new VoCollection(_vo, _childrenType, event.result);
					break;
				case event.result is Object:
					_result = new MultiVoCollection(_vo, _childrenType, event.result);
					break;
			}
			
			dispatchEvent(new CommandEvent(CommandEvent.COMPLETE));
		}
		
		private function _errorHandler(event:ServiceEvent):void
		{
			if(event.id != _uiid)
				return;
			
			TAT.getInstance().removeEventListener(_successType, _successHandler);
			TAT.getInstance().removeEventListener(_errorType, _errorHandler);
			
			dispatchEvent(new CommandEvent(CommandEvent.ERROR));
		}
		
		public function get result():*
		{
			return _result;
		}

		public function get childrenType():String
		{
			return _childrenType;
		}

	}
}