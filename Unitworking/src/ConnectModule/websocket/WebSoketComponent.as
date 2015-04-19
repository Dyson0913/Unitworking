package ConnectModule.websocket 
{	
	import com.worlize.websocket.WebSocket
	import com.worlize.websocket.WebSocketEvent
	import com.worlize.websocket.WebSocketMessage
	import com.worlize.websocket.WebSocketErrorEvent
	import com.adobe.serialization.json.JSON	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.Security;
	import Model.ValueObject;
	
	import Model.ModelEvent;
	import Model.MsgQueueModel;
	
	import View.GameView.ViewState;
	import View.GameView.CardType;
	
	import util.utilFun;	
	import ConnectModule.websocket.Message


	
	/**
	 * socket 連線元件
	 * @author hhg4092
	 */
	public class WebSoketComponent 
	{
		[MessageDispatcher]
        public var dispatcher:Function;
		
		[Inject]
		public var _MsgModel:MsgQueueModel;
		
		private var websocket:WebSocket;
		
		public function WebSoketComponent() 
		{
			
		}
		
		[MessageHandler(type="ConnectModule.websocket.WebSoketInternalMsg",selector="connect")]
		public function Connect():void
		{
			utilFun.Log("connect");
			websocket = new WebSocket("ws://106.186.116.216:5000/gamesocket", "");
			websocket.addEventListener(WebSocketEvent.OPEN, handleWebSocket);
			websocket.addEventListener(WebSocketEvent.CLOSED, handleWebSocket);
			websocket.addEventListener(WebSocketErrorEvent.CONNECTION_FAIL, handleConnectionFail);
			websocket.addEventListener(WebSocketEvent.MESSAGE, handleWebSocketMessage);
			websocket.connect();
		}
		
		private function handleWebSocket(event:WebSocketEvent):void 
		{			
			if ( event.type == WebSocketEvent.OPEN)
			{
				utilFun.Log("Connected open="+ event.type );
			}
			else if ( event.type == WebSocketEvent.CLOSED)
			{
				utilFun.Log("Connected close="+ event.type );
			}
		}
		
		private function handleConnectionFail(event:WebSocketErrorEvent):void 
		{
			utilFun.Log("Connected= fale"+ event.type);
		}
		
		
		private function handleWebSocketMessage(event:WebSocketEvent):void 
		{
			var result:Object ;
			if (event.message.type === WebSocketMessage.TYPE_UTF8) 
			{
				utilFun.Log("before"+event.message.utf8Data)
				result = JSON.decode(event.message.utf8Data);			
			}
			
			_MsgModel.push(result);
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "popmsg")]
		public function msghandler():void
		{
			   var result:Object  = _MsgModel.getMsg();
				switch(result.message_type)
				{
					case Message.MSG_TYPE_LOGIN:
					{					
						var msg:Object = {"message_type":Message.MSG_TYPE_LOGIN, "session_id":Message.DEMO_SESSION};
						SendMsg(msg);
						
						break;
					}
					case Message.MSG_TYPE_LOGIN_ERROR:
					{					
						break;
					}
					
					case Message.MSG_TYPE_LOBBY:
					{
						
						//接收大廳資料
						
						//dispatcher(new ViewState(ViewState.Lobb,ViewState.ENTER) );
						//dispatcher(new ViewState(ViewState.Loading,ViewState.LEAVE) );
						
						//模擬點擊某遊戲ICON (單一遊戲都1
						var lobby:Object = {"message_type":Message.MSG_TYPE_SELECT_GAME, "game_type":1};
						SendMsg(lobby);
						break;
					}
					case Message.MSG_TYPE_GAME_LOBBY:
					{						
						//接收特定遊戲大廳資料
						//dispatcher(new ViewState(ViewState.Lobb,ViewState.ENTER) );
						//dispatcher(new ViewState(ViewState.Loading,ViewState.LEAVE) );
						
						//模擬點擊進入遊戲
						var gamelobby:Object = {"message_type":Message.MSG_TYPE_INTO_GAME, "game_room":3};
						SendMsg(gamelobby);
						break;
					}
					
					case Message.MSG_TYPE_INTO_GAME:
					{						
						//進入 遊戲,得到第一個畫面(不論半途或一開始
						
						dispatcher(new ValueObject( result.inside_game_info.player_info.nickname,"nickname") );
						dispatcher(new ValueObject( result.inside_game_info.player_info.userid,"uuid") );
						dispatcher(new ValueObject( result.inside_game_info.player_info.credit,"credit") );
						
						dispatcher(new ValueObject(  result.inside_game_info.remain_time,"remain_time") );						
						dispatcher(new ValueObject(  result.inside_game_info.games_state, "games_state") );
						
						//utilFun.Log("time =" + result.inside_game_info.remain_time);
						
						var playercard:Array = result.inside_game_info.game_info["player_card_list"];
						var bankcard:Array = result.inside_game_info.game_info["banker_card_list"];
                        dispatcher( new ValueObject(playercard, "playerpoker") );
                        dispatcher( new ValueObject(playercard, "bankerpoker") );
						
						dispatcher(new ViewState(ViewState.Bet,ViewState.ENTER) );
						//dispatcher(new ViewState(ViewState.Loading,ViewState.LEAVE) );
						
						break;
					}
					
					case Message.MSG_TYPE_STATE_INFO:
					{					  
					  
					  dispatcher(new ValueObject(  result.games_state, "games_state") );
					  dispatcher(new ValueObject(  result.remain_time, "remain_time") );
					  dispatcher(new ModelEvent("update_remain_time"));
					   break;
					}
					
					case Message.MSG_TYPE_GAME_OPEN_INFO:
					{
						dispatcher(new ValueObject(  result.games_state, "games_state") );
                        var card:Array = result.card_info["card_list"];
                        var card_type:int = result.card_info["card_type"];
						if (  result.card_info["card_type"] == CardType.PLAYER)
						{
							dispatcher( new ValueObject( card, "playerpoker") );
						}
						else if ( card_type == CardType.BANKER)
						{							
						    dispatcher( new ValueObject(card, "bankerpoker") );
						}
						
						break;
					}					
					case Message.MSG_TYPE_BET_INFO:
					{
						if (result.result)
						{
							dispatcher( new WebSoketInternalMsg(WebSoketInternalMsg.BETRESULT));
							dispatcher(new ModelEvent("updateCredit"));
						}
						else
						{
							//error handle
						}
						break;
					}
					case Message.MSG_TYPE_ROUND_INFO:
					{
						dispatcher( new ValueObject(result.bet_amount,"bet_amount"));
						dispatcher( new ValueObject(result.settle_amount,"settle_amount"));
						
						dispatcher(new ValueObject( result.player_info.credit,"credit") );
						
						dispatcher( new ValueObject(result.bet_type, "round_result"));
						
						
						break;
					}
				}
		}
		
		[MessageHandler(type="ConnectModule.websocket.WebSoketInternalMsg",selector="Bet")]
		public function SendBet():void
		{
			//var bet:Object = { "message_type":Message.MSG_TYPE_BET, 
			                               //"serial_no":0,
										   //"game_type":1,
										   //"bet_type":_BetModel._BetType,
										   //"amount":_BetModel._Betcredit };
										   //
			//SendMsg(bet);
		}
		
		public function SendMsg(msg:Object):void 
		{
			var jsonString:String = JSON.encode(msg);
			websocket.sendUTF(jsonString);
		}
		
	}
}