package org.concert_urbain.touratour.api.vos.medias
{
	import org.concert_urbain.touratour.api.vos.IVo;
	
	[Bindable]
	
	public class SoundMedia extends AbstractMedia implements IVo
	{
		private var _url:String;
		private var _totalTime:int;
		
		public function SoundMedia(obj:Object = null)
		{
			super(obj);
		}
		
		
		//////////////////////////////////////

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
			_isSynchronized = false;
		}

		public function get totalTime():int
		{
			return _totalTime;
		}

		public function set totalTime(value:int):void
		{
			_totalTime = value;
			_isSynchronized = false;
		}
		
		
		////////////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_Media_Sound";
		}
		
		public function getSerialisableObject():Object
		{
			return {
				__className: this.__className,
				id: _id,
				title: _title,
				description: _description,
				preview: _preview,
				addDate: _addDate ? _getUTCDate(_addDate) : null,
				setDate: _setDate ? _getUTCDate(_setDate) : null,
				isValid: _isValid,
				users_id: _users_id,
				url: _url,
				totalTime: _totalTime
			};
		}
		
		////////////////////////////////////////////////////////////
		
		override public function getType():String
		{
			return "Sound"
		}


	}
}