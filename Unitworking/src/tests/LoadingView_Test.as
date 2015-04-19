package tests
{
	import asunit.framework.Async;
	import asunit.framework.IAsync;
	import asunit.framework.TestCase;
	import asunit.framework.TimeoutCommand;
	import asunit.events.TimeoutCommandEvent;
	import com.adobe.webapis.events.ServiceEvent;
	import ConnectModule.websocket.WebSoketComponent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	 import flash.events.EventDispatcher;
	import flash.utils.setTimeout;
	import util.utilFun;
	
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.asconfig.*;
	
	import View.GameView.LoadingView;
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

		[Inject]
        public var asyn:IAsync;
		
		public var _socket:WebSoketComponent = new WebSoketComponent();
		
		public function LoadingView_Test(testMethod:String = null) 
		{
			super(testMethod);
			_mc = new MovieClip();
		 	_context  = ActionScriptContextBuilder.build(appConfig, _mc);
			
		}
		
		protected override function setUp():void 
		{
			super.setUp();
			asyn = new Async();			
         
			addChild(_context.getObjectByType(LoadingView) as LoadingView);
			_instance = _context.getObject("Enter") as LoadingView;
        }
		
        protected override function tearDown():void 
		{
			super.tearDown();
            //_instance = null;
			asyn = null;
        }
		
		public function testInstantiated():void 
		{
			utilFun.Log("testInstantiated");
            assertTrue(" instantiated", _instance is LoadingView);
        }
		
		public function test_first():void 
		{
			_instance.FirstLoad();
			
			//非同步測試 上方命令執行完,server 己回傳封包, 呼叫fun 以確認資料正確性
			var connect:Function = asyn.add(_instance.connet, 6000);
			(asyn.getPending()[0] as TimeoutCommand).addEventListener(TimeoutCommandEvent.CALLED , onCheck);
            (asyn.getPending()[0] as TimeoutCommand).addEventListener(TimeoutCommandEvent.TIMED_OUT , onTimeout);
          
			
			setTimeout(connect, 4000);
        }
		
		private function onCheck(e:TimeoutCommandEvent):void
        {
            //someAsserttest
			utilFun.Log("onCheck");
			//asyn.cancelPending();
			utilFun.Log("onCheck2");
			//進入某畫面
			
			//_socket.Connect
			//var connect:Function = asyn.add(_instance.connet, 1000);
			//(asyn.getPending()[0] as TimeoutCommand).addEventListener(TimeoutCommandEvent.CALLED , onCall);
            //(asyn.getPending()[0] as TimeoutCommand).addEventListener(TimeoutCommandEvent.TIMED_OUT , onTimeout);
			
        }
		
		public function onTimeout(e:TimeoutCommandEvent):void
        {
            //timeout
			utilFun.Log("onTimeout");
        }
		
		
    }   
		

}