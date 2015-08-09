package org.concert_urbain.touratour.api.vos.datas
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.vos.AbstractVo;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;
	
	public class AbstractData extends AbstractVo
	{
		protected var _addDate:Date;
		protected var _setDate:Date;
		
		public function AbstractData(obj:Object = null)
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
		
		
		////////////////////////////////////////

		public function get addDate():Date
		{
			return _addDate;
		}

		public function get setDate():Date
		{
			return _setDate;
		}
		
		//////////////////////////////////////
		
		public function getType():String
		{
			return "Abstract";
		}


	}
}