package org.concert_urbain.touratour.DataGridVO
{
	import org.concert_urbain.touratour.api.vos.IVo;

	[Bindable]
	
	public class DataGridItem
	{
		public var type:String;
		public var id:Number;
		public var vo:IVo;
		
		public function DataGridItem(iType:String, iId:Number, iVO:IVo)
		{
			type = iType;
			id = iId;
			vo = iVO;
		}
		
		// Permet d'éviter le bug si "clic" sur le titre de la colonne d'un Datag
		public function get titre():String
		{
			return vo["titre"];
		}
		
		public function get name():String
		{
			return vo["name"];
		}
	}
}