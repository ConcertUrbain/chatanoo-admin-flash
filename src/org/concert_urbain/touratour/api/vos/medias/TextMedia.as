package org.concert_urbain.touratour.api.vos.medias
{
	import org.concert_urbain.touratour.api.vos.IVo;
	
	[Bindable]
	
	public class TextMedia extends AbstractMedia implements IVo
	{
		private var _content:String
		
		public function TextMedia(obj:Object = null)
		{
			super(obj);
		}
		
		
		////////////////////////////////////////////////

		public function get content():String
		{
			return _content;
		}

		public function set content(value:String):void
		{
			_content = value;
			_isSynchronized = false;
		}
		
		
		//////////////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_Media_Text";
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
				content: _content
			};
		}
		
		////////////////////////////////////////////////////////////
		
		override public function getType():String
		{
			return "Text"
		}

	}
}