package org.concert_urbain.touratour.api.vos
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.commands.LoadVosCommand;
	import org.concert_urbain.touratour.api.commands.SaveCommand;
	import org.concert_urbain.touratour.api.commands.SynchronizeCommand;
	import org.concert_urbain.touratour.api.core.commands.CommandEvent;
	import org.concert_urbain.touratour.api.core.commands.ICommand;
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.vos.collections.MultiVoCollection;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;
	import org.concert_urbain.touratour.api.vos.factory.VoFactory;
	import org.concert_urbain.touratour.api.vos.datas.VoteData;


	[Bindable]
	
	public class Comment extends AbstractVo implements IVo
	{				
		private var _content:String;
		private var _isValid:Boolean;
		private var _addDate:Date;
		private var _setDate:Date;
		private var _items_id:int;
		private var _users_id:int;
		
		private var _item:Item;
		private var _user:User;
		private var _datas:MultiVoCollection;
		
		// On stocke le vote pour ne pas à le demander plusieurs fois au serveur
		// DENIS
		private var _vote:Number;
		private var _isVoteLoaded:Boolean;

		
		public function Comment(obj:Object = null)
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
					case '_item':
						_items_id = obj[prop];
						_item = new Item({ id: _items_id });
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
					case 'users_id':	
					case 'items_id':	
						this['_' + prop] = obj[prop];
						break;
					case 'vote':
					case 'isVoteLoaded':
						break;
					default:
						this[prop] = obj[prop];
						break;
				}
			}
			_isSynchronized = sync;
		}
		
		/////////////////////////////////////////////
		
		public function loadDatas():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.DATAS_CHILDREN_TYPE);
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
			}
		}
		
		// GETTER - SETTER
		public function get content():String
		{
			return _content;
		}
		
		public function set content(s:String):void
		{
			_content = s;
			_isSynchronized = false;
		}
		
		public function get isValid():Boolean
		{
			return _isValid;
		}
		
		public function set isValid(b:Boolean):void
		{
			_isValid = b;
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
		
		
		public function get item():Item
		{
			return _item;
		}
		
		public function set item(value:Item):void
		{
			_item = value;
			_items_id = _item.id;
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

		public function get items_id():int
		{
			return _items_id;
		}
		
		public function set items_id(value:int):void
		{
			_items_id = value;
		}
		
		////////////////////////////////////////////////
		
		public function get __className():String
		{
			return VoFactory.COMMENT_TYPE
		}
		
		public function getSerialisableObject():Object
		{
			return {
				__className: this.__className,
				id: _id,
				content: _content,
				isValid: _isValid,
				users_id: _users_id,
				items_id: _items_id,
				addDate: _addDate ? _getUTCDate(_addDate) : null,
				setDate: _setDate ? _getUTCDate(_setDate) : null
			};
		}


		////////////////////////////////////////////////
		// DENIS

		
		// Vote
		
		public function setVote(v:Number):void
		{
			_vote = v;
		}
		
		public function getVote():Number
		{
			return _vote;
		}
		
		
		public function setVoteLoaded(b:Boolean):void
		{
			_isVoteLoaded = b;
		}
		
		public function isVoteLoaded():Boolean
		{
			return _isVoteLoaded;
		}

		
		public function getVoteData():VoteData
		{
			if (_datas)
			{
				var prop:String;
				
				for (prop in _datas)
				{
					var typeResult:Object = _datas[prop];
					if (typeResult is Array)
					{
						var i:uint;
						var n:uint = typeResult.length
						var dataVO:VoteData;
						for (i=0; i<n; i++)
						{
							if (typeResult[i] is VoteData)
							{
								dataVO = typeResult[i] as VoteData;
								return dataVO as VoteData;
							}
						}
					}
				}
			}
			return null;
		}
		
		
		
		
		// DENIS
		
		//
		// Méthode statique : valeur du vote (VOs de type "DataVoteVO" )
		//
		
		// ??? MultiVoCollection
		
		public static function computeVote(dataArray:*):Number
		{
			var somme:Number = 0;
			var prop:String;
			
			for (prop in dataArray)
			{
				var typeResult:Object = dataArray[prop];
				if (typeResult is Array)
				{
					var i:uint;
					var n:uint = typeResult.length
					var dataVO:VoteData;
					for (i=0; i<n; i++)
					{
						if (typeResult[i] is VoteData)
						{
							dataVO = typeResult[i] as VoteData;
							return Number(dataVO.rate);
						}
					}
				}
			}
			return somme;
		}

	}
}