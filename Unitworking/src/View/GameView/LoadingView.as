package View.GameView
{
	import Command.ViewCommand;
	import ConnectModule.websocket.WebSoketInternalMsg;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Model.*
	import Model.valueObject.StringObject;
	
	import Model.valueObject.Intobject;
	import View.Viewutil.MultiObject;
	import View.ViewBase.ViewBase;
	import util.utilFun;
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author hhg
	 */
	
	public class LoadingView extends ViewBase
	{
		public function LoadingView()
		{
		
		}
		
		public function FirstLoad():void
		{
			dispatcher(new Intobject(modelName.Loading, ViewCommand.SWITCH));
		}
		
		[MessageHandler(type="Model.valueObject.Intobject",selector="EnterView")]
		
		override public function EnterView(View:Intobject):void
		{
			if (View.Value != modelName.Loading)
				return;
			
			prepare("_view", utilFun.GetClassByString("LoadingSence"), this);
			utilFun.SetTime(connet, 2);
		}
		
		public function connet():void
		{
			dispatcher(new WebSoketInternalMsg(WebSoketInternalMsg.CONNECT));
		}
		
		[MessageHandler(type="Model.valueObject.Intobject",selector="LeaveView")]
		
		override public function ExitView(View:Intobject):void
		{
			if (View.Value != modelName.Loading)
				return;
			super.ExitView(View);
			utilFun.Log("LoadingView ExitView");
		}
	
	}

}