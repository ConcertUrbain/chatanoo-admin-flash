package org.concert_urbain.touratour.api
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.utils.Dictionary;
	
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.core.requests.AbstractServiceRequest;
	import org.concert_urbain.touratour.api.core.requests.ConnectionServiceRequest;
	import org.concert_urbain.touratour.api.services.AbstractService;
	import org.concert_urbain.touratour.api.services.CommentsService;
	import org.concert_urbain.touratour.api.services.DatasService;
	import org.concert_urbain.touratour.api.services.ItemsService;
	import org.concert_urbain.touratour.api.services.MediasService;
	import org.concert_urbain.touratour.api.services.PluginsService;
	import org.concert_urbain.touratour.api.services.QueriesService;
	import org.concert_urbain.touratour.api.services.SearchService;
	import org.concert_urbain.touratour.api.services.SessionsService;
	import org.concert_urbain.touratour.api.services.UsersService;
	import org.concert_urbain.touratour.api.vos.IVo;
	
	public class TAT extends EventDispatcher
	{		
		private static var _instance:TAT;
		
		private var _url:String;
		private var _apiKey:String;
		private var _sessionKey:String;
		
		private var _isLogged:Boolean = false;
		
		private var _loaders:Dictionary;
		
		private var _services:Array;
		
		public function TAT()
		{
			if(!_instance)
				_instance = this;
			else
				throw new Error('Singleton Error: TAT');
			
			_loaders = new Dictionary();
			
			_services = [];
			_services['comments'] = new CommentsService();
			_services['datas'] = 	new DatasService();
			_services['items'] = 	new ItemsService();
			_services['medias'] = 	new MediasService();
			_services['plugins'] = 	new PluginsService();
			_services['queries'] = 	new QueriesService();
			_services['search'] = 	new SearchService();
			_services['sessions'] = new SessionsService();
			_services['users'] = 	new UsersService();
		}
		
		public static function getInstance():TAT
		{
			if(!_instance)
				_instance = new TAT();
			return _instance;
		}
		
		public function init(pUrl:String, pApiKey:String):void
		{
			_url = pUrl;
			_apiKey = pApiKey;
		}
		
		public function login(user:String, pass:String):String
		{
			var request:ConnectionServiceRequest = new ConnectionServiceRequest(ConnectionServiceRequest.LOGIN_METHOD);
			request.params = [user, pass, _apiKey];
			sendRequest(request);
			return request.id;
		}
		
		public function logout():String
		{
			var request:ConnectionServiceRequest = new ConnectionServiceRequest(ConnectionServiceRequest.LOGIN_METHOD);
			sendRequest(request);
			return request.id;
		}
		
		//
		
		public function sendRequest(request:AbstractServiceRequest):void
		{
			if(request.service != 'connection' && !_isLogged)
			{
				trace('[ERROR] No user logged. Please send login request.')
				return;
			}
			
			var params:Array = request.params;
			for(var i:uint = 0; i < request.params.length; i++)
			{
				if(request.params[i] is IVo)
					request.params[i] = IVo(request.params[i]).getSerialisableObject();
			}
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, 					_handler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, 		_handler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, 				_handler);
			loader.addEventListener(ProgressEvent.PROGRESS, 			_handler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, 	_handler);
			
			request.params = params;
			_loaders[loader] = request;
			
			loader.load(request.getJSONRequest());
		}
		
		private function _handler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var request:AbstractServiceRequest = _loaders[loader] as AbstractServiceRequest;
			var e:ServiceEvent;
			switch(event.type)
			{
				case Event.COMPLETE:
					if(request.service == 'connection')
						_isLogged = request.method == 'login';
					if(request.service == 'connection' && request.method == 'login')
						_sessionKey = com.adobe.serialization.json.JSON.decode(loader.data).result;
					e = new ServiceEvent(true, request, com.adobe.serialization.json.JSON.decode(loader.data).result);
					_clearLoader(loader);
					break;
				case HTTPStatusEvent.HTTP_STATUS:
					if(HTTPStatusEvent(event).status != 200 && HTTPStatusEvent(event).status != 0)
					{
						e = new ServiceEvent(false, request, loader.data);
						_clearLoader(loader);
					}
					break;
				case IOErrorEvent.IO_ERROR:
					e = new ServiceEvent(false, request, loader.data);
					_clearLoader(loader);
					break;
				case ProgressEvent.PROGRESS:
					break;
				case SecurityErrorEvent.SECURITY_ERROR:
					e = new ServiceEvent(false, request, loader.data);
					_clearLoader(loader);
					break;
			}
			if(e) dispatchEvent(e);
		}
		
		private function _clearLoader(loader:URLLoader):void
		{
			loader.removeEventListener(Event.COMPLETE, 						_handler);
			loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, 		_handler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, 				_handler);
			loader.removeEventListener(ProgressEvent.PROGRESS, 				_handler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, 	_handler);
			
			delete _loaders[loader];
		}
		
		// GETTER
		
		public function get url():String
		{
			return _url;
		}
		
		public function get apiKey():String
		{
			return _apiKey;
		}
		
		public function get sessionKey():String
		{
			return _sessionKey;
		}
		
		////////////////
		
		public function get commentsService():CommentsService
		{
			return _services['comments'];
		}
		
		public function get datasService():DatasService
		{
			return _services['datas'];
		}
		
		public function get itemsService():ItemsService
		{
			return _services['items'];
		}
		
		public function get mediasService():MediasService
		{
			return _services['medias'];
		}
		
		public function get pluginsService():PluginsService
		{
			return _services['plugins'];
		}
		
		public function get queriesService():QueriesService
		{
			return _services['queries'];
		}
		
		public function get searchService():SearchService
		{
			return _services['search'];
		}
		
		public function get sessionsService():SessionsService
		{
			return _services['sessions'];
		}
		
		public function get usersService():UsersService
		{
			return _services['users'];
		}
		
	}
}