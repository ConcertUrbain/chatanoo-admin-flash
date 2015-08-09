package org.concert_urbain.touratour.api.vos.datas
{
	import org.concert_urbain.touratour.api.vos.IVo;
	
	public class AddressData extends AbstractData implements IVo
	{
		private var _address:String;
		private var _zipCode:String;
		private var _city:String;
		private var _country:String;
		
		public function AddressData(obj:Object = null)
		{
			super(obj);
		}
		
		
		/////////////////////////////////////////////////////

		public function get address():String
		{
			return _address;
		}

		public function set address(value:String):void
		{
			_address = value;
			_isSynchronized = false;
		}

		public function get zipCode():String
		{
			return _zipCode;
		}

		public function set zipCode(value:String):void
		{
			_zipCode = value;
			_isSynchronized = false;
		}

		public function get city():String
		{
			return _city;
		}

		public function set city(value:String):void
		{
			_city = value;
			_isSynchronized = false;
		}

		public function get country():String
		{
			return _country;
		}

		public function set country(value:String):void
		{
			_country = value;
			_isSynchronized = false;
		}
		
		
		///////////////////////////////////////////////////////////
		
		public function get __className():String
		{
			return "Vo_Data_Adress";
		}
		
		public function getSerialisableObject():Object
		{
			return {
				__className: this.__className,
				id: _id,
				addDate: _addDate ? _getUTCDate(_addDate) : null,
				setDate: _setDate ? _getUTCDate(_setDate) : null,
				adress: _address,
				zipCode: _zipCode,
				city: _city,
				country: _country
			};
		}
		
		////////////////////////////////////////////////////////////
		
		override public function getType():String
		{
			return "Adress"
		}


	}
}