package org.concert_urbain.touratour.api.core.commands
{
	import flash.events.IEventDispatcher;

	[Event(name="complete", type="org.concert_urbain.touratour.api.core.commands.CommandEvent")]
	[Event(name="error", type="org.concert_urbain.touratour.api.core.commands.CommandEvent")]
	public interface ICommand extends IEventDispatcher
	{
		function execute():void;
		function clear():void;
		
		function get result():*;
	}
}