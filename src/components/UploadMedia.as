package components
{
	import flash.events.Event;
	import mx.controls.Alert;
	
	// JSON API
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.core.requests.AbstractServiceRequest;
	import org.concert_urbain.touratour.api.vos.*;
	import org.concert_urbain.touratour.api.vos.datas.*;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;
	import org.concert_urbain.touratour.api.vos.medias.*;
	
	import org.concert_urbain.touratour.UploadEvents;
	import org.concert_urbain.touratour.events.*;

	
	public class UploadMedia extends UploadMediaAbstract
	{
		public var mediaId:Number;
		public var mediaVO:AbstractMedia;
		public var mediaType:String;
		
		
		public function UploadMedia()
		{
		}

		
		//
		// Ajout à la base de données des références des médias 
		//
		
		override protected function addMedia(fileName:String):void
		{
			if (fileName)
			{
				// Type de fichier ("Picture", "Video", "Sound" :
				mediaType = getFileTypeFromPath(fileName);
				
				var title:String = txtTitle.text;
				
				switch(mediaType)
				{
					case "Picture":
						var pictureVO:PictureMedia = new PictureMedia();
						pictureVO.id = 0;
						pictureVO.title = title;
						pictureVO.url = fileName;
						pictureVO.users_id = userId;
						mediaVO = pictureVO;
						break;
					
					case "Video":
						var videoVO:VideoMedia = new VideoMedia();
						videoVO.id = 0;
						videoVO.title = title;
						videoVO.url = fileName;
						videoVO.users_id = userId;
						mediaVO = videoVO;
						break;
				}
				
				// Ajout du media
				var ws:TAT = TAT.getInstance();
				ws.addEventListener(ServiceEvent.MEDIAS_ADD_MEDIA_METHOD_SUCCESS, addMediaSuccess, false, 0, true);
				ws.addEventListener(ServiceEvent.MEDIAS_ADD_MEDIA_METHOD_ERROR, addMediaError, false, 0, true);
				ws.mediasService.addMedia(mediaVO);
			}
		}		
		
		private function addMediaError(e:ServiceEvent):void
		{
			var ws:TAT = TAT.getInstance();
			ws.removeEventListener(ServiceEvent.MEDIAS_ADD_MEDIA_METHOD_SUCCESS, addMediaSuccess);
			ws.removeEventListener(ServiceEvent.MEDIAS_ADD_MEDIA_METHOD_ERROR, addMediaError);
		}
		
		protected function addMediaSuccess(e:ServiceEvent):void
		{
			var ws:TAT = TAT.getInstance();
			ws.removeEventListener(ServiceEvent.MEDIAS_ADD_MEDIA_METHOD_SUCCESS, addMediaSuccess);
			ws.removeEventListener(ServiceEvent.MEDIAS_ADD_MEDIA_METHOD_ERROR, addMediaError);
			
			// ID du media créé :
			mediaVO.id = mediaId = Number(e.result);
			
			var request:AbstractServiceRequest = e.request;
			var params:Array = request.params;
			
			// Succès de l'upload
			dispatchEvent(new IdEvent(UploadEvents.UPLOAD_SUCCESS, mediaId));
		}
	}
}