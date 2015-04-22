package Model 
{
	
	/**
	 * 翻頁式資料模型
	 * @author hhg4092
	 */
	public class PageSlipModel 
	{
		//物品列表
		private var _ItemList:Array = [];
		
		//一頁的數量
		private var _PageAmount:int ;
		
		//本頁開始索引
		private var _ItemPageIdx:int ;
		
		public function PageSlipModel() 
		{
			
		}
		
		public function pageSetting(ItemList:Array ,PageAmount:int):void
		{
			_ItemList = ItemList;
			_PageAmount = PageAmount;
			_ItemPageIdx = 0;
		}
		
		public function CurrentPage(Delimiter:String):String
		{			
			var ItemLenth:int = _ItemList.length;
			
			var Denominator:int = ItemLenth / _PageAmount;
			var Remainder:int = ( ItemLenth % _PageAmount ) > 0 ? 1: 0;
			Denominator += Remainder;
			var molecule:int = (_ItemPageIdx / _PageAmount) +1;
			return  molecule.toString() + Delimiter +  Denominator.toString();
		}
		
		public function NextPage():void
		{
			var ItemLenth:int = _ItemList.length;
			
			if ( _ItemPageIdx < ItemLenth)
			{
				_ItemPageIdx += _PageAmount;
				if ( _ItemPageIdx >= ItemLenth)
				{
					_ItemPageIdx -= _PageAmount;
				}
			}			
		}
		
		public function PrePage():void
		{			
			var ItemLenth:int  = _ItemList.length;
			
			if ( _ItemPageIdx > 0 )
			{
				_ItemPageIdx -= _PageAmount;
			}			
		}		
		
		public function  GetPageDate():Array
		{
			var EndIdx:int = _ItemList.length - _ItemPageIdx;
			return _ItemList.slice(_ItemPageIdx, _ItemPageIdx+ Math.min(EndIdx,_PageAmount) );
		}
		
		public function  GetPageItem(idx:int):*
		{			
			if ( idx >= _PageAmount ) return null;
			if ( idx < 0 ) return null;
			
			return _ItemList[(_ItemPageIdx+idx)];
		}
	}

}