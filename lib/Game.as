package lib {

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import com.greensock.*;
	import flash.events.MouseEvent;

	public class Game extends MovieClip {

		private var stageScreen: GameStage = new GameStage();
		private var player: Player = new Player();
		private var statusHead: MovieClip = new statushead;
		private var scorebox: ScoreBox = new ScoreBox();
		private var escapeScreen: EscapeScreen = new EscapeScreen();
		private var capturedScreen: CapturedScreen = new CapturedScreen();
		private var endWin: MovieClip = new end_win;
		private var endLose: MovieClip = new end_lose;
		private var securityCam:SecurityCamera = new SecurityCamera();

		private var frame: Number = 0;
		private var frameCount: Number = 160;
		private var spacePressed: Number = 0;
		private var delay: Number = 1;
		public var dead: Boolean = false;

		private var enemyLayer: Sprite = new Sprite;
		private var guard: GuardAgent;
		private var scientist: ScientistAgent;
		private var guards: Array = new Array();
		private var scientists: Array = new Array();
		private var enemiesPurge: Array = new Array();

		public function Game() {
			// constructor code
			trace("Game");
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(evt: Event) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;

			addChild(stageScreen);
			addChild(securityCam);
			addChild(statusHead);
			addChild(scorebox);
			addChild(enemyLayer);
			addChild(player);
			stageScreen.bg.gotoAndStop(frame);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);

			statusHead.x = 50;
			statusHead.y = 50;

			scorebox.x = 860;
			scorebox.y = 30;
			scorebox.scoreTXT.text = "0";
		}

		
		
		private function changeScreen() {
			if (player.x > 1920) {
				frame++;
				if (frame == 8) frame = 4;
				if (frame != 1) {
					purgeGuard();
					purgeScientist();
				}
				guards = new Array();
				scientists = new Array();
				stageScreen.bg.gotoAndStop(frame);
				securityCam.x = Math.random() * 1500 + 210;
				securityCam.y = Math.random() * 300 + 50;
				player.x = 0;
				enemySpawn();
			}
		}

		private function menuHandler(evt: MouseEvent):void {
			dead = true;
		}
		
		
		
		private function onKeyDown(evt: KeyboardEvent) {
			player.movementGo(evt);
			player.special(evt, stageScreen.bg.cabinate);
		}

		private function onKeyUp(evt: KeyboardEvent) {
			player.movementStop();
		}
		
		private function smash(evt:KeyboardEvent){
			if(evt.keyCode == 32){
				spacePressed++;
				escapeScreen.gotoAndStop(2);
				delay = 3;
			}
		}
		
		private function capturedUpdate(evt:Event){
			frameCount++;
			delay--;
			if(delay == 0) escapeScreen.gotoAndStop(1);
			if(frameCount == 150){
				addEventListener(Event.ENTER_FRAME,onEnterFrame);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, smash);
				if(spacePressed >= 30){
					player.x = 100;
					player.captured = false;
					removeChild(escapeScreen);
				} else if(spacePressed < 35){
					capturedScreen.alpha = 0;
					TweenLite.to(capturedScreen, 1, {alpha: 1});
					addChild(capturedScreen);
					capturedScreen.containedExit.addEventListener(MouseEvent.CLICK, menuHandler);
					removeEventListener(Event.ENTER_FRAME,onEnterFrame);
				}
				removeEventListener(Event.ENTER_FRAME,capturedUpdate);
			}
		}
		
		private function babyCapture(){
			if(player.captured){
				removeEventListener(Event.ENTER_FRAME,onEnterFrame);
				addEventListener(Event.ENTER_FRAME,capturedUpdate);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, smash);
				addChild(escapeScreen);
				spacePressed = 0;
				frameCount = 0;
			}
		}
		
		private function playerStageChange(){
			if(stageScreen.bg.currentFrame == 4 && player.killCount == 0){
				player.playerStage = 2;
				player.gotoAndStop(player.playerStage);
			}
			if(player.killCount >= 10){
				player.playerStage = 3;
				player.gotoAndStop(player.playerStage);
			}
		}
		
		

		private function guardSpawn() {
			guard = new GuardAgent();
			if (player.playerStage == 1) guard.x = (Math.random() * (stage.stageWidth / 2)) + stage.stageWidth / 2;
			if (player.playerStage == 2) guard.x = (Math.random() * (stage.stageWidth * 0.6)) + stage.stageWidth / 3;
			if (player.playerStage == 3) guard.x = (Math.random() * (stage.stageWidth * 0.9)) + stage.stageWidth / 10;
			enemyLayer.addChild(guard);
			guards.push(guard);
		}

		private function scientistSpawn() {
			scientist = new ScientistAgent();
			scientist.x = (Math.random() * (stage.stageWidth * 0.75)) + stage.stageWidth / 4;
			enemyLayer.addChild(scientist);
			scientists.push(scientist);
		}

		private function enemySpawn() {
			if (frame == 1) {
				scientistSpawn();
				scientistSpawn();
				scientistSpawn();
			}
			if (frame == 2) {
				scientistSpawn();
				scientistSpawn();
				guardSpawn();
			}
			if (frame == 3) {
				scientistSpawn();
				scientistSpawn();
				guardSpawn();
			}
			if (frame == 4) {
				guardSpawn();
				scientistSpawn();
				guardSpawn();
			}
			if (frame >= 5) {
				if(player.playerStage == 2){
					guardSpawn();
					scientistSpawn();
					guardSpawn();
				} else if(player.playerStage == 3){
					guardSpawn();
					guardSpawn();
					guardSpawn();
					guardSpawn();
				}
			}
		}

		private function enemyUpdate() {
			for (var i: uint = 0; i < guards.length; i++) {
				guards[i].update(player);
			}
			for (var j: uint = 0; j < scientists.length; j++) {
				scientists[j].update(player);
			}
		}
		
		private function purgeScientist() {
			for each (var enemy in scientists) {
				enemyLayer.removeChild(enemy);
			}
		}
		
		private function purgeGuard() {
			for each (var enemy in guards) {
				enemyLayer.removeChild(enemy);
			}
		}
		
		

		private function gameCheck() {
			if (player.killCount >= 30) {
				addEventListener(Event.ENTER_FRAME, winEnterFrame);
			}
			if (player.lives == 0) {
				endLose.alpha = 0;
				TweenLite.to(endLose, 3, {alpha: 1});
				addChild(endLose);
				endLose.containedExit.addEventListener(MouseEvent.CLICK, menuHandler);
				removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
		}
		
		private function onEnterFrame(evt: Event) {
			player.update();
			babyCapture();
			playerStageChange();
			statusHead.gotoAndStop(player.lives);
			
			changeScreen();
			enemyUpdate();
			securityCam.update();
			
			scorebox.scoreTXT.text = player.killCount.toString();
			gameCheck();
		}

		private function winEnterFrame(evt: Event) {
			player.update();
			securityCam.update();
			if (player.x >= 1920) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				stageScreen.bg.gotoAndStop(8);
				player.x = 0;
				securityCam.x = Math.random() * 1000 + 210;
				securityCam.y = Math.random() * 300 + 50;
				purgeGuard();
				purgeScientist();
			}
			if (player.x >= 1700 && stageScreen.bg.currentFrame == 8) {
				endWin.alpha = 0;
				TweenLite.to(endWin, 3, {alpha: 1});
				addChild(endWin);
				endWin.containedExit.addEventListener(MouseEvent.CLICK, menuHandler);
				removeEventListener(Event.ENTER_FRAME, winEnterFrame);
			}
		}

	}

}