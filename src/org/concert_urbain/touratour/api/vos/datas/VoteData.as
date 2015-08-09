package org.concert_urbain.touratour.api.vos.datas
{
	import org.concert_urbain.touratour.api.vos.AbstractVo;
	import org.concert_urbain.touratour.api.vos.IVo;
	import org.concert_urbain.touratour.api.vos.User;
	
	public class VoteData extends AbstractData implements IVo
	{
		private var _rate:int;
		private var _user:User;
		private var _users_id:int;
		
		public function VoteData(obj:Object = null)
		{
			super(obj);
		}
		
		override protected function _parseObj(obj:Object):void
		{
			for(var prop:String in obj)
			{
				switch(prop)
				{
					case 'user':
						// MATHIEU
						_users_id = obj['user'];
						_user = new User({id:_users_id });
						delete obj['user'];
						break;
					
						// DENIS
					case '_user':
						_users_id = obj[prop];
						_user = new User({ id: _users_id });
						break;
					case 'users_id':	
						this['_' + prop] = obj[prop];
						break;
				}
			}
			
			/*
			if(obj['user'])
			{
				_user = new User({id: obj['user']});
				delete obj['user'];
			}
			*/
			
			super._parseObj(obj);
		}
		
		//////////////////////////////////////////

		public function get rate():int
		{
			return _rate;
		}

		public function set rate(value:int):void
		{
			_rate = value;
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
		
		
		///////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_Data_Vote";
		}
		
		public function getSerialisableObject():Object
		{
			return {
				__className: this.__className,
				id: _id,
				addDate: _addDate ? _getUTCDate(_addDate) : null,
				setDate: _setDate ? _getUTCDate(_setDate) : null,
				rate: _rate,
				users_id: _users_id
			};
		}
		
		////////////////////////////////////////////////////////////
		
		override public function getType():String
		{
			return "Vote"
		}


	}
}