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
	
	public class SynchronizeCommand extends AbstractCommand implements ICommand
	{
		private var _vo:IVo;
		
		private var _successType:String;
		private var _errorType:String;
		private var _action:Function;
		private var _service:AbstractService;
		private var _params:Array;
		
		private var _uiid:String;
		
		private var _result:*;
		
		public function SynchronizeCommand(vo:IVo)
		{
			_vo = vo;
			switch(true)
			{
				case _vo is Comment:
					_successType = ServiceEvent.COMMENTS_GET_COMMENT_BY_ID_SUCCESS;
					_errorType = ServiceEvent.COMMENTS_GET_COMMENT_BY_ID_ERROR;
					_service = TAT.getInstance().commentsService;
					_action = TAT.getInstance().commentsService.getCommentById;
					_params = [_vo.id];
					break;
				case _vo is Item:
					_successType = ServiceEvent.ITEMS_GET_ITEM_BY_ID_METHOD_SUCCESS;
					_errorType = ServiceEvent.ITEMS_GET_ITEM_BY_ID_METHOD_ERROR;
					_service = TAT.getInstance().itemsService;
					_action = TAT.getInstance().itemsService.getItemById;
					_params = [_vo.id];
					break;
				case _vo is Meta:
					_successType = ServiceEvent.SEARCH_GET_META_BY_ID_METHOD_SUCCESS;
					_errorType = ServiceEvent.SEARCH_GET_META_BY_ID_METHOD_ERROR;
					_service = TAT.getInstance().searchService;
					_action = TAT.getInstance().searchService.getMetaById;
					_params = [_vo.id];
					break;
				case _vo is Query:
					_successType = ServiceEvent.QUERIES_GET_QUERIES_METHOD_SUCCESS;
					_errorType = ServiceEvent.QUERIES_GET_QUERIES_METHOD_ERROR;
					_service = TAT.getInstance().queriesService;
					_action = TAT.getInstance().queriesService.getQueryById;
					_params = [_vo.id];
					break;
				case _vo is Session:
					_successType = ServiceEvent.SESSIONS_GET_SESSION_BY_ID_METHOD_SUCCESS;
					_errorType = ServiceEvent.SESSIONS_GET_SESSION_BY_ID_METHOD_ERROR;
					_service = TAT.getInstance().sessionsService;
					_action = TAT.getInstance().sessionsService.getSessionById;
					_params = [_vo.id];
					break;
				case _vo is User:
					_successType = ServiceEvent.USERS_GET_USER_BY_ID_METHOD_SUCCESS;
					_errorType = ServiceEvent.USERS_GET_USER_BY_ID_METHOD_ERROR;
					_service = TAT.getInstance().usersService;
					_action = TAT.getInstance().usersService.getUserById;
					_params = [_vo.id];
					break;
				case _vo is AbstractData:
					_successType = ServiceEvent.DATAS_GET_DATAS_BY_ID_METHOD_SUCCESS;
					_errorType = ServiceEvent.DATAS_GET_DATAS_BY_ID_METHOD_ERROR;
					_service = TAT.getInstance().datasService;
					_action = TAT.getInstance().datasService.getDatasById;
					_params = [_vo.id, AbstractData(_vo).getType()];
					break;
				case _vo is AbstractMedia:
					_successType = ServiceEvent.MEDIAS_GET_MEDIA_BY_ID_METHOD_SUCCESS;
					_errorType = ServiceEvent.MEDIAS_GET_MEDIA_BY_ID_METHOD_ERROR;
					_service = TAT.getInstance().mediasService;
					_action = TAT.getInstance().mediasService.getMediaById;
					_params = [_vo.id, AbstractMedia(_vo).getType()];
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