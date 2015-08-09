package org.concert_urbain.dring
{
	import flash.events.Event;
	
	public class VoteEvent extends Event
	{	
		public var id:String;
		public var vote:int;
		public var comment:String;
		public var date:Date;

		public function VoteEvent(type:String, msgId:String, voteValue:int, voteComment:String, voteDate:Date, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			id = msgId;
			vote = voteValue;
			comment = voteComment;
			date = voteDate;
		}
		
		override public function clone():Event
		{
			return new VoteEvent(type, id, vote, comment, date, bubbles, cancelable) ;
		}
	}
}
