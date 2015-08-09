package org.concert_urbain.touratour.api.vos
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.commands.LoadVosCommand;
	import org.concert_urbain.touratour.api.core.commands.CommandEvent;
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.vos.collections.MultiVoCollection;
	import org.concert_urbain.touratour.api.vos.collections.VoCollection;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;

	[Bindable]
	
	public class Query extends AbstractVo implements IVo
	{
		private var _content:String;
		private var _description:String;
		private var _addDate:Date;
		private var _setDate:Date;
		private var _publishDate:Date;
		private var _endDate:Date;
		private var _isValid:Boolean;
		private var _users_id:int;
		
		
		private var _user:User;
		private var _items:VoCollection;
		private var _metas:VoCollection;
		private var _medias:MultiVoCollection;
		private var _datas:MultiVoCollection;
		
		public function Query(obj:Object = null)
		{
			if(obj) _parseObj(obj);
		}
		
		override protected function _parseObj(obj:Object):void
		{
			var sync:Boolean = false;
			for(var prop:String in obj)
			{
				
				// trace(prop, obj[prop])
				
				switch(prop)
				{
					case '__className':
						sync = true;
						break;
					case '_user':
						_users_id = obj[prop];
						_user = new User({ id: _users_id });
						break;
					case 'addDate':
					case 'setDate':
						this['_' + prop] = _parseUTCDate(obj[prop]);
						break;
					case 'publishDate':
					case 'endDate':
						this[prop] = _parseUTCDate(obj[prop]);
						break;
					case 'id':
					case 'users_id':	
						this['_' + prop] = obj[prop];
						break;
					case '_isValid':
						this[prop] = (obj[prop] == "1") || (obj[prop] == "true") ;
						break;
					
					default:
						this[prop] = obj[prop];
						break;
				}
			}
			_isSynchronized = sync;
			
			// trace("--> isValid", isValid);
		}
		
		/////////////////////////////////////////////
		
		public function loadItems():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.ITEMS_CHILDREN_TYPE);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		public function loadMetas():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.METAS_CHILDREN_TYPE);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		public function loadDatas():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.DATAS_CHILDREN_TYPE);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		public function loadMedias():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.MEDIAS_CHILDREN_TYPE);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		private function _cmdCompleteHandler(event:CommandEvent):void
		{
			var cmd:LoadVosCommand = event.target as LoadVosCommand;
			switch(cmd.childrenType)
			{
				case LoadVosCommand.ITEMS_CHILDREN_TYPE:
					_items = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_ITEMS_SUCCESS));
					break;
				case LoadVosCommand.METAS_CHILDREN_TYPE:
					_metas = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_METAS_SUCCESS));
					break;
				case LoadVosCommand.DATAS_CHILDREN_TYPE:
					_datas = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_DATAS_SUCCESS));
					break;
				case LoadVosCommand.MEDIAS_CHILDREN_TYPE:
					_medias = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_MEDIAS_SUCCESS));
					break;
			}
		}
		
		private function _cmdErrorHandler(event:CommandEvent):void
		{
			var cmd:LoadVosCommand = event.target as LoadVosCommand;
			switch(cmd.childrenType)
			{
				case LoadVosCommand.ITEMS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_ITEMS_ERROR));
					break;
				case LoadVosCommand.METAS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_METAS_ERROR));
					break;
				case LoadVosCommand.DATAS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_DATAS_ERROR));
					break;
				case LoadVosCommand.MEDIAS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_MEDIAS_ERROR));
					break;
			}
		}
		
		//////////////////////////////////////////

		public function get content():String
		{
			return _content;
		}

		public function set content(value:String):void
		{
			_content = value;
			_isSynchronized = false;
		}

		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
			_isSynchronized = false;
		}

		public function get addDate():Date
		{
			return _addDate;
		}

		public function get setDate():Date
		{
			return _setDate;
		}

		public function get publishDate():Date
		{
			return _publishDate;
		}

		public function set publishDate(value:Date):void
		{
			_publishDate = value;
			_isSynchronized = false;
		}

		public function get endDate():Date
		{
			return _endDate;
		}

		public function set endDate(value:Date):void
		{
			_endDate = value;
			_isSynchronized = false;
		}

		public function get isValid():Boolean
		{
			return _isValid;
		}

		public function set isValid(value:Boolean):void
		{
			_isValid = value;
			_isSynchronized = false;
		}
		
		
		//
		// DENIS
		//
		
		public function setUser(value:User):void
		{
			_user = value;
			_users_id = _user.id;
			_isSynchronized = false;
		}
		
		public function get users_id():int
		{
			return _users_id;
		}
		
		public function set users_id(id:int):void
		{
			_users_id = id;
		}
		
		///////////////////////////////////////////////
		
		public function get items():VoCollection
		{
			return _items;
		}
		
		public function set items(value:VoCollection):void
		{
			_items = value;
			_isSynchronized = false;
		}
		
		public function get metas():VoCollection
		{
			return _metas;
		}
		
		public function set metas(value:VoCollection):void
		{
			_metas = value;
			_isSynchronized = false;
		}
		
		public function get medias():MultiVoCollection
		{
			return _medias;
		}
		
		public function set medias(value:MultiVoCollection):void
		{
			_medias = value;
			_isSynchronized = false;
		}
		
		public function get datas():MultiVoCollection
		{
			return _datas;
		}
		
		public function set datas(value:MultiVoCollection):void
		{
			_datas = value;
			_isSynchronized = false;
		}		
		
		///////////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_Query";
		}
		
		public function getSerialisableObject():Object
		{
			return {
				__className: this.__className,
				id: _id,
				content: _content,
				description: _description,
				addDate: _addDate ? _getUTCDate(_addDate) : null,
				setDate: _setDate ? _getUTCDate(_setDate) : null,
				publishDate: _publishDate ? _getUTCDate(_publishDate) : null,
				endDate: _endDate ? _getUTCDate(_endDate) : null,
				users_id: _users_id,
				isValid: _isValid
			};
		}


	}
}