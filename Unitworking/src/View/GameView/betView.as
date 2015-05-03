package View.GameView
{
	import ConnectModule.websocket.WebSoketInternalMsg;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import Model.valueObject.*
	import util.DI;
	import Model.*
	import View.Viewutil.*;
	import View.ViewBase.ViewBase;
	import util.utilFun;
	
	import Command.*;
	
	import caurina.transitions.Tweener;
	/**
	 * ...
	 * @author hhg
	 */
	public class betView extends ViewBase
	{
		[Inject]
		public var _BetModel:BetModel;
		
		public function betView()  
		{
			utilFun.Log("betView");
		}
		
		public function FirstLoad():void
		{			
			dispatcher(new ValueObject( "hhg4092",modelName.NICKNAME) );
			dispatcher(new ValueObject( 4092,modelName.UUID) );
			dispatcher(new ValueObject( 500,modelName.CREDIT) );			
			dispatcher(new ValueObject(  10,modelName.REMAIN_TIME) );						
			dispatcher(new ValueObject(  3, modelName.GAMES_STATE) );						
            dispatcher( new ValueObject( [], modelName.PLAYER_POKER) );
            dispatcher( new ValueObject( [], modelName.BANKER_POKER) );
			
			dispatcher(new Intobject(modelName.Bet, ViewCommand.SWITCH) );			
		}
		
		public function updata_state_info(state:int):void
		{
			dispatcher(new ValueObject(  state, modelName.GAMES_STATE) );
			dispatcher(new ValueObject(  1,modelName.REMAIN_TIME) );
			dispatcher(new ModelEvent("update_remain_time"));
		}
		
		public function deal_card(card_type:int ,card:Array):void
		{
			if ( card_type == CardType.PLAYER)
			{
				dispatcher( new ValueObject( card, modelName.PLAYER_POKER) );
				dispatcher(new ModelEvent("playerpoker"));
			}
			else if ( card_type == CardType.BANKER)
			{							
			    dispatcher( new ValueObject(card, modelName.BANKER_POKER) );
				dispatcher(new ModelEvent("bankerpoker"));
			}
		}
		
		public function fake_result(bet_amount:int,settle_amount:int,credit:int ,bet_type:int):void
		{
			dispatcher( new ValueObject(bet_amount,modelName.BET_AMOUNT));
			dispatcher( new ValueObject(settle_amount,modelName.SETTLE_AMOUNT));			
			dispatcher(new ValueObject( credit,modelName.CREDIT) );			
			dispatcher( new ValueObject(bet_type,modelName.ROUND_RESULT));
			dispatcher(new ModelEvent("round_result"));			
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="EnterView")]
		override public function EnterView (View:Intobject):void
		{
			if (View.Value != modelName.Bet) return;
			
			//清除前一畫面
			utilFun.Log("in to EnterBetview=");			
			
			//載入新VIEW		
			prepare("_view",utilFun.GetClassByString("BetSence") , this);
			
			var playerCon:MovieClip = prepare("playerpokerCon", new MovieClip() , this);
			playerCon.x = 480;
			playerCon.y = 240;			
			prepare(modelName.PLAYER_POKER, new MultiObject());
			
			var bankerCon:MovieClip = prepare("bankerpokerCon", new MovieClip() , this);
			bankerCon.x = 1100;
			bankerCon.y = 240;
			prepare(modelName.BANKER_POKER, new MultiObject());
			
			var riverCon:MovieClip = prepare("riverPokerCon", new MovieClip() , this);
			riverCon.x = 890;
			riverCon.y = 240;		
			prepare(modelName.RIVER_POKER, new MultiObject());
			
			var zoneCon:MovieClip = prepare("ZoneContainer", new MovieClip() , this);
			zoneCon.x = 610;
			
			//元件事件及畫面更新
			var zone:MultiObject = prepare("zone", new MultiObject() );
			zone.CustomizedFun = mypoker;
			zone.CustomizedData = ["閒","公牌","莊"];
			zone.Create(3, "finalPoint", 0 , 0, 3, 270, 0, "Bet_", zoneCon);
			
			addChild(_tool);
			
			var info:MovieClip = prepare(modelName.CREDIT, utilFun.GetClassByString("playerinfo") , this);			
			info.y = 830;
			utilFun.SetText(info["_Account"], _model.getValue(modelName.UUID) );
			utilFun.SetText(info["nickname"], _model.getValue(modelName.NICKNAME) );			
			utilFun.SetText(info["credit"], _model.getValue(modelName.CREDIT).toString());
			
		   var countDown:MovieClip = prepare(modelName.REMAIN_TIME, utilFun.GetClassByString("countDowntimer") , this);
			countDown.visible = false;
			countDown.x = 300;
			countDown.y = 400;
			
			var hintmsg:MovieClip = prepare(modelName.HINT_MSG, utilFun.GetClassByString("HintMsg") , this);
			hintmsg.visible = false;
			hintmsg.x = 850;
			hintmsg.y = 430;
					
			//bet區容器
			var coinzone:MovieClip = prepare("coinzone",  new MovieClip() , this);
			coinzone.x = 640;
			coinzone.y = 730;
			
			var coin:MovieClip = prepare("coin_1", utilFun.GetClassByString("coin_1") , coinzone);
			coin.gotoAndStop(3);
			_betcoin.MouseFrame = utilFun.Frametype(MouseBehavior.Customized,[0,0,3,0]);
			_betcoin.Create(coin );
			_betcoin.mousedown = coindown;
			
			
			var coin2:MovieClip = prepare("coin_2", utilFun.GetClassByString("coin_2") , coinzone);
			coin2.x = 130;			
			_betcoin2.MouseFrame = utilFun.Frametype(MouseBehavior.Customized,[0,0,3,0]);
			_betcoin2.Create(coin2 );
			_betcoin2.mousedown = coindown;
			//
			var coin3:MovieClip = prepare("coin_3", utilFun.GetClassByString("coin_3") , coinzone);
			coin3.x = 260;
			_betcoin3.MouseFrame = utilFun.Frametype(MouseBehavior.Customized,[0,0,3,0]);
			_betcoin3.Create(coin3 );
			_betcoin3.mousedown = coindown;
			//
			var coin4:MovieClip = prepare("coin_4", utilFun.GetClassByString("coin_4") , coinzone);
			coin4.x = 390;			
			_betcoin4.MouseFrame = utilFun.Frametype(MouseBehavior.Customized,[0,0,3,0]);
			_betcoin4.Create(coin4 );
			_betcoin4.mousedown = coindown;
			//
			var coin5:MovieClip = prepare("coin_5", utilFun.GetClassByString("coin_5") , coinzone);
			coin5.x = 520;			
			_betcoin5.MouseFrame = utilFun.Frametype(MouseBehavior.Customized,[0,0,3,0]);
			_betcoin5.Create(coin5 );
			_betcoin5.mousedown = coindown;
			
			//下注區容器
			var betzone:MovieClip = prepare("betzone",  new MovieClip() , this);
			betzone.x = 540;
			betzone.y = 490;
			
			var playerzone:MovieClip = prepare("playerbetzone",  utilFun.GetClassByString("playerZone") , betzone);
			prepare("playercoinstack",  utilFun.GetClassByString("Emptymc") , playerzone);
			var _playerzone:SingleObject = prepare("_playerzone", new SingleObject());
			_playerzone.MouseFrame = utilFun.Frametype(MouseBehavior.ClickBtn);
			_playerzone.mousedown = betTypePlayer;
			_playerzone.Create(playerzone );
			
			var bankzone:MovieClip = prepare("bankerbetzone",  utilFun.GetClassByString("bankerzone") , betzone);
			bankzone.x = 580;
			prepare("bankcoinstack",  utilFun.GetClassByString("Emptymc") , bankzone);			
			var _bankerzone:SingleObject = prepare("_bankerzone", new SingleObject());
			_bankerzone.MouseFrame = utilFun.Frametype(MouseBehavior.ClickBtn);
			_bankerzone.mousedown = betTypebanker;
			_bankerzone.Create(bankzone );
			
			
			var finacon:MovieClip = prepare("finalresultCon", new MovieClip() , this);
			finacon.x = 540;
			finacon.y = 160;
			
			prepare("finalresult", new MultiObject());
			
			update_remain_time();
		}
		
		public function newpoker(mc:MovieClip, idx:int, poker:Array):void
		{
			var strin:String =  poker[idx];
			var arr:Array = strin.match((/(\w|d)+(\w)+/));				
			var myidx:int = 0;
			if( arr.length != 0)
			{
				var numb:String = arr[1];
				var color:String = arr[2];					
				if ( color == "d") myidx = 1;
				if ( color == "h") myidx = 2;
				if ( color == "s") myidx = 3;
				if ( color == "c") myidx = 4;
				
				if ( numb == "i") myidx += (9*4);
				else if ( numb == "j") myidx += (10*4);
				else if ( numb == "q") myidx += (11*4);
				else if ( numb == "k") myidx += (12*4);
				else 	myidx +=  (parseInt(numb)-1)*4;					
			}
			utilFun.scaleXY(mc, 0.8, 0.8);
			mc.gotoAndStop(myidx);
		}	
		
		public function coindown(e:Event):Boolean
		{
			var s:String = utilFun.Regex_CutPatten(e.currentTarget.name, new RegExp("coin_", "i"));
			
			for (var i:int = 1; i < 6; i++)
			{
				if ( i == parseInt(s)) continue;				
				else Get("coin_"+(i)).gotoAndStop(1);
			}			
			_BetModel._selectIdx = parseInt(s) - 1;
			
			return true;
		}		
		
		public function betTypePlayer(e:Event):Boolean
		{			
			//擋狀態
			if ( _model.getValue(modelName.GAMES_STATE)  != gameState.NEW_ROUND )
			{				
				return false;
			}
			
			_BetModel._BetType = CardType.BET_PLAYER;			
			_BetModel.bet();
			dispatcher( new WebSoketInternalMsg(WebSoketInternalMsg.BET));
			
			return true;
		}		
		
		public function betTypebanker(e:Event):Boolean
		{
			//擋狀態
			if ( _model.getValue(modelName.GAMES_STATE)  != gameState.NEW_ROUND )
			{				
				return false;
			}
			
			_BetModel._BetType = CardType.BET_BANKER;
			_BetModel.bet();
			dispatcher( new WebSoketInternalMsg(WebSoketInternalMsg.BET));
			return true;
		}
		
		public function mypoker(mc:MovieClip, idx:int, poker:Array):void
		{
			if ( idx == 2) mc.x += 50;
			utilFun.SetText(mc["_Text"],poker[idx])
		}
		
		[MessageHandler(type= "Model.ModelEvent",selector = "playerpoker")]
		public function playerpokerupdate():void
		{
			var playerpoker:Array =   _model.getValue(modelName.PLAYER_POKER);
			var pokerlist:MultiObject = Get(modelName.PLAYER_POKER)
			pokerlist.CleanList();			
			pokerlist.CustomizedFun = newpoker;
			pokerlist.CustomizedData = playerpoker;
			pokerlist.Create(playerpoker.length, "poker", 0 , 0, playerpoker.length, 163, 123, "Bet_", Get("playerpokerCon"));
			
		}
		
		[MessageHandler(type= "Model.ModelEvent",selector = "bankerpoker")]
		public function pokerupdate():void
		{
			var bankerpoker:Array =   _model.getValue(modelName.BANKER_POKER);
			var pokerlist:MultiObject = Get(modelName.BANKER_POKER)
			pokerlist.CleanList();
			pokerlist.CustomizedFun = newpoker;
			pokerlist.CustomizedData =  bankerpoker;
			pokerlist.Create(bankerpoker.length,"poker", 0 , 0, bankerpoker.length, 163, 123, "Bet_", Get("bankerpokerCon"));		
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "round_result")]
		public function round_result():void
		{
			var betresult:int = _model.getValue(modelName.ROUND_RESULT);
			var x:int = 0;
			var result:MovieClip = _localDI.getValue(modelName.ROUND_RESULT);
			if ( betresult== CardType.PLAYER) 
			{		     
			   utilFun.SetText(result["_Text"], "閒贏 1賠1");
			   x = _localDI.getValue(modelName.PLAYER_POKER).x
		    }
			else if (betresult == CardType.BANKER) 
			{
				utilFun.SetText(result["_Text"], "莊贏 1賠1.95");	
				x = _localDI.getValue(modelName.BANKER_POKER).x
			}
			else
			{
				utilFun.SetText(result["_Text"], "和 1賠8");
				x = (_localDI.getValue(modelName.PLAYER_POKER).x + _localDI.getValue(modelName.BANKER_POKER).x) / 2;
			}
			result.x = x;
			
		
			
			//updateCredit();
			//採用這種方式,呼叫與事件,包成control?
			utilFun.SetText(Get(modelName.CREDIT)["credit"],_model.getValue(modelName.CREDIT).toString());
			
			//updateCredit();
			
			dispatcher(new BoolObject(true, "Msgqueue"));
			Tweener.addCaller(this, { time:4 , count: 1, onUpdate: this.clearn } );
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "updateCredit")]
		public function updateCredit():void
		{			
			utilFun.SetText(_localDI.getValue(modelName.CREDIT)["_Text"], "credit =" + _BetModel.creditDisplay().toString());
			
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "update_remain_time")]
		public function update_remain_time():void
		{						
			var state:int = _model.getValue(modelName.GAMES_STATE);
			if ( state  == gameState.NEW_ROUND)
			{
				Get(modelName.REMAIN_TIME).visible = true;
				var time:int = _model.getValue(modelName.REMAIN_TIME);
				utilFun.SetText(Get(modelName.REMAIN_TIME)["_Text"], utilFun.Format(time, 2));
				Tweener.addCaller(this, { time:time , count: time, onUpdate:TimeCount , transition:"linear" } );	
				
				Tweener.addTween(Get(modelName.HINT_MSG), { alpha:1, time:2, onComplete:FadeIn } );
				Get(modelName.HINT_MSG).visible = true;
				Get(modelName.HINT_MSG).gotoAndStop(1);
				Get(modelName.HINT_MSG).alpha = 0;
			}
			else if ( state == gameState.END_BET)
			{
				Get(modelName.REMAIN_TIME).visible = false;
					
				Get(modelName.HINT_MSG).alpha = 0;
				Get(modelName.HINT_MSG).gotoAndStop(2);				
				Tweener.addTween(Get(modelName.HINT_MSG), { alpha:1, time:2, onComplete:FadeIn } );
			}
			else if ( state == gameState.START_OPEN)
			{
				
			}
			else if ( state == gameState.END_ROUND)
			{
				//utilFun.SetText(_CountDown["_Text"], "開牌中 !");
			}
		}		
		
	
		
		private function TimeCount():void
		{
			var time:int  = _opration.operator(modelName.REMAIN_TIME, DataOperation.sub);
			if ( time < 0) 
			{
				Get(modelName.REMAIN_TIME).visible = false;
				return;
			}
			
			utilFun.SetText(Get(modelName.REMAIN_TIME)["_Text"], utilFun.Format(time, 2));			
		}
		
		private function clearn():void
		{
			_BetModel.cleran();
			Get(modelName.PLAYER_POKER).CleanList();
			Get(modelName.BANKER_POKER).CleanList();
			Get("finalresult").CleanList();
			
			utilFun.ClearContainerChildren( Get("playercoinstack"));
			utilFun.ClearContainerChildren( Get("bankcoinstack"));
			
			dispatcher(new BoolObject(false, "Msgqueue"));
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="LeaveView")]
		override public function ExitView(View:Intobject):void
		{
			if (View.Value != modelName.Bet) return;
			super.ExitView(View);
		}		
	}

}