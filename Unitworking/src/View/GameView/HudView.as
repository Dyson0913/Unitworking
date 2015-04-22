package View.GameView
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import Model.valueObject.Intobject;
	import View.ViewBase.ViewBase;
	import Model.modelName;
	import util.utilFun;
	
	/**
	 * ...
	 * @author hhg
	 */
	public class HudView extends ViewBase
	{
		
		public var _TopBar:MovieClip;
		public var _DownBar:MovieClip;
		
		public function HudView()  
		{
			utilFun.Log("HudView");
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="EnterView")]
		override public function EnterView (View:Intobject):void
		{
			if (View.Value != modelName.Hud) return;
			utilFun.Log("hud enter");
			
			_TopBar = utilFun.GetClassByString("TopBar");
			_DownBar  = utilFun.GetClassByString("ButtonBar");
			
			addChild( _TopBar);
			addChild( _DownBar );
			
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="LeaveView")]
		override public function ExitView(View:Intobject):void
		{
			if (View.Value != modelName.Hud) return;
			utilFun.Log("hud exit ");
		}
		
		
	}

}