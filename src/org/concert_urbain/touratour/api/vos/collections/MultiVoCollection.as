package org.concert_urbain.touratour.api.vos.collections
{
	import com.adobe.utils.ArrayUtil;
	
	import org.concert_urbain.touratour.api.commands.AddVoCommand;
	import org.concert_urbain.touratour.api.commands.LoadVosCommand;
	import org.concert_urbain.touratour.api.commands.RemoveVoCommand;
	import org.concert_urbain.touratour.api.core.commands.CommandEvent;
	import org.concert_urbain.touratour.api.core.commands.MacroCommand;
	import org.concert_urbain.touratour.api.vos.IVo;

	public class MultiVoCollection extends VoCollection
	{
		private var _types:Array;
		
		public function MultiVoCollection(voParent:IVo, voType:String, source:Object = null)
		{
			super(voParent, voType, null);
			
			_source = [];
			_types = [];
			for(var prop:String in source)
			{
				_source[prop] = new VoCollection(voParent, voType, source[prop]);
				_types.push(prop);
			}
		}
		
		public function getVoCollectionByType(type:String):VoCollection
		{
			return _source[type]
		}
		
		public function addVoCollection(voCollection:VoCollection, type:String):void
		{
			_source[type] = voCollection;
			_types.push(type);
		}
		
		////////////////////////////////////////////////////////////
		
		override public function save(withSynchronize:Boolean = false):void
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
		
		/////////////////////////////////////////////////////////////
		
		override public function get removedItems():Array
		{
			var a:Array = [];
			for each(var vc:VoCollection in _source)
			{
				for each(var vo:IVo in vc.removedItems)
					a.push(vo);
			}
			return a;
		}
		
		override public function get addedItems():Array
		{
			var a:Array = [];
			for each(var vc:VoCollection in _source)
			{
				for each(var vo:IVo in vc.addedItems)
				a.push(vo);
			}
			return a;
		}
		
		///////////////////////////////////////////////////////////////
		
		override public function get isSaved():Boolean
		{
			var value:Boolean = true;
			for each(var vc:VoCollection in _source)
			{
				if(!vc.isSaved || !value)
					value = false;
			}
			return value;
		}
		
		override public function get isSynchronized():Boolean
		{
			var value:Boolean = true;
			for each(var vc:VoCollection in _source)
			{
				if(!vc.isSynchronized || !value)
					value = false;
			}
			return value;
		}
		
		//////////////////////////////////////////////////////////////
		
		public function getTypes():Array
		{
			return _types;
		}
	}
}