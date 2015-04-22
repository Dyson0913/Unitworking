package tests 
{
	import asunit.framework.TestCase;
	import Model.PageSlipModel;
	/**
	 * ...
	 * @author hhg4092
	 */
	public class PageSlipModel_Test  extends TestCase
	{
		private var _instance:PageSlipModel;
		
		public function PageSlipModel_Test(testMethod:String = null) 
		{
			super(testMethod);
		}		
		
		override protected function setUp():void 
		{
			super.setUp();
            _instance = new PageSlipModel();
        }
		
       override protected function tearDown():void 
		{
			super.tearDown();
            _instance = null;
        }
		
		public function testInstantiated():void 
		{
            assertTrue(" instantiated", _instance is PageSlipModel );
        }
		
		public function test_base_operation():void 
		{
			var arr:Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
			
			_instance.pageSetting(arr,3);
            assertEquals( "1/4", _instance.CurrentPage("/"));
			
			//pre operation
			_instance.PrePage();
			assertEquals( "1/4", _instance.CurrentPage("/"));
			
			_instance.NextPage();
			assertEquals( "2/4", _instance.CurrentPage("/"));
			
			_instance.NextPage();
			assertEquals( "3/4", _instance.CurrentPage("/"));
			
			_instance.NextPage();
			assertEquals( "4/4", _instance.CurrentPage("/"));
			
			//over
			_instance.NextPage();
			assertEquals( "4/4", _instance.CurrentPage("/"));
			
			//往回切
			_instance.PrePage();
			assertEquals( "3/4", _instance.CurrentPage("/"));
			
			_instance.PrePage();
			assertEquals( "2/4", _instance.CurrentPage("/"));
			
			_instance.PrePage();
			assertEquals( "1/4", _instance.CurrentPage("/"));
			
			_instance.PrePage();
			assertEquals( "1/4", _instance.CurrentPage("/"));
			
        }
		
	}

}