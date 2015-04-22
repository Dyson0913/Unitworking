package 
{
	import asunit.textui.TestRunner;
	import flash.display.Sprite;
	import flash.events.Event;
	
		
	import tests.AllTests;
	/**
	 * ...
	 * @author hhg
	 */
	public class Main extends Sprite 
	{		
		 
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			 var unittests:TestRunner = new TestRunner();
			stage.addChild(unittests);
			unittests.start(tests.AllTests, null, TestRunner.SHOW_TRACE);
		}
		
	}
	
}