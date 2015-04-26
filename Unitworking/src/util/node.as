package util 
{
	import flash.display.MovieClip;
	/**
	 * node for linkobject
	 * @author hhg
	 */
	public class node 
	{
		private var _Container:MovieClip;
		
		private var _item:MovieClip;
		
		private var _next:node;
		
		public function set next(value:node):void
		{
		    _next = value;
		}
		
		public function get next():node
		{
		    return _next;
		}
		
		
		public function node() 
		{
			_next = null;
		}
		
		public function create(item:MovieClip, contain:MovieClip):void
		{
			_item = item;
			_Container = contain;
		}
		
	}

}