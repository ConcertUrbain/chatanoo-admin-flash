package views
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.containers.Canvas;
	
	import org.concert_urbain.touratour.models.ItemsOfQuery;

		
	public class TourATourView extends Canvas implements ITourATourView
	{
		// Données de la query
		protected var _model:ItemsOfQuery;
		protected var _visitedIds:Array;
		protected var _visitedLastId:Number;
		
		// Mémorisation de la taille du Canvas (pour redessiner ssi le canvas a changé)
		protected var canvas:Canvas;
		protected var prevCanvasWidth:Number;
		protected var prevCanvasHeight:Number;

		
		public function TourATourView (){}
		
		public function initWithModel (dataModel:ItemsOfQuery):void{
			dataModel.addEventListener(ItemsOfQuery.CLEAR, onClearModel, false, 0, true);
			
			// Nouveau modèle de données
			_model = dataModel;
		}
		
		
		public function initVisitedMessages(ids:Array, lastId:Number):void{
			_visitedIds = ids;
			_visitedLastId = lastId;
		}
		
		public function updateVisited (lastId:Number):void{
			_visitedLastId = lastId;
		}
		
		
		protected function onClearModel(e:Event):void{	clear();	}
		
		public function resizeCanvas():void {}
		
		
		public function hasCanvasChanged():Boolean {
			
			if (canvas)
			{
				var canvasWidth:Number = canvas.width;
				var canvasHeight:Number = canvas.height;
				
				if ((prevCanvasWidth == canvasWidth) && (prevCanvasHeight == canvasHeight)) return false;
				
				prevCanvasWidth = canvasWidth; 
				prevCanvasHeight = canvasHeight;
				
				return true;
			}
			
			return true;
		}
		
		public function update(withAnimation:Boolean = false):void{}
		
		// Suppression des données existantes, ainsi que des éléments graphiques en cours
		public function clear():void{}
		
		public function close():void{}
	}
}