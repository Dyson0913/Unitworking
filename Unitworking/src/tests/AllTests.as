package  tests
{	
	import asunit.framework.TestSuite;	
	import tests.*;	
	
	/**
	 * main test , put all your testcase in here 
	 * @author hhg4092
	 */	
	public class AllTests extends TestSuite
	{	
		
		public function AllTests()
        {
			//addTest(new DI_Test());
			//addTest(new PageSlipModel_Test());			
			addTest(new ViewCommand_Test());
			//addTest(new LoadingView_Test());
			//addTest(new BetView_Test());
			//addTest(new node_Test());
			//addTest(new LinkList_Test());
			//addTest(new LoadingView_Test());
			//addTest(new BetCommand_Test());
			//addTest(new BetCommand_Test());
        }
	}

}