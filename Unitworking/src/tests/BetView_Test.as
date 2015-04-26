package tests 
{
	import asunit.framework.TestCase;
	import flash.events.Event;
	import util.utilFun;
	
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.asconfig.*;
	
	import com.adobe.utils.ArrayUtil;
	import View.GameView.*;
	import Model.*;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author hhg4092
	 */
	public class BetView_Test extends TestCase
	{
		private var _context:Context;
		private var _mc:MovieClip;
		private var _instance:betView;
		
		public function BetView_Test(testMethod:String = null) 
		{
			super(testMethod);
			_mc = new MovieClip();
		 	_context  = ActionScriptContextBuilder.build(appConfig, _mc);
			
		}
		
		protected override function setUp():void 
		{
			super.setUp();						
			//addChild(_context.getObjectByType(LoadingView) as LoadingView);
			//addChild(_context.getObjectByType(Lobby) as Lobby);
			addChild(_context.getObjectByType(betView) as betView);
			//addChild(_context.getObjectByType(HudView) as HudView);
			_instance = _context.getObject("Enter") as betView ;
			_instance.FirstLoad();		
        }
		
        protected override function tearDown():void 
		{
			super.tearDown();
            //_instance = null;
        }
		
		public function testInstantiated():void 
		{
			utilFun.Log("testInstantiated");
            assertTrue(" instantiated", _instance is betView);
        }
		
		public function test_model_init():void 
		{
			utilFun.Log("================= test_model_init");
			assertEquals("hhg4092", _instance._model.getValue(modelName.NICKNAME));
            assertEquals(4092, _instance._model.getValue(modelName.UUID));
            assertEquals(500, _instance._model.getValue(modelName.CREDIT));
            assertEquals(10, _instance._model.getValue(modelName.REMAIN_TIME));
            assertEquals(3, _instance._model.getValue(modelName.GAMES_STATE));
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.PLAYER_POKER)) );
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.BANKER_POKER)) );
          
        }
		
		public function test_state_test():void 
		{
			utilFun.Log("================= test_state_test");
			
            assertEquals("hhg4092", _instance._model.getValue(modelName.NICKNAME));
            assertEquals(4092, _instance._model.getValue(modelName.UUID));
            assertEquals(500, _instance._model.getValue(modelName.CREDIT));
            assertEquals(10, _instance._model.getValue(modelName.REMAIN_TIME));
            assertEquals(3, _instance._model.getValue(modelName.GAMES_STATE));
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.PLAYER_POKER)) );
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.BANKER_POKER)) );
			
			utilFun.Log("==============");
			_instance.updata_state_info(gameState.NEW_ROUND);
			assertEquals(gameState.NEW_ROUND, _instance._model.getValue(modelName.GAMES_STATE));
			
			_instance.updata_state_info(gameState.END_BET);
			assertEquals(gameState.END_BET, _instance._model.getValue(modelName.GAMES_STATE));
			
			_instance.updata_state_info(gameState.START_OPEN);
			assertEquals(gameState.START_OPEN, _instance._model.getValue(modelName.GAMES_STATE));
			
			_instance.updata_state_info(gameState.END_ROUND);
			assertEquals(gameState.END_ROUND, _instance._model.getValue(modelName.GAMES_STATE));
        }
		
		public function test_dear_card():void
		{
			utilFun.Log("================= test_dear_card");
			
			assertEquals("hhg4092", _instance._model.getValue(modelName.NICKNAME));
            assertEquals(4092, _instance._model.getValue(modelName.UUID));
            assertEquals(500, _instance._model.getValue(modelName.CREDIT));
            assertEquals(10, _instance._model.getValue(modelName.REMAIN_TIME));
            assertEquals(3, _instance._model.getValue(modelName.GAMES_STATE));
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.PLAYER_POKER)) );
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.BANKER_POKER)) );
			
			utilFun.Log("==============");
			_instance.deal_card(CardType.PLAYER, ["1s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["1s"], _instance._model.getValue(modelName.PLAYER_POKER)) );
			
			_instance.deal_card(CardType.BANKER, ["2s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["2s"], _instance._model.getValue(modelName.BANKER_POKER)) );
			
			_instance.deal_card(CardType.PLAYER, ["1s","2s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["1s", "2s"], _instance._model.getValue(modelName.PLAYER_POKER)) );
			
			_instance.deal_card(CardType.BANKER, ["2s", "3s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["2s", "3s"], _instance._model.getValue(modelName.BANKER_POKER)) );
			
			_instance.deal_card(CardType.PLAYER, ["1s","2s","3s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["1s", "2s","3s"], _instance._model.getValue(modelName.PLAYER_POKER)) );
			
			_instance.deal_card(CardType.BANKER, ["2s", "3s","4s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["2s", "3s","4s"], _instance._model.getValue(modelName.BANKER_POKER)) );
		}
		
		public function test_result():void
		{
			utilFun.Log("================= test_result");
			
			assertEquals("hhg4092", _instance._model.getValue(modelName.NICKNAME));
            assertEquals(4092, _instance._model.getValue(modelName.UUID));
            assertEquals(500, _instance._model.getValue(modelName.CREDIT));
            assertEquals(10, _instance._model.getValue(modelName.REMAIN_TIME));
            assertEquals(3, _instance._model.getValue(modelName.GAMES_STATE));
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.PLAYER_POKER)) );
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.BANKER_POKER)) );
			
			utilFun.Log("==============");
			_instance.deal_card(CardType.PLAYER, ["1s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["1s"], _instance._model.getValue(modelName.PLAYER_POKER)) );
			
			_instance.deal_card(CardType.BANKER, ["2s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["2s"], _instance._model.getValue(modelName.BANKER_POKER)) );
			
			_instance.deal_card(CardType.PLAYER, ["1s","2s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["1s", "2s"], _instance._model.getValue(modelName.PLAYER_POKER)) );
			
			_instance.deal_card(CardType.BANKER, ["2s", "3s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["2s", "3s"], _instance._model.getValue(modelName.BANKER_POKER)) );
			
			_instance.deal_card(CardType.PLAYER, ["1s","2s","3s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["1s", "2s","3s"], _instance._model.getValue(modelName.PLAYER_POKER)) );
			
			_instance.deal_card(CardType.BANKER, ["2s", "3s","4s"]);
			assertTrue(ArrayUtil.arraysAreEqual(["2s", "3s","4s"], _instance._model.getValue(modelName.BANKER_POKER)) );
			
			_instance.fake_result(10, 20, 400, 12);
			assertEquals(10, _instance._model.getValue(modelName.BET_AMOUNT));
			assertEquals(20, _instance._model.getValue(modelName.SETTLE_AMOUNT));
			assertEquals(400, _instance._model.getValue(modelName.CREDIT));
			assertEquals(12, _instance._model.getValue(modelName.ROUND_RESULT));
			_instance.round_result();
		}
		
		public function test_reaction():void
		{
			utilFun.Log("================= test_result");
			
			assertEquals("hhg4092", _instance._model.getValue(modelName.NICKNAME));
            assertEquals(4092, _instance._model.getValue(modelName.UUID));
            assertEquals(500, _instance._model.getValue(modelName.CREDIT));
            assertEquals(10, _instance._model.getValue(modelName.REMAIN_TIME));
            assertEquals(gameState.NEW_ROUND, _instance._model.getValue(modelName.GAMES_STATE));
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.PLAYER_POKER)) );
            assertTrue(ArrayUtil.arraysAreEqual([], _instance._model.getValue(modelName.BANKER_POKER)) );
			
			//assertTrue(_instance.plaerType(new Event, 0);
			//assertEquals(gameState.NEW_ROUND, _instance._BetModel._BetType));
		}
			
	}

}