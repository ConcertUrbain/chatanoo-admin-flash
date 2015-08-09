package org.concert_urbain.touratour.api.vos
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.commands.LoadVosCommand;
	import org.concert_urbain.touratour.api.core.commands.CommandEvent;
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.vos.collections.VoCollection;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;
	
	public class Session extends AbstractVo implements IVo
	{
		private var _title:String;
		private var _description:String;
		private var _addDate:Date;
		private var _setDate:Date;
		private var _publishDate:Date;
		private var _endDate:Date;
		
		private var _user:User;
		private var _queries:VoCollection;
		private var _metas:VoCollection;
		
		public function Session(obj:Object = null)
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
						_user = new User({ id: obj[prop] });
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
		
		public function loadQueries():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(this, LoadVosCommand.QUERIES_CHILDREN_TYPE);
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
		
		private function _cmdCompleteHandler(event:CommandEvent):void
		{
			var cmd:LoadVosCommand = event.target as LoadVosCommand;
			switch(cmd.childrenType)
			{
				case LoadVosCommand.QUERIES_CHILDREN_TYPE:
					_queries = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_QUERIES_SUCCESS));
					break;
				case LoadVosCommand.METAS_CHILDREN_TYPE:
					_metas = cmd.result;
					dispatchEvent(new VoEvent(VoEvent.LOAD_METAS_SUCCESS));
					break;
			}
		}
		
		private function _cmdErrorHandler(event:CommandEvent):void
		{
			var cmd:LoadVosCommand = event.target as LoadVosCommand;
			switch(cmd.childrenType)
			{
				case LoadVosCommand.QUERIES_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_QUERIES_ERROR));
					break;
				case LoadVosCommand.METAS_CHILDREN_TYPE:
					dispatchEvent(new VoEvent(VoEvent.LOAD_METAS_ERROR));
					break;
			}
		}
		
		///////////////////////////////////////////////////////////

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
		
		/////////////////////////////////////////////////
		
		public function get queries():VoCollection
		{
			return _queries;
		}
		
		public function set queries(value:VoCollection):void
		{
			_queries = value;
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
		
		/////////////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_Session";
		}
		
		public function getSerialisableObject():Object
		{
			return {
				__className: this.__className,
				id: _id,
				title: _title,
				description: _description,
				addDate: _addDate ? _getUTCDate(_addDate) : null,
				setDate: _setDate ? _getUTCDate(_setDate) : null,
				publishDate: _publishDate ? _getUTCDate(_publishDate) : null,
				endDate: _endDate ? _getUTCDate(_endDate) : null
			};
		}

	}
}