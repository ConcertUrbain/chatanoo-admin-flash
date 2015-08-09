package org.concert_urbain.cfacom
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.concert_urbain.utils.DisplayUtils;
	
	/*
		Class permettant de dessiner, dans l'onglet mosaic, un background devant les silhouettes et derrière les bonhommes rouges
	*/
	
	public class ForceFuite extends Sprite
	{
		// Typo
		[Embed(systemFont="Arial", fontName="Arial", mimeType="application/x-font", fontWeight="bold")]
		private var arialBold:Class;
		
		protected var forceText:String;
		protected var fuiteText:String;
		
		public function ForceFuite(force:String = "force", fuite:String = "fuite"){
			super();
			
			forceText = force;
			fuiteText = fuite;
			
			addEventListener(Event.ENTER_FRAME, onAddToStage, false, 0, true);
		}
		
		private function onAddToStage(e:Event):void{
			if (parent.width > 0){
				removeEventListener(Event.ENTER_FRAME, onAddToStage);
				update();
			}
		}
		
		private function bgZoneText(txt:String, colorIn:uint):TextField
		{
			var thisHeight:Number = 70;
			var thisWidth:Number = 600;
			
			// TextFormat
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "Arial";
			textFormat.align = "left";
			textFormat.bold = true;
			textFormat.size = thisHeight - 2;
			textFormat.color = colorIn; // Violet du fond
			
			var tf:TextField = new TextField();
			// tf.border = true;
			tf.embedFonts = true;
			tf.autoSize = "left";
			tf.selectable = false;
			tf.width = thisWidth;
			tf.height = thisHeight;
			tf.defaultTextFormat = textFormat;
			tf.text = txt;
			
			return tf;
		}
		
		
		//
		// Sert à créer les champs "récent", ">>>>", "moins récent" 
		//
		
		private function createLabel(pos:Point, txt:String):TextField
		{
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
			tf.autoSize = "left";
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
			
			createLabel(new Point(pos.x + 25, ssize.y - 5), "récent");
			createLabel(new Point(ssize.x / 2, ssize.y - 5), "> > > > >");
			createLabel(new Point(ssize.x - 45, ssize.y - 5), "moins récent");
		}
		
		public function update():void{
			
			if (stage)
			{
				this.alpha = 1;
				
				DisplayUtils.removeAllChildren(this);
				
				var topMargin:Number = 88;
				var bottomMargin:Number = 66;
				
				var left:Number = 217 + 40;
				var top:Number = topMargin + 5;
				var leftMax:Number = stage.stageWidth - 217 - x;
				var topMax:Number = stage.stageHeight - topMargin - bottomMargin;
				
				var bgWidth:Number = 217
				
				var g:Graphics = graphics;
				g.clear();
				g.beginFill(0x43188b);
				g.drawRect(0,0, bgWidth, topMax);
				
				//Timeline (en bas)
				createTimeLine(new Point(left,top), new Point(leftMax,topMax));
				
				//Text du fond
				var demiHauteur:Number = 0.5 * (topMax - top);
				
				var forceTextField:TextField = bgZoneText(forceText, 0x53269d);
				forceTextField.rotation = -90;
				forceTextField.y = forceTextField.height;
					
				var forceSprite:Sprite = new Sprite();
				forceSprite.addChild(forceTextField);
				forceSprite.scaleX = forceSprite.scaleY = demiHauteur / forceSprite.height;
				forceSprite.x = (bgWidth - forceSprite.width)/2
				
				var fuiteTextField:TextField = bgZoneText(fuiteText, 0x53269d);
				fuiteTextField.rotation = 90;
				fuiteTextField.x = forceTextField.width;
				
				var fuiteSprite:Sprite = new Sprite();
				fuiteSprite.addChild(fuiteTextField);
				fuiteSprite.scaleX = fuiteSprite.scaleY = demiHauteur / fuiteSprite.height;
				fuiteSprite.y = topMax - fuiteSprite.height;
				fuiteSprite.x = (bgWidth - fuiteSprite.width)/2
					
				addChild(forceSprite);
				addChild(fuiteSprite);

			}
		}
	}
}