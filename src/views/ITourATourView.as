package views
{
	
	import org.concert_urbain.touratour.models.ItemsOfQuery;
		
	public interface ITourATourView
	{
		function initWithModel (dataModel:ItemsOfQuery):void
		function clear():void
		function close():void
		function update(withAnimation:Boolean = false):void
	}
}