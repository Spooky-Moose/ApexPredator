package lib {
	
	import flash.display.Sprite;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.media.Video;
	import flash.events.AsyncErrorEvent;
	
	public class VidPlayer extends Sprite{

		public function VidPlayer(nc:NetConnection,ns:NetStream,vid:Video,flick:String) {
			// constructor code
			nc = new NetConnection();
			nc.connect(null);
			ns = new NetStream(nc);
			ns.client = new Object();
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncErrorHandler);
			
			vid = new Video();
			vid.width = 1920;
			vid.height = 1080;
			vid.attachNetStream(ns);
			ns.play(flick);
			addChild(vid);
		}
		
		private function asyncErrorHandler(evt:AsyncErrorEvent):void{
			trace("asyncError");
		}

	}
	
}
