package org.concert_urbain.touratour.api.core.commands
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	public class AbstractCommand extends EventDispatcher
	{
		public function AbstractCommand()
		{
			if(getQualifiedClassName(this) == "org.concert_urbain.touratour.api.core.commands::AbstractCommand")
				throw new Error("Extend AbstractCommand. Don't instanciate this directily");
		}

		public function clear():void
		{
		}

	}
}