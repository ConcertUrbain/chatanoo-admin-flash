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
	import org.concert_urbain.touratour.api.vos.factory.VoFactory;
	import org.concert_urbain.touratour.api.vos.medias.AbstractMedia;
	
	public class RemoveVoCommand extends AbstractCommand implements ICommand
	{
		
		private var _vo:IVo;
		private var _parentVo:IVo;
		
		private var _successType:String;
		private var _errorType:String;
		private var _action:Function;
		private var _service:AbstractService;
		private var _params:Array;
		
		private var _uiid:String;
		
		private var _result:*;
		
		public function RemoveVoCommand(vo:IVo, parentVo:IVo)
		{
			_vo = vo;
			_parentVo = _parentVo;
			switch(_parentVo.__className)
			{
				case VoFactory.COMMENT_TYPE:
					switch(vo.__className)
					{
						case VoFactory.DATA_ADDRESS_TYPE:
						case VoFactory.DATA_CARTO_TYPE:
						case VoFactory.DATA_VOTE_TYPE:
							_successType = ServiceEvent.COMMENTS_REMOVE_DATA_FORM_COMMENT_SUCCESS;
							_errorType = ServiceEvent.COMMENTS_REMOVE_DATA_FORM_COMMENT_ERROR;
							_service = TAT.getInstance().commentsService;
							_action = TAT.getInstance().commentsService.removeDataFromComment;
							_params = [_vo.id, AbstractData(_vo).getType(), _parentVo.id];
							break;
					}
					break;
				case VoFactory.ITEM_TYPE:
					switch(vo.__className)
					{
						case VoFactory.COMMENT_TYPE:
							_successType = ServiceEvent.ITEMS_REMOVE_COMMENT_FROM_ITEM_METHOD_SUCCESS;
							_errorType = ServiceEvent.ITEMS_REMOVE_COMMENT_FROM_ITEM_METHOD_ERROR;
							_service = TAT.getInstance().itemsService;
							_action = TAT.getInstance().itemsService.removeCommentFormItem;
							_params = [_vo.id, _parentVo.id];
							break;
						case VoFactory.META_TYPE:
							_successType = ServiceEvent.ITEMS_REMOVE_META_FROM_ITEM_METHOD_SUCCESS;
							_errorType = ServiceEvent.ITEMS_REMOVE_META_FROM_ITEM_METHOD_ERROR;
							_service = TAT.getInstance().itemsService;
							_action = TAT.getInstance().itemsService.removeMetaFromItem;
							_params = [_vo.id, _parentVo.id];
							break;
						case VoFactory.DATA_ADDRESS_TYPE:
						case VoFactory.DATA_CARTO_TYPE:
						case VoFactory.DATA_VOTE_TYPE:
							_successType = ServiceEvent.ITEMS_REMOVE_DATA_FROM_ITEM_METHOD_SUCCESS;
							_errorType = ServiceEvent.ITEMS_REMOVE_DATA_FROM_ITEM_METHOD_ERROR;
							_service = TAT.getInstance().itemsService;
							_action = TAT.getInstance().itemsService.removeDataFromItem;
							_params = [_vo.id, AbstractData(_vo).getType(), _parentVo.id];
							break;
						case VoFactory.MEDIA_PICTURE_TYPE:
						case VoFactory.MEDIA_SOUND_TYPE:
						case VoFactory.MEDIA_TEXT_TYPE:
						case VoFactory.MEDIA_VIDEO_TYPE:
							_successType = ServiceEvent.ITEMS_REMOVE_MEDIA_FROM_ITEM_METHOD_SUCCESS;
							_errorType = ServiceEvent.ITEMS_REMOVE_MEDIA_FROM_ITEM_METHOD_ERROR;
							_service = TAT.getInstance().itemsService;
							_action = TAT.getInstance().itemsService.removeMediaFromItem;
							_params = [_vo.id, AbstractMedia(_vo).getType(), _parentVo.id];
							break;
					}
					break;
				case VoFactory.QUERY_TYPE:
					switch(vo.__className)
					{
						case VoFactory.ITEM_TYPE:
							_successType = ServiceEvent.QUERIES_REMOVE_ITEM_INTO_QUERY_METHOD_SUCCESS;
							_errorType = ServiceEvent.QUERIES_REMOVE_ITEM_INTO_QUERY_METHOD_ERROR;
							_service = TAT.getInstance().queriesService;
							_action = TAT.getInstance().queriesService.removeItemFromQuery;
							_params = [_vo.id, _parentVo.id];
							break;
						case VoFactory.META_TYPE:
							_successType = ServiceEvent.QUERIES_REMOVE_META_FROM_QUERY_METHOD_SUCCESS;
							_errorType = ServiceEvent.QUERIES_REMOVE_META_FROM_QUERY_METHOD_ERROR;
							_service = TAT.getInstance().queriesService;
							_action = TAT.getInstance().queriesService.removeMetaFromQuery;
							_params = [_vo.id, _parentVo.id];
							break;
						case VoFactory.DATA_ADDRESS_TYPE:
						case VoFactory.DATA_CARTO_TYPE:
						case VoFactory.DATA_VOTE_TYPE:
							_successType = ServiceEvent.QUERIES_REMOVE_DATA_FROM_QUERY_METHOD_SUCCESS;
							_errorType = ServiceEvent.QUERIES_REMOVE_DATA_FROM_QUERY_METHOD_ERROR;
							_service = TAT.getInstance().queriesService;
							_action = TAT.getInstance().queriesService.removeDataFromQuery;
							_params = [_vo.id, AbstractData(_vo).getType(), _parentVo.id];
							break;
						case VoFactory.MEDIA_PICTURE_TYPE:
						case VoFactory.MEDIA_SOUND_TYPE:
						case VoFactory.MEDIA_TEXT_TYPE:
						case VoFactory.MEDIA_VIDEO_TYPE:
							_successType = ServiceEvent.QUERIES_REMOVE_MEDIA_FROM_QUERY_METHOD_SUCCESS;
							_errorType = ServiceEvent.QUERIES_REMOVE_MEDIA_FROM_QUERY_METHOD_ERROR;
							_service = TAT.getInstance().queriesService;
							_action = TAT.getInstance().queriesService.removeMediaFromQuery;
							_params = [_vo.id, AbstractMedia(_vo).getType(), _parentVo.id];
							break;
					}
					break;
				case VoFactory.SESSION_TYPE:
					switch(vo.__className)
					{
						case VoFactory.QUERY_TYPE:
							_successType = ServiceEvent.SESSIONS_REMOVE_QUERY_FROM_SESSION_METHOD_SUCCESS;
							_errorType = ServiceEvent.SESSIONS_REMOVE_QUERY_FROM_SESSION_METHOD_ERROR;
							_service = TAT.getInstance().sessionsService;
							_action = TAT.getInstance().sessionsService.removeQueryFromSession;
							_params = [_vo.id, _parentVo.id];
							break;
						case VoFactory.META_TYPE:
							_successType = ServiceEvent.SESSIONS_REMOVE_META_FROM_SESSION_METHOD_SUCCESS;
							_errorType = ServiceEvent.SESSIONS_REMOVE_META_FROM_SESSION_METHOD_ERROR;
							_service = TAT.getInstance().sessionsService;
							_action = TAT.getInstance().sessionsService.removeMetaFromSession;
							_params = [_vo.id, _parentVo.id];
							break;
					}
					break;
				case VoFactory.USER_TYPE:
					switch(vo.__className)
					{
						case VoFactory.DATA_ADDRESS_TYPE:
						case VoFactory.DATA_CARTO_TYPE:
						case VoFactory.DATA_VOTE_TYPE:
							_successType = ServiceEvent.USERS_REMOVE_DATA_FROM_USER_METHOD_SUCCESS;
							_errorType = ServiceEvent.USERS_REMOVE_DATA_FROM_USER_METHOD_ERROR;
							_service = TAT.getInstance().usersService;
							_action = TAT.getInstance().usersService.removeDataFromUser;
							_params = [_vo.id, AbstractData(_vo).getType(), _parentVo.id];
							break;
					}
					break;
				case VoFactory.META_TYPE:
					switch(vo.__className)
					{
					}
					break;
				case VoFactory.MEDIA_PICTURE_TYPE:
				case VoFactory.MEDIA_SOUND_TYPE:
				case VoFactory.MEDIA_TEXT_TYPE:
				case VoFactory.MEDIA_VIDEO_TYPE:
					switch(vo.__className)
					{
						case VoFactory.META_TYPE:
							_successType = ServiceEvent.MEDIAS_REMOVE_META_FORM_MEDIA_METHOD_SUCCESS;
							_errorType = ServiceEvent.MEDIAS_REMOVE_META_FORM_MEDIA_METHOD_ERROR;
							_service = TAT.getInstance().mediasService;
							_action = TAT.getInstance().mediasService.removeMetaFromMedia;
							_params = [_vo.id, _parentVo.id];
							break;
						case VoFactory.DATA_ADDRESS_TYPE:
						case VoFactory.DATA_CARTO_TYPE:
						case VoFactory.DATA_VOTE_TYPE:
							_successType = ServiceEvent.MEDIAS_REMOVE_DATA_FROM_MEDIA_METHOD_SUCCESS;
							_errorType = ServiceEvent.MEDIAS_REMOVE_DATA_FROM_MEDIA_METHOD_ERROR;
							_service = TAT.getInstance().mediasService;
							_action = TAT.getInstance().mediasService.removeDataFromMedia;
							_params = [_vo.id, AbstractData(_vo).getType(), _parentVo.id];
							break;
					}
					break;
				case VoFactory.DATA_ADDRESS_TYPE:
				case VoFactory.DATA_CARTO_TYPE:
				case VoFactory.DATA_VOTE_TYPE:
					switch(vo.__className)
					{
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
			
			///
			
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

		public function get parentVo():IVo
		{
			return _parentVo;
		}

	}
}