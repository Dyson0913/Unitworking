package tests
{
	import asunit.framework.TestCase;
	import ConnectModule.websocket.WebSoketComponent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	 import flash.events.EventDispatcher;
	import flash.utils.setTimeout;
	import util.utilFun;
	
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.asconfig.*;
	
	import View.GameView.*;
	import Model.*;
	
	/**
  * @author hhg
  * assertTrue(bool  | (a == b));
  * assertEquals( expect, acturl);
  */
	
	public class LoadingView_Test extends TestCase
	{
		private var _context:Context;
		private var _mc:MovieClip;
		private var _instance:LoadingView;
		
		public function LoadingView_Test(testMethod:String = null) 
		{
			super(testMethod);
			_mc = new MovieClip();
		 	_context  = ActionScriptContextBuilder.build(appConfig, _mc);
			
		}
		
		protected override function setUp():void 
		{
			super.setUp();						
			addChild(_context.getObjectByType(LoadingView) as LoadingView);			
			addChild(_context.getObjectByType(betView) as betView);			
			_instance = _context.getObject("Enter") as LoadingView;
        }
		
        protected override function tearDown():void 
		{
			super.tearDown();
            //_instance = null;
        }
		
		public function testInstantiated():void 
		{
			//utilFun.Log("testInstantiated");
            assertTrue(" instantiated", _instance is LoadingView);
        }
		
		public function test_first():void 
		{
			utilFun.Log("test_first");
			_instance.FirstLoad();		
        }		
    }   
		

}