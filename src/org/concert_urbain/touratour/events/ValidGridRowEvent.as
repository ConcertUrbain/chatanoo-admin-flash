package org.concert_urbain.touratour.events
{
	import flash.events.Event;

	public class ValidGridRowEvent extends Event
	{
		public static const VALID_GRID_ROW:String = "ValidGridRow";
		
		public function ValidGridRowEvent(type:String = VALID_GRID_ROW, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var data:Object;
		
	}
}