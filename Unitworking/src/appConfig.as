package  
{
	import com.hexagonstar.util.debug.Debug;
	import Command.BetCommand;
	import Command.DataOperation;
	import Command.RegularSetting;
	import Command.ViewCommand;
	import flash.display.MovieClip;
	import Model.ActionQueue;
	import Model.Model;
	import Model.MsgQueue;	
	import org.spicefactory.parsley.core.registry.ObjectDefinition;
	import View.ViewBase.ViewBase;
	import ConnectModule.websocket.WebSoketComponent;
	
	import View.GameView.*;
	/**
	 * ...
	 * @author hhg
	 */
	public class appConfig 
	{
		//要unit test 就切enter來達成
		
		//singleton="false"
		[ObjectDefinition(id="Enter")]
		public var _LoadingView:LoadingView = new LoadingView();		
		public var _Lobby:Lobby = new Lobby();
		public var _hud:HudView = new HudView();		
		public var _bet:betView = new betView();
		
		
		//model
		public var _MsgModel:MsgQueue = new MsgQueue();		
		public var _model:Model = new Model();
		public var _Actionmodel:ActionQueue = new ActionQueue();
		
		
		//connect module
		public var _socket:WebSoketComponent = new WebSoketComponent();
		public var _dataoperation:DataOperation = new DataOperation();
		public var _viewcom:ViewCommand = new ViewCommand();
		public var _betcom:BetCommand = new BetCommand();
		public var _regular:RegularSetting = new RegularSetting();
		
		//[ProcessSuperclass]
		//public var _vibase:ViewBase = new ViewBase();
		
		
		public function appConfig() 
		{
			Debug.trace("my init");
		}
	
	}

}