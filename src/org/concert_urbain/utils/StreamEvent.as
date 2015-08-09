package org.concert_urbain.utils
{
	import flash.events.Event;
	import flash.net.NetStream;
	
	public class StreamEvent extends Event {
		
		public static const FMS_CONNEXION_ERROR:String = "FmsConnectionError";
		public static const FMS_CONNEXION_SUCCESS:String = "FmsConnectionSuccess";
		
		public static const STREAM_NOT_FOUND:String = "StreamNotFound";
		public static const STREAM_START:String = "StreamStart";
		public static const STREAM_PAUSE:String = "StreamPause";
		public static const STREAM_RESUME:String = "StreamResume";
		public static const STREAM_END:String = "StreamEnd";
		public static const STREAM_LOADING_PROGRESS:String = "StreamLoadingProgress";
		public static const STREAM_PLAYING_PROGRESS:String = "StreamPlayiningProgress";

		public var videoStream:NetStream;


		public function StreamEvent(type:String, stream:NetStream, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			videoStream = stream;
		}
		
		override public function clone():Event
		{
			return new StreamEvent(type, videoStream, bubbles, cancelable) ;
		}
	}
}