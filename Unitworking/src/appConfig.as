package  
{
	import com.hexagonstar.util.debug.Debug;
	import Command.DataOperation;
	import Command.ViewCommand;
	import flash.display.MovieClip;
	import Model.BetModel;
	import Model.Model;
	import Model.MsgQueueModel;
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
		
		public var _LoadingView:LoadingView = new LoadingView();		
		public var _Lobby:Lobby = new Lobby();
		public var _hud:HudView = new HudView();
		
		[ObjectDefinition(id="Enter")]
		public var _bet:betView = new betView();
		
		
		//model
		public var _MsgModel:MsgQueueModel = new MsgQueueModel();
		public var _betmodel:BetModel = new BetModel();
		public var _model:Model = new Model();
		
		//connect module
		public var _socket:WebSoketComponent = new WebSoketComponent();
		public var _dataoperation:DataOperation = new DataOperation();
		public var _viewcom:ViewCommand = new ViewCommand();
		
		//[ProcessSuperclass]
		//public var _vibase:ViewBase = new ViewBase();
		
		
		public function appConfig() 
		{
			Debug.trace("my init");
		}
	
	}

}