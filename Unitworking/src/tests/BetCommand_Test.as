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
			_instance._Actionmodel = new ActionQueue();
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
		
		//摸擬server 收到的資料
		public function mockServer_check(type:int,amount:int):void
		{
			utilFun.Log("mockServer_check");
			var bet_ob:Object  = _instance._Actionmodel.getMsg();
			assertEquals(type,bet_ob["betType"]);
			assertEquals(amount,bet_ob["bet_amount"]);
		}
		
		public function clilent_check(len:int,type:int,amount:int,total:int):void
		{
			
			var arr:Array = _instance._Bet_info.getValue("self");
			utilFun.Log("len_check");
			assertEquals(len, arr.length );
			utilFun.Log("type_check");
			assertEquals(type, arr[arr.length-1]["betType"]);
			utilFun.Log("amount_check");
			assertEquals(amount, arr[arr.length-1]["bet_amount"]);
			utilFun.Log("total_check");
			assertEquals(total, _instance._model.getValue("after_bet_credit"));
		}
		
		
		public function test_put_item():void 
		{
			utilFun.Log("================= test_put_item");
			utilFun.Log("============== bet 1");
			var bet:Object = { "betType": 1, 
			                               "bet_amount":   _instance.get_total_bet(1) + _opration.array_idx("coin_list", "coin_selectIdx")
			};
			
			_instance._Actionmodel.push(new ActionEvent(bet, "bet_action"));
			mockServer_check(1,100);
			_instance.accept_bet();			
			clilent_check(1, 1, 100, 49900);
			
			utilFun.Log("============== bet 2");		
			var bet:Object = { "betType": 2, 
			                               "bet_amount":  _instance.get_total_bet(2) + _opration.array_idx("coin_list", "coin_selectIdx")
			};
			
			_instance._Actionmodel.push(new ActionEvent(bet, "bet_action"));
			mockServer_check(2,100);
			_instance.accept_bet();
			clilent_check(2, 2, 100, 49800);			
		
			utilFun.Log("============== bet 3");		
			var bet:Object = { "betType": 1, 
			                               "bet_amount":  _instance.get_total_bet(1) + _opration.array_idx("coin_list", "coin_selectIdx")
			};
			
			_instance._Actionmodel.push(new ActionEvent(bet, "bet_action"));
			mockServer_check(1,200);
			_instance.accept_bet();
			clilent_check(3, 1, 100, 49700);
			
			utilFun.Log("============== bet 4");		
			var bet:Object = { "betType": 1, 
			                               "bet_amount":  _instance.get_total_bet(1) + _opration.array_idx("coin_list", "coin_selectIdx")
			};
			
			_instance._Actionmodel.push(new ActionEvent(bet, "bet_action"));
			mockServer_check(1,300);
			_instance.accept_bet();
			clilent_check(4, 1, 100, 49600);
			
        }
		
		public function test_clean():void 
		{
		    _instance.Clean_bet();
			assertEquals(_instance._Bet_info.lenth(), 0);
        } 
    }   
		

}