package org.concert_urbain.utils
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;

	
	public class ScrollBar extends Sprite
	{	
		public var target:Sprite;
		public var pageHeight:Number = 0;
	
		public function ScrollBar()
		{
			draw();
			
			buttonMode = true;
			addEventListener(MouseEvent.MOUSE_DOWN, startDragScrollBar, false, 1, true); 
		}
		
		public function draw():void
		{
			var g:Graphics = graphics;
			g.beginFill(0);
			g.drawRect(0,0,5,5);
		}
		
		public function startDragScrollBar(e:MouseEvent):void
		{
			if (stage)
			{
				removeEventListener(MouseEvent.MOUSE_DOWN, startDragScrollBar); 
				addEventListener(Event.ENTER_FRAME, drag, false, 1, true);
				stage.addEventListener(MouseEvent.MOUSE_UP, stopDragScrollBar, false, 1, true); 
			}
		}
		
		public function stopDragScrollBar(e:MouseEvent):void
		{
			if (stage)
			{
				removeEventListener(Event.ENTER_FRAME, drag);
				stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragScrollBar); 
				addEventListener(MouseEvent.MOUSE_DOWN, startDragScrollBar, false, 1, true); 
			}
		}
		
		
		public function drag(e:Event):void
		{
			y = mouseY;
			//y = Math.min(mouseY, pageHeight);
			//y = Math.max(y, 0);
		}
		
	}
}