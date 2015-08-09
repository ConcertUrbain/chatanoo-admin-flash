package components
{
	import flash.events.Event;
	
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

	
	public class UploadMediaAndAddItem extends UploadMediaAbstract
	{
		// Id de la query à laquelle on ajoute des items
		public var queryId:Number = 1;
		
		// Id créés lors de l'upload
		public var itemId:Number;
		public var mediaId:Number;
		
		// VO créées
		public var itemVO:Item;
		public var mediaVO:AbstractMedia;
		
		public var mediaType:String;
		
		
		public function UploadMediaAndAddItem()
		{
		}
		
		//
		// Ajout à la base de données des références des médias 
		//
		
		override protected function addMedia(fileName:String):void
		{
			//
			// Ajout de l'item :
			//
			
			itemVO = new Item();
			itemVO.title = txtTitle.text;
			itemVO.description = "";
			itemVO.id = 0;
			itemVO.users_id = userId;
			itemVO.isValid = true;
			
			trace("UploadModule users_id = ", userId);
			
			var ws:TAT = TAT.getInstance();
			ws.queriesService.addItemIntoQuery(itemVO, queryId, {title:txtTitle.text, fileName:fileName});
			ws.addEventListener(ServiceEvent.QUERIES_ADD_ITEM_FROM_QUERY_METHOD_SUCCESS , addItemResult, false, 0, true);
			ws.addEventListener(ServiceEvent.QUERIES_ADD_ITEM_FROM_QUERY_METHOD_ERROR, addItemResultError, false, 0, true);
		}

		private function addItemResultError(e:ServiceEvent):void
		{
			var ws:TAT = TAT.getInstance();
			ws.removeEventListener(ServiceEvent.QUERIES_ADD_ITEM_FROM_QUERY_METHOD_SUCCESS, addItemResult);
			ws.removeEventListener(ServiceEvent.QUERIES_ADD_ITEM_FROM_QUERY_METHOD_ERROR, addItemResultError);
		}
		
		private function addItemResult(e:ServiceEvent):void
		{
			var ws:TAT = TAT.getInstance();
			ws.removeEventListener(ServiceEvent.QUERIES_ADD_ITEM_FROM_QUERY_METHOD_SUCCESS, addItemResult);
			ws.removeEventListener(ServiceEvent.QUERIES_ADD_ITEM_FROM_QUERY_METHOD_ERROR, addItemResultError);
			
			// ID de l'item créé :
			var itemId:Number = Number(e.result);
			
			var request:AbstractServiceRequest = e.request;
			var params:Array = request.params;
			
			var itemVO:Item = new  Item(params[0]);
			itemVO.id = itemId;

			
			//
			// Ajout du média
			//
			
			// Titre et URL du média				
			var fileInfos:Object = params[2];		
			var title:String = fileInfos.title;
			var fileName:String = fileInfos.fileName;
			
			if (fileName)
			{
				// Type de fichier ("Picture", "Video", "Sound") :
				mediaType = getFileTypeFromPath(fileName);
				
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
					
					case "Sound":
						var soundVO:SoundMedia = new SoundMedia();
						soundVO.id = 0;
						soundVO.title = title;
						soundVO.url = fileName;
						soundVO.users_id = userId;
						mediaVO = soundVO;
						break;
					
					case "Text":
						var textVO:TextMedia = new TextMedia();
						textVO.id = 0;
						textVO.title = title;
						textVO.users_id = userId;
						mediaVO = textVO;
						break;
				}
				
				// Ajout du media à l'item
				ws.addEventListener(ServiceEvent.ITEMS_ADD_MEDIA_INTO_ITEM_METHOD_SUCCESS, addMediaToItem, false, 0, true);
				ws.addEventListener(ServiceEvent.ITEMS_ADD_MEDIA_INTO_ITEM_METHOD_SUCCESS, addMediaToItemError, false, 0, true);
				ws.itemsService.addMediaIntoItem(mediaVO, itemId);
			}
		}		
		
		private function addMediaToItemError(e:ServiceEvent):void
		{
			var ws:TAT = TAT.getInstance();
			ws.removeEventListener(ServiceEvent.ITEMS_ADD_MEDIA_INTO_ITEM_METHOD_SUCCESS, addMediaToItem);
			ws.removeEventListener(ServiceEvent.ITEMS_ADD_MEDIA_INTO_ITEM_METHOD_SUCCESS, addMediaToItemError);
		}
		
		protected function addMediaToItem(e:ServiceEvent):void
		{
			var ws:TAT = TAT.getInstance();
			ws.removeEventListener(ServiceEvent.ITEMS_ADD_MEDIA_INTO_ITEM_METHOD_SUCCESS, addMediaToItem);
			ws.removeEventListener(ServiceEvent.ITEMS_ADD_MEDIA_INTO_ITEM_METHOD_SUCCESS, addMediaToItemError);
			
			// ID du media créé :
			mediaVO.id = mediaId = Number(e.result);
			
			var request:AbstractServiceRequest = e.request;
			var params:Array = request.params;
			
			var itemId:Number = Number(params[1]);
			
			// Succès de l'upload
			dispatchEvent(new IdEvent(UploadEvents.UPLOAD_SUCCESS, itemId));
		}
	}
}