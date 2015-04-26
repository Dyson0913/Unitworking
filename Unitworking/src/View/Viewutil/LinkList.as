package View.Viewutil 
{
	import util.node;
	/**
	 * ...
	 * @author hhg
	 */
	public class LinkList 
	{
		private var _head:node;
		private var _tial:node
		
		public function get head():node
		{
		    return _head;
		}
		
		public function get tail():node
		{
		    return _tial;
		}
		
		public function LinkList() 
		{
			_head = null;
			_tial = null;
		}
		
		public function setroot(nod:node):void
		{
			_head = nod;
			_tial = nod;
		}
		
		public function addtail(nod:node):void
		{
			_tial.next = nod;
			_tial = nod;
		}
		
		public function removehead():void
		{
			var _pre:node = _head;
			_head = _head.next;
			_pre.next = null;
			_pre = null;
		}
		
	}

}