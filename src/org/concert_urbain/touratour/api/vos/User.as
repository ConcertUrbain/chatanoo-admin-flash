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
	
	public class User extends AbstractVo implements IVo
	{
		private var _firstName:String;
		private var _lastName:String;
		private var _pseudo:String;
		private var _password:String;
		private var _email:String;
		private var _role:String;
		private var _addDate:Date;
		private var _setDate:Date;
		private var _isBan:Boolean;
		
		private var _datas:MultiVoCollection;
		
		private var _comments:VoCollection;
		private var _items:VoCollection;
		private var _medias:VoCollection;
		private var _queries:VoCollection;
		
		public function User(obj:Object = null)
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
		
		///////////////////////////////////////////////

		public function get firstName():String
		{
			return _firstName;
		}

		public function set firstName(value:String):void
		{
			_firstName = value;
			_isSynchronized = false;
		}

		public function get lastName():String
		{
			return _lastName;
		}

		public function set lastName(value:String):void
		{
			_lastName = value;
			_isSynchronized = false;
		}

		public function get pseudo():String
		{
			return _pseudo;
		}

		public function set pseudo(value:String):void
		{
			_pseudo = value;
			_isSynchronized = false;
		}

		public function get password():String
		{
			return _password;
		}

		public function set password(value:String):void
		{
			_password = value;
			_isSynchronized = false;
		}

		public function get email():String
		{
			return _email;
		}

		public function set email(value:String):void
		{
			_email = value;
			_isSynchronized = false;
		}

		public function get role():String
		{
			return _role;
		}

		public function set role(value:String):void
		{
			_role = value;
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

		public function get isBan():Boolean
		{
			return _isBan;
		}

		public function set isBan(value:Boolean):void
		{
			_isBan = value;
			_isSynchronized = false;
		}
		
		/////////////////////////////////////////////
		
		public function loadDatas():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.DATAS_CHILDREN_TYPE);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		public function loadItems():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.ITEMS_CHILDREN_TYPE);
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
		
		public function loadComments():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.COMMENTS_CHILDREN_TYPE);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		public function loadQueries():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.QUERIES_CHILDREN_TYPE);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		private function _cmdCompleteHandler(event:CommandEvent):void
		{
			var cmd:LoadVosCommand = event.target as LoadVosCommand;
			switch(cmd.childrenType)
			{
				case LoadVosCommand.DATAS_CHILDREN_TYPE:
					_datas = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_DATAS_SUCCESS));
					break;
				case LoadVosCommand.ITEMS_CHILDREN_TYPE:
					_items = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_ITEMS_SUCCESS));
					break;
				case LoadVosCommand.MEDIAS_CHILDREN_TYPE:
					_medias = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_MEDIAS_SUCCESS));
					break;
				case LoadVosCommand.COMMENTS_CHILDREN_TYPE:
					_comments = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_COMMENTS_SUCCESS));
					break;
				case LoadVosCommand.QUERIES_CHILDREN_TYPE:
					_queries = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_QUERIES_SUCCESS));
					break;
			}
		}
		
		private function _cmdErrorHandler(event:CommandEvent):void
		{
			var cmd:LoadVosCommand = event.target as LoadVosCommand;
			switch(cmd.childrenType)
			{
				case LoadVosCommand.DATAS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_DATAS_ERROR));
					break;
				case LoadVosCommand.ITEMS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_ITEMS_ERROR));
					break;
				case LoadVosCommand.MEDIAS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_MEDIAS_ERROR));
					break;
				case LoadVosCommand.COMMENTS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_COMMENTS_ERROR));
					break;
				case LoadVosCommand.QUERIES_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_QUERIES_ERROR));
					break;
			}
		}
		
		/////////////////////////////////////////////
		
		public function get datas():MultiVoCollection
		{
			return _datas;
		}
		
		public function set datas(value:MultiVoCollection):void
		{
			_datas = value;
			_isSynchronized = false;
		}
		
		public function get comments():VoCollection
		{
			return _comments;
		}
		
		public function set comments(value:VoCollection):void
		{
			_comments = value;
			_isSynchronized = false;
		}
		
		public function get items():VoCollection
		{
			return _items;
		}
		
		public function set items(value:VoCollection):void
		{
			_items = value;
			_isSynchronized = false;
		}
		
		public function get medias():VoCollection
		{
			return _medias;
		}
		
		public function set medias(value:VoCollection):void
		{
			_medias = value;
			_isSynchronized = false;
		}
		
		public function get queries():VoCollection
		{
			return _queries;
		}
		
		public function set queries(value:VoCollection):void
		{
			_queries = value;
			_isSynchronized = false;
		}
		
		//////////////////////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_User";
		}
		
		public function getSerialisableObject():Object
		{
			return {
				__className: this.__className,
				id: _id,
				firstName: _firstName,
				lastName: _lastName,
				pseudo: _pseudo,
				password: _password,
				email: _email,
				role: _role,
				addDate: _addDate ? _getUTCDate(_addDate) : null,
				setDate: _setDate ? _getUTCDate(_setDate) : null,
				isBan: _isBan
			};
		}


	}
}