package org.concert_urbain.cfacom
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.controls.Alert;
	
	import org.concert_urbain.utils.DisplayUtils;
	
	public class KeywordBackground extends Sprite
	{
		// Typo
		[Embed(systemFont="Arial", fontName="Arial", mimeType="application/x-font", fontWeight="bold")]
		private var arialBold:Class;
		
		// Mots-clés :
		private var keywordsGroup1:Array;
		private var keywordsGroup2:Array;
		private var url:String;
		
		
		public function KeywordBackground()
		{
			super();
		}
		
		// -------------------------------------------------------
		//
		// Chargement du XML des keywords
		//
		// -------------------------------------------------------
		
		public function loadXMLKeywords(xmlUrl:String = "http://tour-a-tour.org/xml/keywords.xml"):void
		{
			url = xmlUrl;
			
			// Chargement du XML
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadKeywordsComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadKeywordsError);
			
			var request:URLRequest = new URLRequest(url);
			loader.load(request) ;
		}
		
		private function onLoadKeywordsError (e:IOErrorEvent):void
		{
			e.target.removeEventListener(Event.COMPLETE, onLoadKeywordsComplete);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, onLoadKeywordsError);
		}
		
		private function onLoadKeywordsComplete(e:Event):void
		{
			e.target.removeEventListener(Event.COMPLETE, onLoadKeywordsComplete);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, onLoadKeywordsError);
			
			// Parsing des données du XML du Message
			var keywordsLoader:URLLoader = e.target as URLLoader;
			var keywordsXML:XML = XML(keywordsLoader.data)
			
			// Liste des keywords
			var keywordXML:XML;
			
			// Groupe 1
			keywordsGroup1 = new Array();
			for each(keywordXML in keywordsXML.group1.keyword)
			{
				keywordsGroup1.push(String(keywordXML));
			}
			
			// Groupe 2
			keywordsGroup2 = new Array();
			for each(keywordXML in keywordsXML.group2.keyword)
			{
				keywordsGroup2.push(String(keywordXML));
			}
			
			update();
		}
		
		
		public function update():void
		{
			if (keywordsGroup1 is Array)
			{
				// TextFormat
				var textFormat:TextFormat = new TextFormat();
				textFormat.font = "Arial";
				textFormat.color = 0x333333;
				textFormat.bold = true;
				textFormat.size = 12;
				
				var keywordTextField:TextField;
				
				DisplayUtils.removeAllChildren(this);
				
				
				var left:Number = 0;
				var top:Number = 0;
				var leftMax:Number = parent.width;
				var topMax:Number = parent.height;
				var topMid:Number = topMax / 2;
				var i:uint = 0;
				var j:uint = 0;
				var n:uint = keywordsGroup1.length - 1;
				
				while (top < topMax)
				{
					while (left < leftMax)
					{
						keywordTextField = new TextField();
						keywordTextField.selectable = false;
						keywordTextField.autoSize = "left";
						keywordTextField.defaultTextFormat = textFormat;
						keywordTextField.embedFonts = true;
						keywordTextField.text = top > topMid ? keywordsGroup2[j%n] : keywordsGroup1[j%n];
						keywordTextField.x = left;
						keywordTextField.y = top;
						addChild(keywordTextField);
						
						left += keywordTextField.width * 2;
						
						j++;
					}
					
					// No de ligne
					i++;
					
					left =  (i % 2) * 50;
					top += keywordTextField.height * 2;
				}
			}
		}
	}
}