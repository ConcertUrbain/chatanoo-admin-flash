package org.concert_urbain.touratour.api.vos.datas
{
	import org.concert_urbain.touratour.api.vos.IVo;
	
	[Bindable]
	
	public class CartoData extends AbstractData implements IVo
	{
		private var _x:Number;
		private var _y:Number;
		
		public function CartoData(obj:Object = null)
		{
			super(obj);
		}		
		
		////////////////////////////////////////////

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
			_isSynchronized = false;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
			_isSynchronized = false;
		}
		
		
		////////////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_Data_Carto";
		}
		
		public function getSerialisableObject():Object
		{
			return {
				__className: this.__className,
				id: _id,
				addDate: _addDate ? _getUTCDate(_addDate) : null,
				setDate: _setDate ? _getUTCDate(_setDate) : null,
				x: _x,
				y: _y
			};
		}
		
		////////////////////////////////////////////////////////////
		
		override public function getType():String
		{
			return "Carto"
		}

	}
}