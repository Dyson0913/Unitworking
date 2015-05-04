package tests
{
	import asunit.framework.TestCase;
	import Command.BetCommand;
	import Command.DataOperation;
	import Model.*;
	import util.*;	
	
	import com.adobe.utils.ArrayUtil;
	/**
  * @author hhg
  * assertTrue(bool  | (a == b));
  * assertEquals( expect, acturl);
  */
	
	public class BetCommand_Test extends TestCase
	{
		private var _instance:BetCommand;
		
		private var _opration:DataOperation;
		
		public function BetCommand_Test(testMethod:String = null) 
		{
			super(testMethod);
		}
		
		override protected function setUp():void 
		{
			super.setUp();
            _instance = new BetCommand();
			_instance._Actionmodel = new ActionQueueModel();
			_instance._model = new Model();
			_instance._model.putValue(modelName.CREDIT, 50000);
			_instance._model.putValue("coin_selectIdx", 0);
			_instance._model.putValue("coin_list", [100, 500, 1000, 5000, 10000]);
			_instance._model.putValue("after_bet_credit", 0);
			_opration = new DataOperation();
			_opration._model = _instance._model;
        }
		
       override protected function tearDown():void 
		{
			super.tearDown();
            _instance = null;
        }
		
		public function testInstantiated():void 
		{
            assertTrue(" instantiated", _instance is BetCommand);
        }
		
		public function test_put_item():void 
		{
			utilFun.Log("================= test_put_item");
			utilFun.Log("============== bet 1");
			var bet:Object = { "betType": 1, 
			                               "bet_amount":  _opration.array_idx("coin_list", "coin_selectIdx")
			};
			
			_instance._Actionmodel.push(new ActionEvent(bet,"bet_action"));
			_instance.accept_bet();
			
			var arr:Array = _instance._Bet_info.getValue("self");
			assertEquals(arr.length , 1);
			assertEquals(arr[0]["betType"], 1);
			assertEquals(arr[0]["bet_amount"], 100);
			assertEquals(_instance._model.getValue("after_bet_credit"), 49900);
			
			utilFun.Log("============== bet 2");
			_instance._model.putValue("coin_selectIdx", 2);
			var bet:Object = { "betType": 2, 
			                               "bet_amount":  _opration.array_idx("coin_list", "coin_selectIdx")
			};
			
			_instance._Actionmodel.push(new ActionEvent(bet,"bet_action"));
			_instance.accept_bet();
			var arr:Array = _instance._Bet_info.getValue("self");
			assertEquals(arr.length , 2);
			assertEquals(arr[1]["betType"], 2);
			assertEquals(arr[1]["bet_amount"], 1000);
			assertEquals(_instance._model.getValue("after_bet_credit"), 48900);
			
			
        }
		
		public function test_clean():void 
		{
		    _instance.Clean_bet();
        } 
    }   
		

}