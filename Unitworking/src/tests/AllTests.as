package  tests
{	
	import asunit.framework.TestSuite;
	import tests.*;
	import tests.LoadingView_Test;
	
	/**
	 * main test , put all your testcase in here 
	 * @author hhg4092
	 */	
	public class AllTests extends TestSuite
	{	
		
		public function AllTests()
        {
			addTest(new DI_Test());
			addTest(new PageSlipModel_Test());
        }
	}

}