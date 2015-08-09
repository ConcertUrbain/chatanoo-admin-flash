package org.concert_urbain.touratour.api.vos.factory
{
	import org.concert_urbain.touratour.api.vos.Comment;
	import org.concert_urbain.touratour.api.vos.IVo;
	import org.concert_urbain.touratour.api.vos.Item;
	import org.concert_urbain.touratour.api.vos.Meta;
	import org.concert_urbain.touratour.api.vos.Query;
	import org.concert_urbain.touratour.api.vos.Session;
	import org.concert_urbain.touratour.api.vos.User;
	import org.concert_urbain.touratour.api.vos.datas.AddressData;
	import org.concert_urbain.touratour.api.vos.datas.CartoData;
	import org.concert_urbain.touratour.api.vos.datas.VoteData;
	import org.concert_urbain.touratour.api.vos.medias.PictureMedia;
	import org.concert_urbain.touratour.api.vos.medias.SoundMedia;
	import org.concert_urbain.touratour.api.vos.medias.TextMedia;
	import org.concert_urbain.touratour.api.vos.medias.VideoMedia;

	public class VoFactory
	{
		public static const COMMENT_TYPE:String = "Vo_Comment";
		public static const ITEM_TYPE:String = "Vo_Item";
		public static const META_TYPE:String = "Vo_Meta";
		public static const QUERY_TYPE:String = "Vo_Query";
		public static const SESSION_TYPE:String = "Vo_Session";
		public static const USER_TYPE:String = "Vo_User";
		
		public static const DATA_ADDRESS_TYPE:String = "Vo_Data_Adress";
		public static const DATA_CARTO_TYPE:String = "Vo_Data_Carto";
		public static const DATA_VOTE_TYPE:String = "Vo_Data_Vote";
		
		public static const MEDIA_PICTURE_TYPE:String = "Vo_Media_Picture";
		public static const MEDIA_SOUND_TYPE:String = "Vo_Media_Sound";
		public static const MEDIA_TEXT_TYPE:String = "Vo_Media_Text";
		public static const MEDIA_VIDEO_TYPE:String = "Vo_Media_Video";
		
		public function VoFactory()
		{
		}
		
		public static function factory(obj:Object):IVo
		{
			var vo:IVo;
			switch(obj.__className)
			{
				case COMMENT_TYPE:
					vo = new Comment(obj);
					break;
				case ITEM_TYPE:
					vo = new Item(obj);
					break;
				case META_TYPE:
					vo = new Meta(obj);
					break;
				case QUERY_TYPE:
					vo = new Query(obj);
					break;
				case SESSION_TYPE:
					vo = new Session(obj);
					break;
				case USER_TYPE:
					vo = new User(obj);
					break;
				
				case DATA_ADDRESS_TYPE:
					vo = new AddressData(obj);
					break;
				case DATA_CARTO_TYPE:
					vo = new CartoData(obj);
					break;
				case DATA_VOTE_TYPE:
					vo = new VoteData(obj);
					break;
				
				case MEDIA_PICTURE_TYPE:
					vo = new PictureMedia(obj);
					break;
				case MEDIA_SOUND_TYPE:
					vo = new SoundMedia(obj);
					break;
				case MEDIA_TEXT_TYPE:
					vo = new TextMedia(obj);
					break;
				case MEDIA_VIDEO_TYPE:
					vo = new VideoMedia(obj);
					break;
			}
			return vo;
		}
	}
}