package org.concert_urbain.cfacom{
	import flash.geom.Point;
	
	public class Vars{
		static public const DRING13:int = 0;
		static public const DRING93:int = 1;
		static public const version:int = DRING93;
		
		
		// tour-a-tour.org : ABQIAAAAQFQz0CYFQd56ymatPcdV8BQ5zKWjSaHlKBuEMQGQcKpD98BinxTAa4-Bv6EhQPcwTHTmZmAbjsC02g 
		//static public const gmapsKey:String = "ABQIAAAAQFQz0CYFQd56ymatPcdV8BQ1lbLv_2d4894U9v-M-m-oYrNRqxRCj6R1XZyB-LQsDvVxCXydpkNUoQ"; //d13
		static public const gmapsKeyD13:String = "ABQIAAAAQFQz0CYFQd56ymatPcdV8BQ1lbLv_2d4894U9v-M-m-oYrNRqxRCj6R1XZyB-LQsDvVxCXydpkNUoQ";
		static public const gmapsKey:String = "ABQIAAAAe4plpISqE7LnTsDZyfe_VxRtinda_booCxECivhpcCqzcUvh_RQzD19L6LmOx1-hETkJzuF_y30Few"; //d93
		static public const zoomLevel:Number = 13;
		
		//http://itouchmap.com/latlong.html
		static public const coord:Point = new Point(48.93016874391427, 2.360687255859375);
		
		static public const websiteUrl:String = "http://www.dring93.org";
		
		//tools *FIX*
		static public var uploadId:int = 0;
	}
}