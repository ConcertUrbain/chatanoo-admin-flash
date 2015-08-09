package org.concert_urbain.touratour.api.core.requests
{
	public class PluginsServiceRequest extends AbstractServiceRequest
	{
		public static const SERVICE_NAME:String = "plugins";
		
		public static const CALL_METHOD:String = "call";
		
		public function PluginsServiceRequest(methodName:String)
		{
			super();
			_service = SERVICE_NAME;
			_method = methodName;
		}
	}
}