package org.concert_urbain.touratour.events
{
	import flash.events.Event;

	public class EditGridRowEvent extends Event
	{
		public static const EDIT_GRID_ROW:String = "EditGridRow";
		
		public function EditGridRowEvent(type:String = EDIT_GRID_ROW, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var data:Object;
		
	}
}