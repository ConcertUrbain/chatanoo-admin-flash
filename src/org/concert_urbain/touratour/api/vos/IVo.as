package org.concert_urbain.touratour.api.vos
{
	public interface IVo
	{
		function save(withSynchronize:Boolean = false):void;
		function synchronize():void;
		function erase():void;
		
		function get __className():String;
		function getSerialisableObject():Object;
		
		function get id():int;
	}
}