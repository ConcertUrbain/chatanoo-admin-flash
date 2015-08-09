package org.concert_urbain.utils
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/*
		Class faites par André BERLEMONT pour les modifs/ajouts sur dring13
	*/
	
	public class PersoGraphicTools
	{
		// Permet de créér le halo jaune des persos sur la carte
		static public function createSun():Sprite{
			
			var e:Number = 20; // equart entre le bonhomme et le début du rayon de soleil
			var l:Number = 18; // longeur du rayon
			var ld:Number = l-5; // Rajout de longeur pour les diagonales
			
			var mySun:Sprite = new Sprite();
			
			mySun.graphics.lineStyle(2,0xDDDD00);
			
			mySun.graphics.moveTo(0,e);
			mySun.graphics.lineTo(0,e+ld);
			
			mySun.graphics.moveTo(e,e);
			mySun.graphics.lineTo(e+ld,e+ld);
			
			mySun.graphics.moveTo(e,0);
			mySun.graphics.lineTo(e+l,0);
			
			mySun.graphics.moveTo(e,-e);
			mySun.graphics.lineTo(e+ld,-e-ld);
			
			mySun.graphics.moveTo(0,-e);
			mySun.graphics.lineTo(0,-e-l);

			mySun.graphics.moveTo(-e,-e);
			mySun.graphics.lineTo(-e-ld,-e-ld);

			mySun.graphics.moveTo(-e,0);
			mySun.graphics.lineTo(-e-l,0);

			mySun.graphics.moveTo(-e,e);
			mySun.graphics.lineTo(-e-ld,e+ld);
						
			return mySun;
		}

	}
}