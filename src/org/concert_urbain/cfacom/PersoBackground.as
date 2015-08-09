package org.concert_urbain.cfacom
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.concert_urbain.utils.ColorUtils;
	import org.concert_urbain.utils.DisplayUtils;
	
	
	public class PersoBackground extends Sprite
	{
		
		public function PersoBackground()
		{
			super();
			
			addEventListener(Event.ENTER_FRAME, onAddToStage, false, 0, true);
		}
		
		private function onAddToStage(e:Event):void
		{
			if (parent.width > 0)
			{
				removeEventListener(Event.ENTER_FRAME, onAddToStage);
				update();
			}
		}
		
		public function update():void
		{
			if (parent)
			{
				DisplayUtils.removeAllChildren(this);
				
				var perso:PersoHomme;
				perso = new PersoHomme()
				perso.scaleX = perso.scaleY = 0.6;
				
				var wp:Number = perso.width;
				var hp:Number = perso.height;
				perso = null;
				
				
				var leftMargin:Number = 15;
				var topMargin:Number = 25;
				
				var left:Number = 0;
				var top:Number = topMargin;
				var leftMax:Number = parent.width - leftMargin;
				var topMax:Number = parent.height - topMargin;
				
				var i:uint;
				var j:uint;
				
				var ecartH:Number = 3;
				var ecartV:Number = 5;
				
				var n:uint = Math.floor(leftMax/(wp+ecartH));
				var m:uint = Math.floor(topMax/(hp+ecartV));
				
				var total:Number = m * n;
				var angle:Number;
				var pi:Number = Math.PI;
				
				
				for(i=0; i<n; i++)
				{
					for(j=0; j<m; j++)
					{
						angle = pi * (i/3 + j/2);
						
						perso = new PersoHomme()
						perso.scaleX = perso.scaleY = 0.6;
						perso.x = leftMargin + i * (perso.width + ecartH) + 40 * Math.cos(angle);
						perso.y = topMargin + j * (perso.height + ecartV) + 40 * Math.sin(angle);
						
						if (j % 2 == 0)
						{
							ColorUtils.setColorTransform(perso, 0xCF73B4);
						}
						else if (i % 2 == 0)
						{
							ColorUtils.setColorTransform(perso, 0x8F9AD1);
						}
						else
						{
							ColorUtils.setColorTransform(perso, 0x660000);
						}
						
						addChild(perso);
					}
				}
			}
		}
	}
}