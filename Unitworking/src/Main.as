package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import tests.AsUnitRunner;
	
	 import asunit.core.TextCore;
	 
		
	import tests.AllTests;
	/**
	 * ...
	 * @author hhg
	 */
	public class Main extends Sprite 
	{
		private var _as:AsUnitRunner;
		 
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			 _as = new AsUnitRunner();
			 addChild(_as);
		}
		
	}
	
}