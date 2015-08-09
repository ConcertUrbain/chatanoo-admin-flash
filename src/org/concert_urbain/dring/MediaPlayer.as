package org.concert_urbain.dring
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import flash.geom.Rectangle;

	import flash.text.TextFormat;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	import org.concert_urbain.dring.VO.MessageVO;
	import org.concert_urbain.dring.VO.MessageContentVO;
	import org.concert_urbain.dring.VO.MessageCommentVO;
	import org.concert_urbain.utils.ImageViewer;
	import org.concert_urbain.utils.VideoViewer;
	import org.concert_urbain.utils.SoundViewer;
	import org.concert_urbain.utils.TextViewer;
	import org.concert_urbain.utils.IMediaViewer;
	import org.concert_urbain.utils.DisplayUtils;
	import org.concert_urbain.utils.ViewerEvents;
	import org.concert_urbain.utils.IMediaViewer;

	
	public class MediaPlayer extends Sprite
	{	
		public static const MEDIA_END:String = "org.concert_urbain.dring.mediaPlayer.End";
		public static const MEDIA_PROGRESS:String = "org.concert_urbain.dring.mediaPlayer.Progress";
		
		private var playerWidth:Number = 320;
		private var playerHeight:Number = 240;
		private var playerRect:Rectangle;
		private var isOpen:Boolean = false;
	
		public var currentMessageVO:MessageVO;
		public var currentMediaViewer:IMediaViewer;
		public var currentMediaURL:String;
	
		public var textFormat:TextFormat;
		public var baseURL:String = "";
		
		 
		public function MediaPlayer()
		{
			super();
			
			// Rectangle du player (limite les dimensions des médias)
			playerRect = new Rectangle(0, 0, playerWidth, playerHeight);
			
			textFormat = new TextFormat();
			textFormat.font = "Arial";
			textFormat.size = 15;
			textFormat.color = 0xFFFFFF;
		}
		
		public function drawBackground():void
		{
			var g:Graphics = graphics;
			g.beginFill(0xFFAAAA);
			g.drawRect(0, 0, playerWidth, playerHeight);
			g.endFill();
		}
				
		//
		// Médias :
		//
				
		public function displayMessage(messageVO:MessageVO):void
		{
			displayMessageContents(messageVO.getContents());
		}
			
		public function displayMessageContents(contents:Array):void
		{
			if (contents.length > 0)
			{
				var contentVO:MessageContentVO = contents[0];
				var typeContent:String = contentVO.type;
				
				//
				// Mémorisation de l'URL du média courant
				//
				
				if (typeContent == MessageContentVO.MEDIA_TEXTE)
				{
					currentMediaURL = "";
				}
				else
				{
					currentMediaURL = contentVO.mediaUrl
				}
			
				// Suppression des précédents contenus
				var child:DisplayObject;
				while (numChildren > 0)
				{
					child = getChildAt(0);
					if (child is IMediaViewer) IMediaViewer(child).close(); 
					removeChildAt(0);
				}
						
				switch(typeContent)
				{				
					case "image" :
						var image:ImageViewer = new ImageViewer(baseURL + contentVO.mediaUrl, playerRect);
						image.addEventListener(ViewerEvents.MEDIA_END, mediaPlayed, false, 1, true);
						image.addEventListener(ViewerEvents.MEDIA_PROGRESS, mediaProgress, false, 1, true);
						addChild(image);
						
						currentMediaViewer = image as IMediaViewer;
						break;

					case "video" :
						var video:VideoViewer = new VideoViewer(baseURL + contentVO.mediaUrl, playerRect);
						video.addEventListener(ViewerEvents.MEDIA_END, mediaPlayed, false, 1, true);
						video.addEventListener(ViewerEvents.MEDIA_PROGRESS, mediaProgress, false, 1, true);
						addChild(video);
						
						currentMediaViewer = video as IMediaViewer;
						break;
						
					case "son" :
						var sound:SoundViewer = new SoundViewer(baseURL + contentVO.mediaUrl, playerRect);
						sound.addEventListener(ViewerEvents.MEDIA_END, mediaPlayed, false, 1, true);
						sound.addEventListener(ViewerEvents.MEDIA_PROGRESS, mediaProgress, false, 1, true);
						addChild(sound);
						
						currentMediaViewer = sound as IMediaViewer;
						break;
						
					case "texte" :
						var texte:TextViewer = new TextViewer(contentVO.content, false, playerRect);
						texte.textFormat = textFormat;
						texte.addEventListener(ViewerEvents.MEDIA_END, mediaPlayed, false, 1, true);
						texte.addEventListener(ViewerEvents.MEDIA_PROGRESS, mediaProgress, false, 1, true);
						texte.textField.textColor = 0xFFFFFF;
						addChild(texte);
						
						currentMediaViewer = texte as IMediaViewer;
						break;
				}
			}
		}

		private function mediaProgress(e:ProgressEvent):void
		{
			var evt:ProgressEvent = new ProgressEvent(MEDIA_PROGRESS, false, false, e.bytesLoaded, e.bytesTotal);
			dispatchEvent(evt);
		}
		
		
		private function mediaPlayed(e:Event):void
		{
			e.target.removeEventListener(ViewerEvents.MEDIA_END, mediaPlayed);
			e.target.removeEventListener(ViewerEvents.MEDIA_PROGRESS, mediaProgress);
			
			dispatchEvent(new Event(MEDIA_END));
		}
		
		public function close():void
		{
			if (currentMediaViewer is IMediaViewer) currentMediaViewer.close();
		}
	}
}
