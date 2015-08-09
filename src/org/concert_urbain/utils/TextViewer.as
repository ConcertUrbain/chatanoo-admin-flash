package org.concert_urbain.utils
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class TextViewer extends Sprite implements IMediaViewer
	{	
		public var textField:TextField;
		private var textfieldConstraintRect:Rectangle;
		private var paddingHorizontal:Number = 5;
		private var paddingVertical:Number = 5;
		
		public function TextViewer(content:String, isHtml:Boolean = false, constraint:Rectangle = null)
		{
			textfieldConstraintRect = constraint;
			
			textField = new TextField();
			textField.x = paddingHorizontal;
			textField.y = paddingVertical;
			addChild(textField);

			if (textfieldConstraintRect is Rectangle)
			{
				textField.width = textfieldConstraintRect.width - 2 * paddingHorizontal;
				textField.height = textfieldConstraintRect.height - 2 * paddingVertical;
			}
			
			textField.multiline = true;
			textField.wordWrap = true;
			
			// Content
			if (content == null) content = "";
			
			// Autosize :			
			textField.autoSize = "left";
			
			// Format Txt ou Html :
			isHtml ? textField.htmlText = content : textField.text = content;
			
			// Evénements Viewers
			dispatchEvent(new Event(ViewerEvents.MEDIA_COMPLETE));
			dispatchEvent(new Event(ViewerEvents.MEDIA_END));
			
			var evt:ProgressEvent = new ProgressEvent(ViewerEvents.MEDIA_PROGRESS, false, false, 1, 1);
			dispatchEvent(evt);
		}
		
		
		//
		// Interface IMediaViewer
		//
		public function close():void
		{
		}

		
		
		
		
		public function fillBackground():void
		{
			if (textfieldConstraintRect is Rectangle)
			{
				var g:Graphics = graphics;
				g.clear();
				g.beginFill(textField.backgroundColor);
				g.drawRect(0, 0, textfieldConstraintRect.width, textField.height + 2 * paddingVertical);
				g.endFill();
			}
			
		}
		
		

		//
		// TextFormat
		//
		
		public function get textFormat():TextFormat
		{
			return textField.getTextFormat();
		}
		
		public function set textFormat(tf:TextFormat):void
		{
			textField.setTextFormat(tf);
		}
		
		
	}
}
