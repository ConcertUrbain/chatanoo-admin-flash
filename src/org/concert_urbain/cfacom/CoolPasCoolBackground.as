package org.concert_urbain.cfacom
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.concert_urbain.utils.DisplayUtils;
	
	/*
		Class permettant de dessiner, dans l'onglet mosaic, un background devant les silouhettes et derrière les bonhommes rouges
	*/
	public class CoolPasCoolBackground extends Sprite
	{
		// Typo
		[Embed(systemFont="Arial", fontName="Arial", mimeType="application/x-font", fontWeight="bold")]
		private var arialBold:Class;
		
		protected var coolText:String;
		protected var pascoolText:String;
		protected var casediscuteCoolText:String;
		protected var drawPerso:Boolean;
		
		public function CoolPasCoolBackground(cool:String = "COOL", pascool:String = "PAS COOL", casediscute:String = "CA SE DISCUTE", withPerso:Boolean = true)
		{
			super();
			
			coolText = cool;
			pascoolText = pascool;
			casediscuteCoolText = casediscute;
			drawPerso = withPerso;
			
			addEventListener(Event.ENTER_FRAME, onAddToStage, false, 0, true);
		}
		
		private function onAddToStage(e:Event):void{
			if (parent.width > 0){
				removeEventListener(Event.ENTER_FRAME, onAddToStage);
				update();
			}
		}
		
		private function bgZoneText(color:uint, txt:String, pos:Point, ssize:Point,drawLine:Boolean,colorIn:uint, withPerso:Boolean):void{
			
			var thisHeight:Number = 70;
			var thisWidth:Number = 600;
			
			var topleft:Point = new Point(pos.x,pos.y);
			var bottomright:Point = new Point(ssize.x, pos.y + ssize.y/3);
			
			if(drawLine){
				var bg:Sprite = new Sprite();
				bg.graphics.lineStyle(1,color);
				bg.graphics.moveTo(pos.x,pos.y + ssize.y);
				bg.graphics.lineTo(pos.x + ssize.x, pos.y + ssize.y);
				
				addChild(bg);
			}
			
			// TextFormat
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "Arial";
			textFormat.align = "left";
			textFormat.bold = true;
			textFormat.size = thisHeight - 2;
			textFormat.color = colorIn; // Violet du fond
			
			var tf:TextField = new TextField();
			tf.selectable = false;
			//tf.alpha = 0.5;
			
			//tf.x = pos.x + (ssize.x / 2) - thisWidth / 2; // Au milieu
			//tf.y = pos.y + (ssize.y / 2) - thisHeight / 2; // Au milieu (vertical)
			tf.x = pos.x + 100;
			tf.y = pos.y + ssize.y - thisHeight;
			tf.width = thisWidth;
			tf.height = thisHeight;
			
			tf.defaultTextFormat = textFormat;
			tf.text = txt;
			
			var glowF:GlowFilter = new GlowFilter(color,1,5,5,2);
			tf.filters = [glowF];
			
			if (withPerso)
			{
				var homme:MovieClip = new PersoHomme();
				homme.x = 40;
				homme.y = tf.y - 5;
				addChild(homme);
				
				PersoSprite.changeColor(homme, color);
			}
			
			addChild(tf);
		}
		
		private function createLabel(pos:Point, txt:String):TextField{
			
			var thisWidth:Number = 120;
			var thisHeight:Number = 20;

			// TextFormat
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "Arial";
			textFormat.align = "center";
			textFormat.bold = false;
			textFormat.italic = true;
			textFormat.size = 12;
			textFormat.color = 0xAAAAAA;

			var tf:TextField = new TextField();
			
			tf.selectable = false;
			tf.width = thisWidth;
			tf.height = thisHeight;
			
			tf.x = pos.x - thisWidth/2; // A gauche de la timeline
			tf.y = pos.y - thisHeight/2; // Au dessus de la timeline
			
			tf.defaultTextFormat = textFormat;
			tf.text = txt;
			
			addChild(tf);
			
			return tf;
		}
		
		private function createTimeLine(pos:Point, ssize:Point):void{
			
			var timeline:Sprite = new Sprite();
			timeline.graphics.lineStyle(3,0xFFFFFF);
			timeline.graphics.moveTo(pos.x + 50, ssize.y - 5);
			timeline.graphics.lineTo(pos.x + ssize.x - 50, ssize.y - 5);
			
			//addChild(timeline);
			createLabel(new Point(pos.x + 25, ssize.y - 5), "récent");
			createLabel(new Point(ssize.x / 2, ssize.y - 5), "> > > > >");
			createLabel(new Point(ssize.x - 45, ssize.y - 5), "moins récent");
			
			/*
			var pt:Point = new Point(pos.x + 25, ssize.y - 5);
			var left:Number = pt.x + createLabel(pt, "recent").width;
			//createLabel(new Point(ssize.x/2, ssize.y - 5), "MOINS RECENT");
			pt = new Point(ssize.x - 40, ssize.y - 5);
			var right:Number = pt.x + createLabel(pt, "moins recent").width;
			*/
		}
		
		public function update():void{
			
			if (parent)
			{
				DisplayUtils.removeAllChildren(this);
				
				var topMargin:Number = 2;
				var left:Number = 0;
				var top:Number = topMargin + 5;
				var leftMax:Number = parent.width;
				var topMax:Number = parent.height - topMargin * 2;
				
				var topTiers1:Number = topMax / 3;
				var topTiers2:Number = 2 * topMax / 3;
				
				var i:uint = 0;
				var j:uint = 0;
				
				//Text du fond
				var zoneSize:Point = new Point(leftMax,topMax/4);
				
				//color blow / color in text
				// 482999
				// 45178f
				// 420787
				
				bgZoneText(0x009900, coolText, new Point(left,top),zoneSize, true, 0x482999, drawPerso);
				bgZoneText(0x888800, casediscuteCoolText, new Point(left,(topMax/3)),zoneSize,true, 0x45178f, drawPerso);
				bgZoneText(0xcc1212, pascoolText, new Point(left,(topMax/3 * 2)),new Point(zoneSize.x,zoneSize.y-10),true, 0x420787, drawPerso);
				
				//Timeline (en bas)
				createTimeLine(new Point(left,top), new Point(leftMax,topMax));
			}
		}
	}
}