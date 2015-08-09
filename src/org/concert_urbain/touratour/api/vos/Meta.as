package org.concert_urbain.touratour.api.vos
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;
	
	[Bindable]
	
	public class Meta extends AbstractVo implements IVo
	{
		private var _name:String;
		private var _content:String;
		
		public function Meta(obj:Object = null)
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

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
			_isSynchronized = false;
		}

		public function get content():String
		{
			return _content;
		}

		public function set content(value:String):void
		{
			_content = value;
			_isSynchronized = false;
		}
		
		
		///////////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_Meta";
		}
		
		public function getSerialisableObject():Object
		{
			return {
				__className: this.__className,
				id: _id,
				name: _name,
				content: _content
			};
		}


	}
}