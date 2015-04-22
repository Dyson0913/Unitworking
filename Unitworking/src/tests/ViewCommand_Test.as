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
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(2, ViewCommand.SWITCH);
            _instance.ViewSwitch(ob);
		    assertEquals( 2, _instance.CurrentView);
			assertEquals( 1, _instance.preview);
			
			utilFun.Log("===============");
			var ob:Intobject  = new Intobject(3, ViewCommand.SWITCH);
            _instance.ViewSwitch(ob);
		    assertEquals( 3, _instance.CurrentView);
			assertEquals( 2, _instance.preview);
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