package Model 
{	
	import util.utilFun;
	
	/**
	 * queue user action ,when server comfirm, pop out to excution
	 * @author hhg4092
	 */
	public class ActionQueue
	{
		private var _queue:Array = [];
		
		public function ActionQueue() 
		{
			
		}
		
		
		[MessageHandler(type = "Model.ActionEvent")]
		public function push(msg:ActionEvent):void
		{			
		   	_queue.push(msg.Value);
		}
		
		
		public function getMsg():Object
		{
			var msg:Object = _queue[0]
			_queue.shift();				
			return msg;
		}
		
	}

}