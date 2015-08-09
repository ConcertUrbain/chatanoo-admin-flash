package org.concert_urbain.touratour.api.vos.collections
{
	import flash.events.EventDispatcher;
	
	import org.concert_urbain.touratour.api.commands.AddVoCommand;
	import org.concert_urbain.touratour.api.commands.EraseCommand;
	import org.concert_urbain.touratour.api.commands.LoadVosCommand;
	import org.concert_urbain.touratour.api.commands.RemoveVoCommand;
	import org.concert_urbain.touratour.api.commands.SaveCommand;
	import org.concert_urbain.touratour.api.core.commands.CommandEvent;
	import org.concert_urbain.touratour.api.core.commands.ICommand;
	import org.concert_urbain.touratour.api.core.commands.MacroCommand;
	import org.concert_urbain.touratour.api.vos.IVo;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;

	public class VoCollection extends EventDispatcher
	{
		protected var _voParent:IVo;
		protected var _voType:String;
		protected var _source:Array;
		
		protected var _removedItems:Array;
		protected var _addedItems:Array;
		
		protected var _isSaved:Boolean;
		protected var _isSynchronized:Boolean;
		
		public function VoCollection(voParent:IVo, voType:String, source:Array = null)
		{
			_isSaved = _isSynchronized = Boolean(source);
			
			_voParent = voParent;
			_voType = voType;
			_source = source || [];
			_removedItems = [];
			_addedItems = [];
		}
		
		public function addItem(vo:IVo):void
		{
			_source.push(vo);
			_addedItems.push(vo);
			
			_isSaved = _isSynchronized = false;
		}
		
		public function getItemAt(index:int):IVo
		{
			return _source[index] as IVo;
		}
		
		public function removeAll():void
		{
			_removedItems = _source;
			_source = [];
			
			_isSaved = _isSynchronized = false;
		}
		
		public function removeItemAt(index:int):void
		{
			_removedItems.push(_source[index]);
			_source.splice(index, 1);
			
			_isSaved = _isSynchronized = false;
		}
		
		///////////////////////////////////////////
		
		public function save(withSynchronize:Boolean = false):void
		{
			var vo:IVo;
			var cmd:MacroCommand = new MacroCommand(true, true);
			for each(vo in _removedItems)
				cmd.addCommand(new RemoveVoCommand(vo, _voParent));
			for each(vo in _addedItems)
				cmd.addCommand(new AddVoCommand(vo, _voParent));
			if(withSynchronize)
				cmd.addCommand(new LoadVosCommand(_voParent, _voType));
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		public function synchronize():void
		{
			var cmd:LoadVosCommand = new LoadVosCommand(_voParent, _voType);
			cmd.addEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.addEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			cmd.execute();
		}
		
		protected function _cmdCompleteHandler(event:CommandEvent):void
		{
			var cmd:ICommand = event.target as ICommand;
			cmd.removeEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.removeEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			
			switch(true)
			{
				case cmd is LoadVosCommand:
					
					_isSaved = true;
					_isSynchronized = true;
					
					_source = (cmd.result as VoCollection).toArray();
					_removedItems = [];
					_addedItems = [];
					
					dispatchEvent(new VoEvent(VoEvent.SYNCHRONIZE_SUCCESS));
					break;
				case cmd is MacroCommand:
					_isSaved = true;
					dispatchEvent(new VoEvent(VoEvent.SAVE_SUCCESS));
					break;
			}
		}
		
		protected function _cmdErrorHandler(event:CommandEvent):void
		{
			var cmd:ICommand = event.target as ICommand;
			cmd.removeEventListener(CommandEvent.COMPLETE, _cmdCompleteHandler);
			cmd.removeEventListener(CommandEvent.ERROR, _cmdErrorHandler);
			
			switch(true)
			{
				case cmd as LoadVosCommand:
					dispatchEvent(new VoEvent(VoEvent.SYNCHRONIZE_ERROR));
					break;
				case cmd is MacroCommand:
					dispatchEvent(new VoEvent(VoEvent.SAVE_ERROR));
					break;
			}
		}
		
		public function get isSaved():Boolean
		{
			return _isSaved;
		}
		
		public function get isSynchronized():Boolean
		{
			return _isSynchronized;
		}
		
		////////////////////////////////////////////
		
		public function get removedItems():Array
		{
			return _removedItems;
		}
		
		public function get addedItems():Array
		{
			return _addedItems;
		}
		
		////////////////////////////////////////////
		
		public function getType():String
		{
			return _voType;
		}
		
		public function toArray():Array
		{
			return _source;
		}

	}
}