package org.concert_urbain.cfacom
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class PersoTitle extends Sprite
	{
		static protected var WIDTH:Number = 250;
		static protected var HEIGHT:Number = 30;
		
		public function PersoTitle(txt:String = ""){
			
			this.graphics.beginFill(0xfcb71b);
			this.graphics.drawRoundRect(0,0,WIDTH,HEIGHT,8,8);
			this.graphics.endFill();
			
			//Zone de texte pour afficher le titre
			var tfTitle:TextField = new TextField();
			tfTitle.name = "title";
			var tformat:TextFormat = new TextFormat();
			
			tformat.color = 0x333333;
			tformat.size = 12;
			tformat.align = "center";
			tformat.font = "Arial";
			
			tfTitle.width = WIDTH;
			tfTitle.height = HEIGHT;
			
			tfTitle.x = 0;
			tfTitle.y = 5;
			
			tfTitle.defaultTextFormat = tformat;
			//tfTitle.text = txt;
			
			addChild(tfTitle);
			
			setPosition();
			showHideTitle();
			setTitle(txt);
		}

		public function showHideTitle(flag:Boolean = true):void{	this.visible = flag;	}
		
		public function setPosition(pos:String="middle"):void {
			switch(pos){
				case "left" :
					this.x = -WIDTH - 45;
					this.y = -HEIGHT;
					break;
				case "middle" : 
					// Par défaut (au-dessus, centré)
					this.x = -WIDTH * 0.5 + 20;
					this.y = -HEIGHT - 30;
					break;
				case "right" : 	
					this.x = WIDTH/4;
					this.y = -HEIGHT;
					break;
			}
		}
		
		public function setTitle(txt:String =""):void{
			var tf:TextField = this.getChildByName("title") as TextField;
			tf.text = txt;
		}

	}
}