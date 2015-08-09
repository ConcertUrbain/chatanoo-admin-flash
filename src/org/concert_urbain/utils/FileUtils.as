package org.concert_urbain.utils
{
	public class FileUtils
	{	

		//
		// Retourne le nom du fichier à partir de son URL complète
		//
		
		public static function getFileName(p_url:String):String
		{
			var tmp_array:Array = p_url.split("/");
			return tmp_array[tmp_array.length-1];
		}

		
		//
		// Retourne l'extension du fichier à partir de son URL complète
		//
		
		public static function getExtension(p_url:String):String
		{
			if (p_url.indexOf(".") != -1)
			{
				var tmp_array:Array = p_url.split(".");
				return tmp_array[tmp_array.length-1];
			}
			return "";
		}
		
		//
		// Retourne le nom du fichier SANS extension à partir de son URL complète
		//
		
		public static function getBaseName(p_url:String):String
		{
			var fileName:String = getFileName(p_url);
			var index:int = p_url.indexOf(".")
			if (index != -1)
			{
				return fileName.substr(0, index);
			}
			return fileName;
		}
	}
}
