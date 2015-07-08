package tests 
{
	import asunit.framework.TestCase;
	import Command.ViewCommand;
	import Model.valueObject.Intobject;
	import util.utilFun;
	/**
	 * ...
	 * @author hhg4092
	 */
	public class ViewCommand_Test extends TestCase
	{
		private var _instance:ViewCommand;
		
		public function ViewCommand_Test(testMethod:String = null) 
		{
			super(testMethod);
		}
		
		override protected function setUp():void 
		{
			super.setUp();
            _instance = new ViewCommand();
        }
		
       override protected function tearDown():void 
		{
			super.tearDown();
            _instance = null;
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
			_instance.viewDISwitch();
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
			_instance.viewDISwitch();
			_instance.currentViewDI.putValue("view2_item", 4);
			_instance.currentViewDI.putValue("view2_item2", 5);
			assertEquals( 2, _instance.currentViewDI.length());
			
			//new view item check
			assertEquals( 4, _instance.Get("view2_item"));
			assertEquals( 5, _instance.Get("view2_item2"));
			
			//old view item check
			assertEquals( 3, _instance.nextViewDI.length());
			_instance.BackView_clean();
			assertEquals( 0, _instance.nextViewDI.length());
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(3, ViewCommand.SWITCH);
            _instance.ViewSwitch(ob);
		    assertEquals( 3, _instance.CurrentView);
			assertEquals( 2, _instance.preview);
			
			//go to second view
			_instance.viewDISwitch();
			_instance.currentViewDI.putValue("view3_item", 6);
			_instance.currentViewDI.putValue("view3_item2", 7);
			assertEquals( 2, _instance.currentViewDI.length());
			
			//new view item check
			assertEquals( 6, _instance.Get("view3_item"));
			assertEquals( 7, _instance.Get("view3_item2"));
			
			//old view item check
			assertEquals( 2, _instance.nextViewDI.length());
			_instance.BackView_clean();
			assertEquals( 0, _instance.nextViewDI.length());
		}
		
		public function test_add_fun():void 
		{			
			utilFun.Log("================= test_add_fun");
			var ob:Intobject = new Intobject(1, ViewCommand.SWITCH);
           _instance.ViewSwitch(ob);
			assertEquals( 1, _instance.CurrentView);
			assertEquals( 1, _instance.preview);
			
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(3, ViewCommand.ADD);
            _instance.Viewadd(ob);
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(3, ViewCommand.HIDE);
            _instance.ViewHide(ob);
		}	
	}

}