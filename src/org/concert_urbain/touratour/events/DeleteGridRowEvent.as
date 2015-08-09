package org.concert_urbain.touratour.events
{
	import flash.events.Event;

	public class DeleteGridRowEvent extends Event
	{
		public static const DELETE_GRID_ROW:String = "DeleteGridRow";
		
		public function DeleteGridRowEvent(type:String = DELETE_GRID_ROW, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var data:Object;
		
	}
}