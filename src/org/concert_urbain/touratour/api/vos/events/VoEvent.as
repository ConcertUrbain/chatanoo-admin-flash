package org.concert_urbain.touratour.api.vos.events
{
	import flash.events.Event;
	
	public class VoEvent extends Event
	{
		public static const SAVE_SUCCESS:String = 	"vo_saveSuccess";
		public static const SAVE_ERROR:String = 	"vo_saveError";
		
		public static const SYNCHRONIZE_SUCCESS:String = 	"vo_synchronizeSuccess";
		public static const SYNCHRONIZE_ERROR:String = 		"vo_synchronizeError";
		
		public static const ERASE_SUCCESS:String = 	"vo_eraseSuccess";
		public static const ERASE_ERROR:String = 	"vo_eraseError";
		
		
		public static const LOAD_QUERIES_SUCCESS:String = 	"vo_loadQueriesSuccess";
		public static const LOAD_QUERIES_ERROR:String = 	"vo_loadQueriesError";	
		
		public static const LOAD_COMMENTS_SUCCESS:String = 	"vo_loadCommentsSuccess";
		public static const LOAD_COMMENTS_ERROR:String = 	"vo_loadCommentsError";
		
		public static const LOAD_ITEMS_SUCCESS:String = 	"vo_loadItemsSuccess";
		public static const LOAD_ITEMS_ERROR:String = 		"vo_loadItemsError";
		
		public static const LOAD_METAS_SUCCESS:String = 	"vo_loadMetasSuccess";
		public static const LOAD_METAS_ERROR:String = 		"vo_loadMetasError";
		
		public static const LOAD_DATAS_SUCCESS:String = 	"vo_loadDatasSuccess";
		public static const LOAD_DATAS_ERROR:String = 		"vo_loadDatasError";
		
		public static const LOAD_MEDIAS_SUCCESS:String = 	"vo_loadMediasSuccess";
		public static const LOAD_MEDIAS_ERROR:String = 		"vo_loadMediasError";

		
		public function VoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}