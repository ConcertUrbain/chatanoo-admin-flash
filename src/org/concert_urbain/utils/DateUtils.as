package org.concert_urbain.utils
{

	public class DateUtils
	{	
	
		// Date au format ISO 8600
		// YYYY-MM-DDThh:mm:ss
		
		// Ex ISO : 2003-04-01T13:01:02
		// Ex Mathieu : 1997-07-16T19:20:30 01:00 
		
		// cf http://www.iso.org/iso/fr/support/faqs/faqs_widely_used_standards/widely_used_standards_other/date_and_time_format.htm				
		
		public static function iso8601ToDate(iso:String):Date
		{
			var dateSplitArray:Array = dateSplitArray = iso.split("T");
			
			var dateSplitResult:String = dateSplitArray[0];
			var timeSplitResult:String = dateSplitArray[1];
			
			// Au cas où le décalage horaire UT serait présent à la fin de la chaine
			var timeSplitArray:Array = timeSplitResult.split(" ");
			timeSplitResult = timeSplitArray[0];
			var utSplitResult:String = timeSplitArray[1];
			
			var date:Date = new Date();
			
			// Date
			dateSplitArray = dateSplitResult.split("-");
			date.setFullYear(dateSplitArray[0], Number(dateSplitArray[1]) - 1, dateSplitArray[2]);
			
			// Heure
			dateSplitArray = timeSplitResult.split(":");
			date.setHours(dateSplitArray[0], dateSplitArray[1], dateSplitArray[2]);
			
			return date;
		}
		
		public static function dateToIso8601(date:Date):String
		{
			var iso:String = "";
			
			var year:Number = date.fullYear;
			var month:Number = date.month + 1;
			var monthStr:String = (month < 10 ? "0" : "") + String(month);
			var day:Number = date.date;
			var dayStr:String = (day < 10 ? "0" : "") + String(day);
			
			iso += String(year) + "-" + monthStr + "-" + dayStr;
			
			var hour:Number = date.hours;
			var minutes:Number = date.minutes;
			var secondes:Number = date.seconds;
			
			var hourStr:String = (hour < 10 ? "0" : "") + String(hour);
			var minutesStr:String = (minutes < 10 ? "0" : "") + String(minutes);
			var secondesStr:String = (secondes < 10 ? "0" : "") + String(secondes);
			
			iso += "T" + hourStr + ":" + minutesStr + ":" + secondesStr;
			
			return iso;
		}
	}
}