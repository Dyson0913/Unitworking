package  
{
	import com.hexagonstar.util.debug.Debug;
	import flash.display.MovieClip;
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
		[ObjectDefinition(id="Enter")]
		public var _LoadingView:LoadingView = new LoadingView();
		public var _Lobby:Lobby = new Lobby();
		
		//model
		public var _MsgModel:MsgQueueModel = new MsgQueueModel();
		public var _model:Model = new Model();
		
		//connect module
		public var _socket:WebSoketComponent = new WebSoketComponent();
		
		//[ProcessSuperclass]
		//public var _vibase:ViewBase = new ViewBase();
		
		
		public function appConfig() 
		{
			Debug.trace("my init");
		}
	
	}

}