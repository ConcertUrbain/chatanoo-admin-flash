﻿package org.concert_urbain.utils{	import com.gskinner.utils.Rndm;	public class ArrayUtils {				public function ArrayUtils()		{		}		public static function shuffle(p_array:Array):Array		{			var n:int = p_array.length;			var i:int = n;			var temp:*;			var p:int;						while (i--) {				p = Math.floor(Math.random()*n);				temp = p_array[i];				p_array[i] = p_array[p];				p_array[p] = temp;			}			return p_array;		}		public static function shuffleWithSeed(p_array:Array, seed:Number = 1):Array		{			Rndm.seed = seed; 			var n:int = p_array.length;			var i:int = n;			var temp:*;			var p:int;						while (i--) {				p = Rndm.integer(n);				temp = p_array[i];				p_array[i] = p_array[p];				p_array[p] = temp;			}			return p_array;		}	}}