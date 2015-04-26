package tests
{
	import asunit.framework.TestCase;
	import flash.display.MovieClip;
	import util.node;
	
	/**
  * @author hhg
  * assertTrue(bool  | (a == b));
  * assertEquals( expect, acturl);
  */
	
	public class node_Test extends TestCase
	{
		private var _instance:node;
		
		public function node_Test(testMethod:String = null) 
		{
			super(testMethod);
		}
		
		protected override function setUp():void 
		{
            _instance = new node();
        }
		
        protected override function tearDown():void 
		{
            _instance = null;
        }
		
		public function testInstantiated():void 
		{
            assertTrue(" instantiated", _instance is node);
        }
		
		public function test_init():void 
		{
			_instance.create(new MovieClip(), new MovieClip());
			
			assertNull(_instance.next);
			
			var no:node = new node();
			no.create(new MovieClip(),new MovieClip());
			_instance.next = no;
			
		   assertNotNull(	_instance.next);
		   
		} 
    }   
		

}