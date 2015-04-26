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
		
		[Embed(source='../../assets/poker.png')]
		private var sheetClass:Class;
		private var sheet:Bitmap = new sheetClass();
		
		public var zone:MultiObject = new MultiObject();
		public var betbtn:MultiObject = new MultiObject();
		public var betType:MultiObject = new MultiObject();
		public var betlist:MultiObject = new MultiObject();
		public var p_poker:MultiObject = new MultiObject();
		public var b_poker:MultiObject = new MultiObject();
		
		private var _localDI:DI = new DI();
		
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
			_View = new MovieClip(); // utilFun.GetClassByString("BetView");
			addChild(_View);
			
			var playerCon:MovieClip = utilFun.prepare(modelName.PLAYER_POKER, new MovieClip() , _localDI, this);
			playerCon.x = 500;
			playerCon.y = 100;
			
			var bankerCon:MovieClip = utilFun.prepare(modelName.BANKER_POKER, new MovieClip() , _localDI, this);
			bankerCon.x = 300;
			bankerCon.y = 100;
			
			var betlistCon:MovieClip = utilFun.prepare("betlistContainer", new MovieClip() , _localDI, this);
			betlistCon.x = 0;
			betlistCon.y = 100;			
			
			betlist.CustomizedFun = mypoker;
			betlist.CustomizedData = [""];
			betlist.MouseFrame = utilFun.Frametype(MouseBehavior.ClickBtn);			
			betlist.Create(1, "MyText", 0 , 0, 1, 10, 20, "Bet_", betlistCon);
			
			var zoneCon:MovieClip = utilFun.prepare("ZoneContainer", new MovieClip() , _localDI, this);
			zoneCon.x = 300;
			
			zone.CustomizedFun = mypoker;
			zone.CustomizedData = ["莊","閒"];
			zone.Create(2, "OrderBtn", 0 , 0, 3, 200, 0, "Bet_", zoneCon);
				
			var result:MovieClip = utilFun.prepare(modelName.ROUND_RESULT, utilFun.GetClassByString("MyText"), _localDI, this);			
			utilFun.SetText(result["_Text"], "");				
			result.y = 300;
			
			var betamount:MovieClip = utilFun.prepare(modelName.BET_AMOUNT, utilFun.GetClassByString("MyText"), _localDI, this);			
			betamount.y = 200;
			utilFun.SetText(betamount["_Text"], "" );
			
			var settleamount:MovieClip = utilFun.prepare(modelName.SETTLE_AMOUNT, utilFun.GetClassByString("MyText"), _localDI, this);			
			settleamount.y = 250;			
			utilFun.SetText(settleamount["_Text"], "" );
			
			
			//元件事件及畫面更新
			var credit:MovieClip = utilFun.prepare(modelName.CREDIT, utilFun.GetClassByString("MyText") , _localDI, this);
			credit.x = 0
			credit.y = 50
			updateCredit();
			
			var countDown:MovieClip = utilFun.prepare(modelName.REMAIN_TIME, utilFun.GetClassByString("MyText") , _localDI, this);			
			utilFun.SetText(countDown["_Text"], "");	
			
			//押注按鈕
			betbtn.CustomizedFun = mypoker;
			betbtn.CustomizedData = ["10", "100", "1K", "5K", "10K"];
			betbtn.MouseFrame = utilFun.Frametype(MouseBehavior.ClickBtn);
			betbtn.Create(5, "OrderBtn", 0 ,500, 5, 170, 0, "Bet_", _View);
			betbtn.mousedown = Betdown
			
			betType = new MultiObject();
			betType.CustomizedFun = mypoker;
			betType.CustomizedData = ["押閒", "押莊"];
			betType.MouseFrame = utilFun.Frametype(MouseBehavior.ClickBtn);
			betType.Create(2, "OrderBtn", 0,400, 2, 170, 0, "Bet_", _View);
			betType.mousedown = plaerType
			
			update_remain_time();
		}
		
		public function newpoker(mc:*, idx:int, poker:Array):void
		{
			if ( mc is SpriteSheet)
			{
				var p:SpriteSheet = mc as SpriteSheet;				
				//var arr:Array = utilFun.Regex_Match("jc", new RegExp(/(\w|d)+(\w)+/, "i"));
				
				var strin:String =  poker[idx];
				var arr:Array = strin.match((/(\w|d)+(\w)+/));				
				var myidx:int = 0;
				if( arr.length != 0)
				{
					var numb:String = arr[1];
					var color:String = arr[2];					
					if ( color == "c") myidx = 0;
					if ( color == "d") myidx = 13;
					if ( color == "h") myidx = 26;
					if ( color == "s") myidx = 39;
					
					if ( numb == "i") myidx += 10;
					else if ( numb == "j") myidx += 11;
					else if ( numb == "q") myidx += 12;
					else if ( numb == "k") myidx += 13;
					else 	myidx += parseInt(numb) ;	
					myidx -= 1;
				}
			    p.drawTile(myidx);
			}
		}	
		
		public function Betdown(e:Event,idx:int):Boolean
		{
			//擋狀態
			if ( _model.getValue(modelName.GAMES_STATE)  >= gameState.END_BET)
			{				
				return false;
			}
			_BetModel.bet(idx);
			//_BetModel._selectIdx = idx;		
			dispatcher( new WebSoketInternalMsg(WebSoketInternalMsg.BET));
			
			
			betlist.CleanList();
			betlist.CustomizedFun = betshow;
			betlist.CustomizedData = [ _BetModel._BetTypeList, _BetModel._BetTypeAmount];
			betlist.MouseFrame = utilFun.Frametype(MouseBehavior.ClickBtn);
			betlist.Create( _BetModel._BetTypeList.length, "MyText", 0 , 0, 1, 0, 50, "Bet_",  _localDI.getValue("betlistContainer"));
			
			return true;
		}
		
		public function plaerType(e:Event,idx:int):Boolean
		{
			//擋狀態
			if ( _model.getValue(modelName.GAMES_STATE)  >= gameState.END_BET)
			{				
				return false;
			}
			
			if( idx == 0)_BetModel._BetType = CardType.PLAYER;
			else _BetModel._BetType = CardType.BANKER;
			
			return true;
		}	
		
		public function betshow(mc:MovieClip, idx:int, betlist:Array):void
		{		
			var bettype:Array = betlist[0];
			var amount:Array = betlist [1];
				if (bettype[idx] == 1)
				{
					utilFun.SetText(mc["_Text"], "押閒 " + amount[idx])					
				}
				else
				{
					utilFun.SetText(mc["_Text"],"押莊 "+ amount[idx])
				}
		}
		
		public function mypoker(mc:MovieClip, idx:int, poker:Array):void
		{			
			utilFun.SetText(mc["_Text"],poker[idx])
		}
		
		[MessageHandler(type= "Model.ModelEvent",selector = "playerpoker")]
		public function playerpokerupdate():void
		{
			var playerpoker:Array =   _model.getValue(modelName.PLAYER_POKER);
			p_poker.CleanList();			
			p_poker.CustomizedFun = newpoker;
			p_poker.CustomizedData =  playerpoker;
			p_poker.CreateByObject(playerpoker.length, sheet, 0 , 0, playerpoker.length, 20, 123, "Bet_", _localDI.getValue(modelName.PLAYER_POKER));
			
		}
		
		[MessageHandler(type= "Model.ModelEvent",selector = "bankerpoker")]
		public function pokerupdate():void
		{
			var bankerpoker:Array =   _model.getValue(modelName.BANKER_POKER);
			b_poker.CleanList();
			b_poker.CustomizedFun = newpoker;
			b_poker.CustomizedData =  bankerpoker;
			b_poker.CreateByObject(bankerpoker.length, sheet, 0 , 0, bankerpoker.length, 20, 123, "Bet_", _localDI.getValue(modelName.BANKER_POKER));
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
			
			utilFun.SetText( _localDI.getValue(modelName.BET_AMOUNT)["_Text"], "總押注: " + _model.getValue(modelName.BET_AMOUNT) );
			utilFun.SetText( _localDI.getValue(modelName.SETTLE_AMOUNT)["_Text"], "總輸贏: " + _model.getValue(modelName.SETTLE_AMOUNT) );
			
			//採用這種方式,呼叫與事件,包成control?
			utilFun.SetText(_localDI.getValue(modelName.CREDIT)["_Text"], "credit =" + _model.getValue(modelName.CREDIT).toString());
			
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
				var time:int = _model.getValue(modelName.REMAIN_TIME);
				utilFun.SetText(_localDI.getValue(modelName.REMAIN_TIME)["_Text"], "請開始押注 : " + time);
				
			   Tweener.addCaller(this, { time:time , count: time, onUpdate:TimeCount , transition:"linear" } );	
			}
			else if ( state == gameState.END_BET)
			{
				utilFun.SetText(_localDI.getValue(modelName.REMAIN_TIME)["_Text"], "請停止押注 !");
				Tweener.addCaller(this, { time:1 , count: 1, onComplete:StartBet , transition:"linear" } );	
			}
			else if ( state == gameState.START_OPEN)
			{
				StartBet();
			}
			else if ( state == gameState.END_ROUND)
			{
				//utilFun.SetText(_CountDown["_Text"], "開牌中 !");
			}
		}		
		
		private function StartBet():void
		{
			utilFun.SetText(_localDI.getValue(modelName.REMAIN_TIME)["_Text"], "開牌中 !");
		}
		
		private function TimeCount():void
		{
			var time:int  = _opration.operator(modelName.REMAIN_TIME, DataOperation.sub);
			if ( time < 0) 
			{
				return;
			}
			utilFun.SetText(_localDI.getValue(modelName.REMAIN_TIME)["_Text"], "請開始押注 : " + time);			
		}
		
		private function clearn():void
		{
			_BetModel.cleran();
			betlist.CleanList();
			p_poker.CleanList();
			b_poker.CleanList();
			
			utilFun.SetText( _localDI.getValue(modelName.BET_AMOUNT)["_Text"],"" );
			utilFun.SetText( _localDI.getValue(modelName.SETTLE_AMOUNT)["_Text"],"" );
			utilFun.SetText( _localDI.getValue(modelName.ROUND_RESULT)["_Text"], "" );
			
			//_BetModel.accept_bet();
			dispatcher(new BoolObject(false, "Msgqueue"));
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="LeaveView")]
		override public function ExitView(View:Intobject):void
		{
			if (View.Value != modelName.Bet) return;
			_localDI.clean()
		}		
	}

}