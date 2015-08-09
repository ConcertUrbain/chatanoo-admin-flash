package org.concert_urbain.touratour.api.vos
{
	import flash.events.EventDispatcher;
	
	import org.concert_urbain.touratour.api.commands.EraseCommand;
	import org.concert_urbain.touratour.api.commands.SaveCommand;
	import org.concert_urbain.touratour.api.commands.SynchronizeCommand;
	import org.concert_urbain.touratour.api.core.commands.CommandEvent;
	import org.concert_urbain.touratour.api.core.commands.ICommand;
	import org.concert_urbain.touratour.api.core.commands.MacroCommand;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;

	public class AbstractVo extends EventDispatcher
	{
		protected var _id:int;
		
		protected var _isSynchronized:Boolean;
		protected var _isSaved:Boolean;
		
		public function AbstractVo()
		{
		}
		
		protected function _parseObj(obj:Object):void
		{
			
		}
		
		public function get id():int
		{
			return _id;
		}

		//
		// DENIS
		//
		
		public function updateProps(obj:Object):void
		{
			_parseObj(obj);
		}
		
		public function set id(voId:int):void
		{
			_id = voId;
		}
		
		
		

		public function get isSynchronized():Boolean
		{
			return _isSynchronized;
		}
		
		
		/////////////////////////////////////////////////////////////
		
		public function save(withSynchronize:Boolean = false):void
		{
			var cmd:ICommand;
			if(withSynchronize)
			{
				cmd = new SaveCommand(this as IVo);
			}
			else
			{
				cmd = new MacroCommand(true, true);
				MacroCommand(cmd).addCommand(new SaveCommand(this as IVo));
				MacroCommand(cmd).addCommand(new SynchronizeCommand(this as IVo));
			}
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		public function synchronize():void
		{
			var cmd:SynchronizeCommand = new SynchronizeCommand(this as IVo);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		public function erase():void
		{
			var cmd:EraseCommand = new EraseCommand(this as IVo);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		private function _cmdCompleteHandler(event:CommandEvent):void
		{
			var cmd:ICommand = event.target as ICommand;
			cmd.removeEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.removeEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			
			switch(true)
			{
				case cmd is SaveCommand:
					
					_isSaved = true;
					_isSynchronized = false;
					
					dispatchEvent(new VoEvent(VoEvent.SAVE_SUCCESS));
					break;
				case cmd is MacroCommand:
					
					_isSaved = true;
					_isSynchronized = true;
					
					_parseObj(MacroCommand(cmd).getCommandAt(1).result);
					
					dispatchEvent(new VoEvent(VoEvent.SAVE_SUCCESS));
					break;
				case cmd is SynchronizeCommand:
					_parseObj(cmd.result);
					
					_isSaved = true;
					_isSynchronized = true;
					
					dispatchEvent(new VoEvent(VoEvent.SYNCHRONIZE_SUCCESS));
					break;
				case cmd is EraseCommand:
					_id = 0;
					
					_isSaved = false;
					_isSynchronized = false;
					
					dispatchEvent(new VoEvent(VoEvent.ERASE_SUCCESS));
					break;
			}
		}
		
		private function _cmdErrorHandler(event:CommandEvent):void
		{
			var cmd:ICommand = event.target as ICommand;
			cmd.removeEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.removeEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			
			switch(true)
			{
				case cmd as SaveCommand:
				case cmd is MacroCommand:
					dispatchEvent(new VoEvent(VoEvent.SAVE_ERROR));
					break;
				case cmd as SynchronizeCommand:
					dispatchEvent(new VoEvent(VoEvent.SYNCHRONIZE_ERROR));
					break;
				case cmd as EraseCommand:
					dispatchEvent(new VoEvent(VoEvent.ERASE_ERROR));
					break;
			}
		}
		
		/////////////////////////////////////////////////////////////
		
		protected function _parseUTCDate(str:String):Date 
		{
			if(!str)
				return null;
			
			var matches:Array = str.match(/(\d\d\d\d).(\d\d).(\d\d) (\d\d):(\d\d):(\d\d)/);
			
			var d:Date = new Date();
			
			d.setUTCFullYear(int(matches[1]), int(matches[2]) - 1, int(matches[3]));
			d.setUTCHours(int(matches[4]), int(matches[5]), int(matches[6]), 0);
			
			return d;
		}

		protected function _getUTCDate(date:Date):String
		{
			var year:Number  = date.fullYearUTC;
			var month:String = _get2Digits(date.monthUTC + 1);
			var day:String   = _get2Digits(date.dateUTC);
			
			var hour:String = _get2Digits(date.hoursUTC);
			var mins:String = _get2Digits(date.minutesUTC);
			var secs:String = _get2Digits(date.secondsUTC);
			
			return year + '.' + month + '.' + day + ' ' + hour + ':' + mins + ':' + secs; 
		}
		
		protected function _get2Digits(num:Number):String
		{
			return num < 10 ? ("0" + num) : String(num);
		}

		
		/*
		protected function _getUTCDate(date:Date):String
		{
			return date.fullYearUTC + '.' + date.monthUTC + '.' + date.dayUTC + ' ' + date.hoursUTC + ':' + date.minutesUTC + ':' + date.secondsUTC; 
		}
		*/
	}
}