package View.GameView
{	
	import ConnectModule.websocket.WebSoketInternalMsg;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Model.*	
	
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
			dispatcher(new ViewState(ViewState.Loading, ViewState.ENTER) );
		}
		
		[MessageHandler(selector="Enter")]
		override public function EnterView (View:ViewState):void
		{
			if (View._view != ViewState.Loading) return;
			
			_View = new MovieClip();
			addChild(_View);
			
			utilFun.SetTime(connet, 2);
		}
		
		public function connet():void
		{			
			dispatcher( new WebSoketInternalMsg(WebSoketInternalMsg.CONNECT));
		}
		
		[MessageHandler(selector="Leave")]
		override public function ExitView(View:ViewState):void
		{
			if (View._view != ViewState.Loading) return;
			utilFun.ClearContainerChildren(_View);
			utilFun.Log("LoadingView ExitView");
		}
		
		
	}

}