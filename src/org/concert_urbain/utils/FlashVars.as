package org.concert_urbain.utils
{
	import flash.display.Sprite;
	import flash.display.LoaderInfo;
	import flash.utils.Dictionary;
	
	public class FlashVars
	{
		// Les FlashVars seront stockées dans un tableau associatif
		private var _vars:Array;
		
		public function FlashVars(aContext:Sprite)
		{
			_vars = new Array();
			
			try {
				var keyStr:String;
				var paramObj:Object = LoaderInfo(aContext.root.loaderInfo).parameters;

				for (keyStr in paramObj)
				{
					_vars[keyStr] = String(paramObj[keyStr]);
				}
			}
			catch (error:Error)
			{
			}
		}
		
		//  Retourne la valeur du paramètre passé dans les flashVars :
		public function getVariable(aVarName:String):String
		{
			if (_vars[aVarName] != undefined)
			{
				return _vars[aVarName];
			}
			else 
			{
				return "";
			}				
		}
		
		// Retourne une copie du tableau sous forme de Dictionary
		public function getDictionary():Dictionary
		{
			var d:Dictionary = new Dictionary();
			var keyStr:String;
			
			for (keyStr in _vars)
			{
				d[keyStr] = _vars[keyStr];
			}
			
			return d;
		}
	}
}