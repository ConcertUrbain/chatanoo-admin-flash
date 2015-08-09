package org.concert_urbain.touratour.DataGridVO
{
	import org.concert_urbain.touratour.api.vos.IVo;

	[Bindable]

	public class CommentDataGridItem extends DataGridItem
	{
		public var itemId:Number;
		public var vote:int;
		
		public function CommentDataGridItem(iType:String, iId:Number, iVO:IVo, iItemId:Number, iVote:int)
		{
			super(iType, iId, iVO);
			
			itemId = iItemId;
			vote = iVote;
		}
	}
}