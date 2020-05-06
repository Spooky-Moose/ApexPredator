package lib {

	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.*;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.media.Video;

	public class MenuDoc extends MovieClip {

		private var count: int = 0;
		private var menu: MainMenu;
		private var cMenu: controlScreen;
		private var game: Game;
		private var Skip: MovieClip = new skippyboi();
		
		private var conn: NetConnection;
		private var stream: NetStream;
		private var vid: Video;
		private var playVid: VidPlayer;

		public function MenuDoc() {
			// constructor code
			stage.align = StageAlign.TOP_LEFT;
			createStartMenu();
		}

		private function createStartMenu(): void {
			menu = new MainMenu();
			trace("Menu");
			addChild(menu);
			menu.start_btn.addEventListener(MouseEvent.CLICK, startHandler);
			menu.control_btn.addEventListener(MouseEvent.CLICK, startControl);
		}

		private function startControl(evt: MouseEvent): void {
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startControl);
			cMenu = new controlScreen();
			trace("this works")
			addChild(cMenu);
			cMenu.exit_btn.addEventListener(MouseEvent.CLICK, controlHandler);
		}

		private function controlHandler(evt: MouseEvent): void {
			removeChild(cMenu);
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, controlHandler);
			menu.control_btn.addEventListener(MouseEvent.CLICK, startControl);
		}

		private function startHandler(evt: MouseEvent): void {
			TweenLite.to(menu, 1, {alpha: 0});
			count = 0;
			addEventListener(Event.ENTER_FRAME, delay);
		}

		private function delay(evt: Event) {
			count++;
			if (count == 5) {
				//createGame();
				intro();
				addChild(Skip);
				Skip.x= 1200;
				Skip.y= 750;
				Skip.addEventListener(MouseEvent.CLICK, SkipIntro);
				
			}
			if (count == 30) {
				removeChild(menu);
			}
			if(count == 935){
				removeEventListener(Event.ENTER_FRAME, delay);
				removeChild(playVid);
				createGame();
			}
		}
		
		private function SkipIntro(evt:MouseEvent):void{
			Skip.removeEventListener(MouseEvent.CLICK, SkipIntro);
			removeEventListener(Event.ENTER_FRAME, delay);
			createGame();
		}

		private function intro() {
			playVid = new VidPlayer(conn, stream, vid, "Intro.mp4");
			playVid.alpha = 0;
			TweenLite.to(playVid, 1, {alpha: 1});
			addChild(playVid);
		}

		private function createGame(): void {
			game = new Game();
			game.alpha = 0;
			addChild(game);
			TweenLite.to(game, 1, {alpha: 1});
			addEventListener(Event.ENTER_FRAME,endGame);
		}
		
		private function endGame(evt: Event) {
			if(game.dead){
				removeEventListener(Event.ENTER_FRAME,endGame);
				removeChild(game);
				createStartMenu();
			}
		}

	}

}