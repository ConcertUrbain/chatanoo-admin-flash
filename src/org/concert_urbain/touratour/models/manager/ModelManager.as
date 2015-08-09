package org.concert_urbain.touratour.models.manager
{
	import org.concert_urbain.touratour.models.*;
	
	public class ModelManager
	{
		private var queryIds:Array;
		
		public function ModelManager()
		{
			queryIds = new Array();
		}

		public function isQueryExists(queryId:Number):Boolean
		{
			return queryIds[queryId] == null ? false : true;
		}
		
		
		private function getQueryItem(queryId:Number):ModelManagerItem
		{
			if (! isQueryExists(queryId))
			{
				queryIds[queryId] = new ModelManagerItem();
			}
			return queryIds[queryId];
		}
		
		//
		// Save
		//
		
		public function saveDatasOfQuery(queryId:Number, datasOfQuery:DatasOfQuery):void
		{
			getQueryItem(queryId).datasOfQuery = datasOfQuery;
		}
		
		public function saveItemsOfQuery(queryId:Number, itemsOfQuery:ItemsOfQuery):void
		{
			getQueryItem(queryId).itemsOfQuery = itemsOfQuery;
		}
		
		//
		// Get
		//
		
		public function getDatasOfQuery(queryId:Number):DatasOfQuery
		{
			return getQueryItem(queryId).datasOfQuery;
		}
		
		public function getItemsOfQuery(queryId:Number):ItemsOfQuery
		{
			return getQueryItem(queryId).itemsOfQuery;
		}
		
	}
}