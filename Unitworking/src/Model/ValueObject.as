package Model 
{
	import util.utilFun;
	/**
	 * valueObject 
	 * @author hhg
	 */
	public class ValueObject 
	{
		public var Value:*;
		
		[Selector]
		public var selector:String
		
		public function ValueObject(ob:*,selec:String) 
		{
			Value = ob;
			selector = selec;
		}
		
	}

}