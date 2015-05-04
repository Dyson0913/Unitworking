package Model 
{	
	import util.utilFun;
	import Model.*;
	/**
	 * ...
	 * @author hhg4092
	 */
	public class BetModel 
	{
		
		[Inject]
		public var _model:Model;		
		
		public var _TotalBet:Number = 0;
		
		//bacarat model
		public var BetList:Array = [100, 500, 1000, 5000, 10000];
		public var _selectIdx:int = 0;
		
		public var _Betcredit:int = 0;
		public var _BetType:int = 0;
		public var _BetTypeList:Array = [];
		public var _BetTypeAmount:Array = [];
		public var _BeteachAmount:Array = [];
		
		public function BetModel() 
		{
			
		}		
		
		public function cleran():void
		{
			_BetTypeAmount.length = 0;
			_BetTypeList.length = 0;
			_BeteachAmount.length = 0;
		}
		
		public function bet():void
		{			
			var typeidx:int = _BetTypeList.indexOf(_BetType);			
			if (  typeidx == -1)
			{
				_BetTypeList.push(_BetType);
				_BetTypeAmount.push(BetList[_selectIdx]);
				_BeteachAmount.push([BetList[_selectIdx]]);
				typeidx = _BetTypeList.length-1;
			}
			else
			{				
				_BetTypeAmount[typeidx] += BetList[_selectIdx];
				_BeteachAmount[typeidx].push(BetList[_selectIdx]);
				//var arr:Array = _BeteachAmount[typeidx];
				//utilFun.Log("typeidx = "+typeidx);
				//utilFun.Log("_BeteachAmount[typeidx] = "+_BeteachAmount[typeidx]);
				//arr.push(BetList[_selectIdx]);
				
				
			}
			
			_Betcredit = _BetTypeAmount[typeidx];
		}
		
		[MessageHandler(type="ConnectModule.websocket.WebSoketInternalMsg",selector="Betresult")]
		public function accept_bet():void
		{
			_TotalBet = 0;
			for (var i:int = 0; i < _BetTypeAmount.length; i++)
			{
				_TotalBet += _BetTypeAmount[i];
			}
		}
		
		
		
		public function creditDisplay():Number
		{
			var credit:int = _model.getValue(modelName.CREDIT);
			return credit - _TotalBet;
		}
		
	}
	
	

}