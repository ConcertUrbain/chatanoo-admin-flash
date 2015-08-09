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
	import org.concert_urbain.touratour.api.vos.datas.AbstractData;
	import org.concert_urbain.touratour.api.vos.medias.AbstractMedia;
	
	public class SaveCommand extends AbstractCommand implements ICommand
	{
		private var _vo:IVo;
		
		private var _successType:String;
		private var _errorType:String;
		private var _action:Function;
		private var _service:AbstractService;
		private var _params:Array;
		
		private var _uiid:String;
		
		private var _result:*;
		
		public function SaveCommand(vo:IVo)
		{
			_vo = vo;
			switch(true)
			{
				case _vo is Comment:
					_successType = (_vo.id == 0) ? ServiceEvent.COMMENTS_ADD_COMMENT_SUCCESS : ServiceEvent.COMMENTS_SET_COMMENT_SUCCESS;
					_errorType = (_vo.id == 0) ? ServiceEvent.COMMENTS_ADD_COMMENT_ERROR : ServiceEvent.COMMENTS_SET_COMMENT_SUCCESS;
					_service = TAT.getInstance().commentsService;
					_action = (_vo.id == 0) ? TAT.getInstance().commentsService.addComment : TAT.getInstance().commentsService.setComment;
					_params = [_vo];
					break;
				case _vo is Item:
					_successType = (_vo.id == 0) ? ServiceEvent.ITEMS_ADD_ITEM_METHOD_SUCCESS : ServiceEvent.ITEMS_SET_ITEM_METHOD_SUCCESS;
					_errorType = (_vo.id == 0) ? ServiceEvent.ITEMS_ADD_ITEM_METHOD_ERROR : ServiceEvent.ITEMS_SET_ITEM_METHOD_ERROR;
					_service = TAT.getInstance().itemsService;
					_action = (_vo.id == 0) ? TAT.getInstance().itemsService.addItem : TAT.getInstance().itemsService.setItem;
					_params = [_vo];
					break;
				case _vo is Meta:
					_successType = (_vo.id == 0) ? ServiceEvent.SEARCH_ADD_META_METHOD_SUCCESS : ServiceEvent.SEARCH_SET_META_METHOD_SUCCESS;
					_errorType = (_vo.id == 0) ? ServiceEvent.SEARCH_ADD_META_METHOD_ERROR : ServiceEvent.SEARCH_SET_META_METHOD_ERROR;
					_service = TAT.getInstance().searchService;
					_action = (_vo.id == 0) ? TAT.getInstance().searchService.addMeta : TAT.getInstance().searchService.setMeta;
					_params = [_vo];
					break;
				case _vo is Query:
					_successType = (_vo.id == 0) ? ServiceEvent.QUERIES_ADD_QUERY_METHOD_SUCCESS : ServiceEvent.QUERIES_SET_QUERY_METHOD_SUCCESS;
					_errorType = (_vo.id == 0) ? ServiceEvent.QUERIES_ADD_QUERY_METHOD_ERROR : ServiceEvent.QUERIES_SET_QUERY_METHOD_ERROR;
					_service = TAT.getInstance().queriesService;
					_action = (_vo.id == 0) ? TAT.getInstance().queriesService.addQuery : TAT.getInstance().queriesService.setQuery;
					_params = [_vo];
					break;
				case _vo is Session:
					_successType = (_vo.id == 0) ? ServiceEvent.SESSIONS_ADD_SESSION_METHOD_SUCCESS : ServiceEvent.SESSIONS_SET_SESSION_METHOD_SUCCESS;
					_errorType = (_vo.id == 0) ? ServiceEvent.SESSIONS_ADD_SESSION_METHOD_ERROR : ServiceEvent.SESSIONS_SET_SESSION_METHOD_ERROR;
					_service = TAT.getInstance().sessionsService;
					_action = (_vo.id == 0) ? TAT.getInstance().sessionsService.addSession : TAT.getInstance().sessionsService.setSession;
					_params = [_vo];
					break;
				case _vo is User:
					_successType = (_vo.id == 0) ? ServiceEvent.USERS_ADD_USER_METHOD_SUCCESS : ServiceEvent.USERS_SET_USER_METHOD_SUCCESS;
					_errorType = (_vo.id == 0) ? ServiceEvent.USERS_ADD_USER_METHOD_ERROR : ServiceEvent.USERS_SET_USER_METHOD_ERROR;
					_service = TAT.getInstance().usersService;
					_action = (_vo.id == 0) ? TAT.getInstance().usersService.addUser : TAT.getInstance().usersService.setUser;
					_params = [_vo];
					break;
				case _vo is AbstractData:
					_successType = (_vo.id == 0) ? ServiceEvent.DATAS_ADD_DATA_METHOD_SUCCESS : ServiceEvent.DATAS_SET_DATA_METHOD_SUCCESS;
					_errorType = (_vo.id == 0) ? ServiceEvent.DATAS_ADD_DATA_METHOD_ERROR : ServiceEvent.DATAS_SET_DATA_METHOD_ERROR;
					_service = TAT.getInstance().datasService;
					_action = (_vo.id == 0) ? TAT.getInstance().datasService.addData : TAT.getInstance().datasService.setData;
					_params = [_vo];
					break;
				case _vo is AbstractMedia:
					_successType = (_vo.id == 0) ? ServiceEvent.MEDIAS_ADD_MEDIA_METHOD_SUCCESS : ServiceEvent.MEDIAS_SET_MEDIA_METHOD_SUCCESS;
					_errorType = (_vo.id == 0) ? ServiceEvent.MEDIAS_ADD_MEDIA_METHOD_ERROR : ServiceEvent.MEDIAS_SET_MEDIA_METHOD_ERROR;
					_service = TAT.getInstance().mediasService;
					_action = (_vo.id == 0) ? TAT.getInstance().mediasService.addMedia : TAT.getInstance().mediasService.setMedia;
					_params = [_vo];
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
			
			_result = event.result;
			
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
	}
}