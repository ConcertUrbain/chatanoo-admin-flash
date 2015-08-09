package org.concert_urbain.cfacom
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import gs.*;
	import gs.easing.*;
	
	import org.concert_urbain.utils.DisplayUtils;
	
	/*
		Class permettant d'afficher en background des grandes silouhettes
	*/
	
	public class Silhouettes extends Sprite
	{
		// Silhouettes :
		private var currentNoSilhouette:Number;
		private var silhouettes:Array;
		private var silhouettesTimer:Timer;
		
		public var maxWidth:Number;
		public var maxHeight:Number;
		
		public function Silhouettes()
		{
			super();
			
			silhouettes = new Array();
		}
		
		
		public function clear():void
		{
			var i:uint;
			var n:uint = silhouettes.length;
			var s:MovieClip;
			
			for (i=0; i<n; i++) {
				s = silhouettes[i];
				TweenLite.killTweensOf (s, false);
			}
			
			if (silhouettesTimer) silhouettesTimer.reset();
			DisplayUtils.removeAllChildren(this);
			
		}

		public function setSilhouettes(groupeNo:uint):void
		{
			clear();
			
			switch(groupeNo)
			{
				case 1:
					// Egalite Homme/femme
					silhouettes =  [new Silhouette1(), new Silhouette5(), new Silhouette6(), new Silhouette7()];
					break;
				case 2:
					// Orientation sexuelle
					silhouettes =  [new Silhouette11(), new Silhouette12(), new Silhouette13()];
					break;
				case 3:
					// Origine 
					silhouettes =  [new Silhouette8(), new Silhouette9(), new Silhouette10()];
					break;
				case 4:
					// Handicap
					silhouettes =  [new Silhouette2(), new Silhouette3(), new Silhouette4()];
					break;
				case 5:
					silhouettes =  [new Silhouette14(), new Silhouette15(), new Silhouette16()];
					break;
				case 6:
					silhouettes =  [new Silhouette14(), new Silhouette15(), new Silhouette16()];
					break;
			}
			
			addSilhouettes();
		}
		
		private function addSilhouettes():void
		{
			var i:uint;
			var n:uint = silhouettes.length;
			var s:MovieClip;
			
			if (n>0)
			{
				for (i=0; i<n; i++) {
					s = silhouettes[i];
					s.visible = false;
					addChild(s);
				}
				
				loadSilhouette(0);
				
				silhouettesTimer = new Timer (20000)
				silhouettesTimer.addEventListener(TimerEvent.TIMER, changeSilhouette);
				silhouettesTimer.start();
			}
		}
		
		private function loadSilhouette(no:Number):void
		{
			if (! isNaN(currentNoSilhouette)) var prevSilhouette:MovieClip = silhouettes[currentNoSilhouette];
			var nextSilhouette:MovieClip = silhouettes[no];
			
			currentNoSilhouette = no;
			
			nextSilhouette.visible = true;
			nextSilhouette.alpha = 0;
			
			// Mise à l'échelle
			resizeSilhouette(nextSilhouette);
			
			if (prevSilhouette) 
			{
				// Disparition de la précédente silhouette
				TweenLite.killTweensOf (prevSilhouette, false);
				TweenLite.to(prevSilhouette, 0.5, {alpha:0, ease:Cubic.easeOut});
			}
			
			// Apparition de la nouvelle silhouette
			TweenLite.to(nextSilhouette, 1, {alpha:1, delay:0.5, ease:Cubic.easeOut});
		}
		
		private function resizeSilhouette(mc:MovieClip):void
		{
			if (maxWidth && maxHeight)
			{
				var percentSize:Number = 0.8;
				
				var margin:Number = 20;
				var ratio:Number = mc.width / mc.height;
				mc.height = percentSize * maxHeight;
				mc.width = mc.height * ratio;
				mc.x = (maxWidth - mc.width)/2;
				mc.y = (maxHeight - mc.height); ///2;
			}
		}
		
		public function update():void
		{
			if (isNaN(currentNoSilhouette)) 
			{
				// Initialisation des silhouettes (lors du premier resize)
				addSilhouettes();
			}
			else
			{
				resizeSilhouette(silhouettes[currentNoSilhouette]);
			}
		}
		
		private function changeSilhouette(e:TimerEvent):void
		{
			loadSilhouette(currentNoSilhouette < silhouettes.length - 1 ? currentNoSilhouette+1 : 0);
		}
		
	}
}