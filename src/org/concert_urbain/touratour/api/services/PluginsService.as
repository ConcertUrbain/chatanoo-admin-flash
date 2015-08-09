package org.concert_urbain.touratour.api.services
{
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.requests.PluginsServiceRequest;

	public class PluginsService extends AbstractService
	{
		public function PluginsService()
		{
			super();
		}
		
		public function call(name:String, params:Array):String
		{
			var request:PluginsServiceRequest = new PluginsServiceRequest(PluginsServiceRequest.CALL_METHOD);
			request.params = [name, params];
			TAT.getInstance().sendRequest(request);
			return request.id;
		}
	}
}