package org.concert_urbain.touratour.api.vos.medias
{
	import org.concert_urbain.touratour.api.vos.IVo;
	
	[Bindable]
	
	public class VideoMedia extends AbstractMedia implements IVo
	{
		private var _url:String;
		private var _width:Number;
		private var _height:Number;
		private var _totalTime:int;
		
		public function VideoMedia(obj:Object = null)
		{
			super(obj);
		}
		
		
		/////////////////////////////////////////////////

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
			_isSynchronized = false;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
			_isSynchronized = false;
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
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
		
		
		/////////////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_Media_Video";
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
				width: _width,
				height: _height,
				totalTime: _totalTime
			};
		}
		
		////////////////////////////////////////////////////////////
		
		override public function getType():String
		{
			return "Video"
		}


	}
}