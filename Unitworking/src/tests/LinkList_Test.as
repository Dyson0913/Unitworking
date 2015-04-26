package tests
{
	import asunit.framework.TestCase;
	import util.node;
	import View.Viewutil.LinkList;
	
	/**
  * @author hhg
  * assertTrue(bool  | (a == b));
  * assertEquals( expect, acturl);
  */
	
	public class LinkList_Test extends TestCase
	{
		private var _instance:LinkList;
		
		public function LinkList_Test(testMethod:String = null) 
		{
			super(testMethod);
		}
		
		protected override function setUp():void 
		{
            _instance = new LinkList();
        }
		
        protected override function tearDown():void 
		{
            _instance = null;
        }
		
		public function testInstantiated():void 
		{
            assertTrue(" instantiated", _instance is LinkList);
        }
		
		public function test_init():void 
		{
			_instance.setroot(new node());			
			assertSame(_instance.head, _instance.tail)			
        } 
		
		public function test_operation():void 
		{
			_instance.setroot(new node());			
			assertSame(_instance.head, _instance.tail)
			
			_instance.addtail(new node());
			assertNotSame(_instance.head, _instance.tail)
			
			_instance.removehead();
			assertSame(_instance.head, _instance.tail)
			
			
        } 
    }   
		

}