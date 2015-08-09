package org.concert_urbain.utils
{
	
	public class VideoUtils
	{	
		public static function convertTimeToHMS(time:Number):String
		{
			// time en secondes :
			var h:Number = Math.floor(time / 3600);
			var reste:Number = time - 3600 * h;

			var m:Number = Math.floor(reste / 60);
			reste = time - 60 * m;			
			
			var s:Number = Math.floor(reste);
			reste = time - s;
			
			var i:Number = Math.floor((reste%60)*100);
			var f:Function = StringUtils.formatChrono;

			return f(h)+":"+f(m)+":"+f(s)+":"+f(i);
		}
	}
}