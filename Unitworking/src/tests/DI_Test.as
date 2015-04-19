package tests
{
	import asunit.framework.TestCase;
	import util.DI;
	
	import com.adobe.utils.ArrayUtil;
	/**
  * @author hhg
  * assertTrue(bool  | (a == b));
  * assertEquals( expect, acturl);
  */
	
	public class DI_Test extends TestCase
	{
		private var _instance:DI;
		
		public function DI_Test(testMethod:String = null) 
		{
			super(testMethod);
		}
		
		override protected function setUp():void 
		{
			super.setUp();
            _instance = new DI();
        }
		
       override protected function tearDown():void 
		{
			super.tearDown();
            _instance = null;
        }
		
		public function testInstantiated():void 
		{
            assertTrue(" instantiated", _instance is DI);
        }
		
		public function test_All_type_item_get_set():void 
		{
			
			_instance.putValue(1, 100);
			assertEquals( 100, _instance.getValue(1));
			
			_instance.putValue(1, 200);
			assertEquals( 200, _instance.getValue(1));
			
			_instance.putValue("2", "hhg");
			assertEquals( "hhg", _instance.getValue("2"));
			
			_instance.putValue(3, 10.5);
			assertEquals( 10.5, _instance.getValue(3));
			
			_instance.putValue(4, true);
			assertTrue( _instance.getValue(4) == true);
			
			_instance.putValue(5, [10, 11, 12, 13]);
			assertTrue(ArrayUtil.arraysAreEqual( [10, 11, 12, 13] , _instance.getValue(5) ) );
			
        }
		
		//public function test_():void 
		//{
			//
        //} 
    }   
		

}