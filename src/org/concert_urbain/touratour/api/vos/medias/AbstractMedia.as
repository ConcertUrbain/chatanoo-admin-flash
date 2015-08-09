package org.concert_urbain.touratour.api.vos.medias
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.commands.LoadVosCommand;
	import org.concert_urbain.touratour.api.core.commands.CommandEvent;
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.vos.AbstractVo;
	import org.concert_urbain.touratour.api.vos.IVo;
	import org.concert_urbain.touratour.api.vos.User;
	import org.concert_urbain.touratour.api.vos.collections.MultiVoCollection;
	import org.concert_urbain.touratour.api.vos.collections.VoCollection;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;
	
	[Bindable]
	
	public class AbstractMedia extends AbstractVo
	{
		protected var _title:String;
		protected var _description:String;
		protected var _preview:String;
		protected var _addDate:Date;
		protected var _setDate:Date;
		protected var _isValid:Boolean;
		protected var _users_id:int;
		
		protected var _user:User;
		protected var _datas:MultiVoCollection;
		protected var _metas:VoCollection;
		
		public function AbstractMedia(obj:Object = null)
		{
			if(obj) _parseObj(obj);
		}
		
		override protected function _parseObj(obj:Object):void
		{
			var sync:Boolean = false;
			for(var prop:String in obj)
			{
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
					case 'id':
						this['_' + prop] = obj[prop];
						break;
					default:
						this[prop] = obj[prop];
						break;
				}
			}
			_isSynchronized = sync;
		}
		
		/////////////////////////////////////////////
		
		public function loadMetas():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this as IVo, LoadVosCommand.METAS_CHILDREN_TYPE);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		public function loadDatas():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this as IVo, LoadVosCommand.DATAS_CHILDREN_TYPE);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		private function _cmdCompleteHandler(event:CommandEvent):void
		{
			var cmd:LoadVosCommand = event.target as LoadVosCommand;
			switch(cmd.childrenType)
			{
				case LoadVosCommand.METAS_CHILDREN_TYPE:
					_metas = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_METAS_SUCCESS));
					break;
				case LoadVosCommand.DATAS_CHILDREN_TYPE:
					_datas = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_DATAS_SUCCESS));
					break;
			}
		}
		
		private function _cmdErrorHandler(event:CommandEvent):void
		{
			var cmd:LoadVosCommand = event.target as LoadVosCommand;
			switch(cmd.childrenType)
			{
				case LoadVosCommand.METAS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_METAS_ERROR));
					break;
				case LoadVosCommand.DATAS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_DATAS_ERROR));
					break;
			}
		}
		
		/////////////////////////////////////

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
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

		public function get preview():String
		{
			return _preview;
		}

		public function set preview(value:String):void
		{
			_preview = value;
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
		
		//////////////////////////////////////
		
		public function get datas():MultiVoCollection
		{
			return _datas;
		}
		
		public function set datas(value:MultiVoCollection):void
		{
			_datas = value;
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
		
		////////////////////////////////////////
		
		public function getType():String
		{
			return "Abstract";
		}


	}
}