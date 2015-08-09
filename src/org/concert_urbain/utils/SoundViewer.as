package org.concert_urbain.utils
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	
	import flash.geom.Rectangle;
	
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent; 

	import flash.utils.ByteArray;

	
	
	public class SoundViewer extends Sprite implements IMediaViewer
	{	
		public var soundUrl:String;
		private var soundVisualConstraintRect:Rectangle;
		
		public var sound:Sound;
		public var soundChannel:SoundChannel;
		public var sndTransform:SoundTransform;
		public var isPlaying:Boolean;

		// Le byteArray est constitué de 2x256 octets (left/right channel)
		public const CHANNEL_LENGTH:int = 256;

		
		public function SoundViewer(url:String, constraint:Rectangle = null)
		{
			soundUrl = url;
			soundVisualConstraintRect = constraint;
			
			sound = new Sound();
			sound.addEventListener(ProgressEvent.PROGRESS, onLoadSoundProgress); 
			sound.addEventListener(Event.COMPLETE, onLoadSoundComplete); 
			sound.addEventListener(IOErrorEvent.IO_ERROR, onLoadSoundError); 

			sound.load(new URLRequest(soundUrl));
		}
		
		private function onLoadSoundComplete(e:Event):void
		{
			soundChannel = sound.play();
			sndTransform = soundChannel.soundTransform;

			// Listener pour la visualisation :
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
            soundChannel.addEventListener(Event.SOUND_COMPLETE, onPlaybackComplete);

			// Evénements Viewers
			dispatchEvent(new Event(ViewerEvents.MEDIA_COMPLETE));
		}
		
		private function onLoadSoundProgress(e:ProgressEvent):void
		{
			var evt:ProgressEvent = new ProgressEvent(ViewerEvents.MEDIA_PROGRESS, false, false, e.bytesLoaded, e.bytesTotal);
			dispatchEvent(evt);
		}
		
		private function onLoadSoundError(e:IOErrorEvent):void
		{
			trace ("[SoundViewer] Loading Error : " + soundUrl)
		}
		
		private function onPlaybackComplete(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			// Evénements Viewers
			dispatchEvent(new Event(ViewerEvents.MEDIA_END));
		}
		
		public function setVolume(level:Number):void
		{
			if (sndTransform)
			{
				sndTransform.volume = level;
				if (soundChannel) soundChannel.soundTransform = sndTransform;
			}
		}
		
		public function setPan(pan:Number):void
		{
			if (sndTransform)
			{
				sndTransform.pan = pan;
				if (soundChannel) soundChannel.soundTransform = sndTransform;
			}
		}
		
		//
		// Visualisation :
		//

		private function onEnterFrame(event:Event):void {
			
			var bytes:ByteArray = new ByteArray();
			var maxWidth:int;
			var midHeight:int;
			
			if (soundVisualConstraintRect is Rectangle)
			{
				maxWidth = soundVisualConstraintRect.width;
				midHeight = soundVisualConstraintRect.height/2;
			}
			else
			{
				// Par défaut :
				maxWidth = 100;
				midHeight = 50;
			}
			
			SoundMixer.computeSpectrum(bytes, false, 0);
			
			var g:Graphics = this.graphics;
			g.clear();
			
			g.lineStyle(0, 0xFFFFFF);
			
			var gx:Number = 0;
			var gy:Number = 0;
			
			//
			// Left channel ( y varie de 0 à midHeight : moitié haute)
			//
			g.moveTo(0, midHeight/2);
			for (var i:int = 0; i < CHANNEL_LENGTH; i++) {
				gx = maxWidth  * i / CHANNEL_LENGTH;
				gy = midHeight/2 * (1 + bytes.readFloat());
				g.lineTo(gx, gy);
			}
			
			//
			// Right channel ( y varie de midHeight à midHeight * 2 : moitié basse)
			//
			g.moveTo(0, midHeight + midHeight/2);
			for (i = CHANNEL_LENGTH; i > 0; i--) {
				gx = maxWidth  * i / CHANNEL_LENGTH;
				gy = midHeight + midHeight/2 * (1 + bytes.readFloat());
				g.lineTo(gx, gy);
			}
		}
        
		
		//
		// Interface IMediaViewer
		//
		public function close():void
		{
			if (sound)
			{
				setVolume(0);
				sound.removeEventListener(ProgressEvent.PROGRESS, onLoadSoundProgress); 
				sound.removeEventListener(Event.COMPLETE, onLoadSoundComplete); 
				sound.removeEventListener(IOErrorEvent.IO_ERROR, onLoadSoundError); 
			}
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}