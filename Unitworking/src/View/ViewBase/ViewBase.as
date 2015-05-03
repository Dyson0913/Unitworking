package View.ViewBase
{
	import Command.DataOperation;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import Model.Model;
	import util.DI;
	import util.utilFun;
	import View.GameView.ViewState;
	import View.Viewutil.AdjustTool;
	
	/**
	 * ...
	 * @author hhg
	 */
	
	
	//[ProcessSuperclass][ProcessInterfaces]
	public class ViewBase extends Sprite
	{
		[MessageDispatcher]
        public var dispatcher:Function;
		
		[Inject]
		public var _model:Model;
		
		[Inject]
		public var _opration:DataOperation;		
		
		public var _tool:AdjustTool;
		
		public var _ViewDI:DI;
		
		public function ViewBase() 
		{
			_ViewDI = new DI();
		}
		
		//[MessageHandler]
		public function EnterView (View:int):void
		{
			
		}
		
		
		public function ExitView(View:int):void
		{
			utilFun.ClearContainerChildren(Get("_view"));			
			_ViewDI.clean();
		}
		
		protected function Get(name:*):*
		{
			return _ViewDI.getValue(name);
		}
		
		protected function prepare(name:*, ob:*, container:DisplayObjectContainer = null):*
		{
			return utilFun.prepare(name,ob , _ViewDI, container);
		}
		
	}

}