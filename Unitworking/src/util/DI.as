package util 
{
	import flash.utils.Dictionary;
	/**
	 * DI
	 * @author hhg
	 */
	public class DI 
	{
		private var _dic:Dictionary = new Dictionary();
		
		public function DI() 
		{
			
		}
		
		public function putValue(name:*,ob:*):void
		{
			_dic[name] = ob;
		}
		
		public function getValue(name:*):*
		{
			if (_dic[name] != null)
			{
				return _dic[name];
			}
			return null;
		}
		
	}

}