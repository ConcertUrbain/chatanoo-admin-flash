﻿package org.concert_urbain.cg94.view {		import flash.display.Sprite;	import flash.display.MovieClip;	import flash.events.Event;	import org.concert_urbain.touratour.models.*;    import org.concert_urbain.touratour.api.vos.*;		import gs.*;	import gs.easing.*;			public class CG94View extends MovieClip	{		protected var _itemsManager:DetailedItemsOfQuery;		public function CG94View()		{			super();						addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);		}				public function onAddedToStage(e:Event)		{		}		//		// Données de la base		//				public function initWithModel(itemsOfQuery:DetailedItemsOfQuery):void		{			_itemsManager = itemsOfQuery;									var items:Array = _itemsManager.items;						var i:int;			var n:int = items.length;						var j:int;			var m:int;						var itemId:int;			var itemVO:Item;			var metas:Array;			var metaVO:Meta;						for (i=0; i<n; i++)			{				itemVO = items[i];				itemId = itemVO.id;								trace("itemId", itemId);								metas = _itemsManager.getMetasOfItem(itemId);								m = metas.length;								for (j=0; j<m; j++)				{					metaVO = metas[j];					trace(metaVO.id, metaVO.name);				}			}		}				public function initVisitedMessages(ids:Array, lastId:Number):void{		}				public function updateVisited (lastId:Number):void{		}	}}