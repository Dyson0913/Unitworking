package tests 
{
	import asunit.framework.TestCase;
	import Command.ViewCommand;
	import flash.display.MovieClip;
	import Model.valueObject.Intobject;
	
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.asconfig.*;
	
	import util.utilFun;
	/**
	 * ...
	 * @author hhg4092
	 */
	public class ViewCommand_Test extends TestCase
	{
		private var _instance:ViewCommand;
		private var _context:Context;
		private var _mc:MovieClip		
		
		public function ViewCommand_Test(testMethod:String = null) 
		{
			super(testMethod);
			_mc = new MovieClip();
			_context  = ActionScriptContextBuilder.build(appConfig, _mc);
		}
		
		override protected function setUp():void 
		{
			super.setUp();
			_instance = _context.getObjectByType(ViewCommand) as ViewCommand;
        }
		
       override protected function tearDown():void 
		{
			super.tearDown();
            _instance.all_clean();
        }
		
		public function testInstantiated():void 
		{
            assertTrue(" instantiated", _instance is ViewCommand);
        }
		
		public function test_init():void 
		{
			utilFun.Log("=================  tet_init");
			var ob:Intobject = new Intobject(1, ViewCommand.SWITCH);
           _instance.ViewSwitch(ob);
			assertEquals( 1, _instance.CurrentView);
			assertEquals( 1, _instance.preview);
        }
		
		public function test_switch_fun():void 
		{
			utilFun.Log("================= test_switch_fun");			
			var ob:Intobject = new Intobject(1, ViewCommand.SWITCH);
           _instance.ViewSwitch(ob);
			assertEquals( 1, _instance.CurrentView);
			assertEquals( 1, _instance.preview);
			
			//item test			
			_instance.currentViewDI.putValue("view1_item", 1);
			_instance.currentViewDI.putValue("view1_item2", 2);
			_instance.currentViewDI.putValue("view1_item3", 3);
			
			assertEquals( 1, _instance.Get("view1_item"));
			assertEquals( 2, _instance.Get("view1_item2"));
			assertEquals( 3, _instance.Get("view1_item3"));
			
			assertEquals( 3, _instance.currentViewDI.length());
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(2, ViewCommand.SWITCH);
            _instance.ViewSwitch(ob);
		    assertEquals( 2, _instance.CurrentView);
			assertEquals( 1, _instance.preview);
			
			//go to second view			
			_instance.currentViewDI.putValue("view2_item", 4);
			_instance.currentViewDI.putValue("view2_item2", 5);
			assertEquals( 2, _instance.currentViewDI.length());
			
			//new view item check
			assertEquals( 4, _instance.Get("view2_item"));
			assertEquals( 5, _instance.Get("view2_item2"));
			
			//old view item check			
			assertEquals( 0, _instance.preViewDI.length());
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(3, ViewCommand.SWITCH);
            _instance.ViewSwitch(ob);
		    assertEquals( 3, _instance.CurrentView);
			assertEquals( 2, _instance.preview);
			
			//go to second view			
			_instance.currentViewDI.putValue("view3_item", 6);
			_instance.currentViewDI.putValue("view3_item2", 7);
			assertEquals( 2, _instance.currentViewDI.length());
			
			//new view item check
			assertEquals( 6, _instance.Get("view3_item"));
			assertEquals( 7, _instance.Get("view3_item2"));
			
			//old view item check
			assertEquals( 0, _instance.preViewDI.length());
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(2, ViewCommand.SWITCH);
            _instance.ViewSwitch(ob);
		    assertEquals( 2, _instance.CurrentView);
			assertEquals( 3, _instance.preview);
			
			//go to second view			
			_instance.currentViewDI.putValue("view3_item", 6);
			_instance.currentViewDI.putValue("view3_item2", 7);
			assertEquals( 2, _instance.currentViewDI.length());
			
			//new view item check
			assertEquals( 6, _instance.Get("view3_item"));
			assertEquals( 7, _instance.Get("view3_item2"));
			
			//old view item check
			assertEquals( 0, _instance.preViewDI.length());
			
		}
		
		public function test_add_fun():void 
		{			
			utilFun.Log("================= test_add_fun");
			var ob:Intobject = new Intobject(1, ViewCommand.SWITCH);
           _instance.ViewSwitch(ob);
		   
			assertEquals( 1, _instance.CurrentView);
			assertEquals( 1, _instance.preview);
			
			//item test			
			_instance.currentViewDI.putValue("view1_item", 1);
			_instance.currentViewDI.putValue("view1_item2", 2);
			_instance.currentViewDI.putValue("view1_item3", 3);
			
			assertEquals( 1, _instance.Get("view1_item"));
			assertEquals( 2, _instance.Get("view1_item2"));
			assertEquals( 3, _instance.Get("view1_item3"));
			
			assertEquals( 3, _instance.currentViewDI.length());
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(3, ViewCommand.ADD);
            _instance.Viewadd(ob);
			
			assertEquals( 3, _instance.currentViewDI.length());
			
			_instance.HudViewDI.putValue("hud_item", 1);
			_instance.HudViewDI.putValue("hud_item2", 2);
			
			assertEquals( 1, _instance.GetHud("hud_item"));
			assertEquals( 2, _instance.GetHud("hud_item2"));			
			
			assertEquals( 2, _instance.HudViewDI.length());
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(3, ViewCommand.HIDE);
            _instance.ViewHide(ob);
			
			assertEquals( 3, _instance.currentViewDI.length());
			assertEquals( 0, _instance.HudViewDI.length());
			
		}	
	}

}