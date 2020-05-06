package lib {

	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;

	public class Player extends MovieClip {

		private var speed: Number = 0;
		public var playerStage: Number = 1;
		public var lives: Number = 5;
		public var hidden: Boolean = false;
		public var captured: Boolean = false;
		public var attack: Boolean = false;
		public var killCount:Number = 0;

		public function Player() {
			gotoAndStop(playerStage);
			x = 1930;
			y = 925;
			scaleX = -0.75;
			scaleY = 0.75;
		}

		public function movementGo(evt: KeyboardEvent): void {
			if (evt.keyCode == 65) {
				if (playerStage == 1 && !hidden) {
					speed = -8;
					scaleX = 0.75;
				}
				if (playerStage == 2 && teen.currentLabel != "p-teen_attack") {
					speed = -15;
					scaleX = 0.75;
				}
				if (playerStage == 3 && adult.currentLabel != "p-adult_attack") {
					speed = -15;
					scaleX = 0.75;
				}
			} else if (evt.keyCode == 68) {
				if (playerStage == 1 && !hidden) {
					speed = 8;
					scaleX = -0.75;
				}
				if (playerStage == 2 && teen.currentLabel != "p-teen_attack") {
					speed = 15;
					scaleX = -0.75;
				}
				if (playerStage == 3 && adult.currentLabel != "p-adult_attack") {
					speed = 15;
					scaleX = -0.75;
				}
			}
		}

		public function special(evt: KeyboardEvent,c:MovieClip): void {
			if (evt.keyCode == 69) {
				if (playerStage == 1) hide(c);
				if (playerStage == 2) attackAni(teen, "p-teen_attack");
				if (playerStage == 3) attackAni(adult, "p-adult_attack");
			}
		}

		private function attackAni(pStage: MovieClip, attackLabel: String) {
			if (pStage.currentLabel != attackLabel) {
				pStage.gotoAndPlay(attackLabel);
			}
		}

		private function attackStatus(pStage: MovieClip, attackLabel: String) {
			if (pStage.currentLabel != attackLabel) attack = false;
			if (pStage.currentLabel == attackLabel) attack = true;
		}

		private function hide(c:MovieClip) {
			if(baby.bHitBox.hitTestObject(c)){
				if (!hidden) {
					c.gotoAndPlay(2);
					hidden = true;
					alpha = 0.1;
					y -= 100;
				} else if (hidden) {
					c.gotoAndPlay(2);
					hidden = false;
					alpha = 1;
					y += 100;
				}
			}
		}

		public function movementStop(): void {
			speed = 0;
		}

		private function playerAni(pStage: MovieClip, walk: String, idle: String): void {
			if (speed != 0 && pStage.currentLabel != walk) {
				pStage.gotoAndPlay(walk);
			} else if (speed == 0 && pStage.currentLabel != idle) {
				pStage.gotoAndPlay(idle);
			}
		}

		public function update() {
			x += speed;
			
			//attack status
			if (playerStage == 2) attackStatus(teen, "p-teen_attack");
			if (playerStage == 3) attackStatus(adult, "p-adult_attack");

			//walk-idle cycle
			if (playerStage == 1) {
				playerAni(baby, "p-baby_walk", "p-baby_idle");
			} else if (playerStage == 2 && teen.currentLabel != "p-teen_attack") {
				playerAni(teen, "p-teen_walk", "p-teen_idle");
			} else if (playerStage == 3 && adult.currentLabel != "p-adult_attack") {
				playerAni(adult, "p-adult_walk", "p-adult_idle");
			}
		}

	}

}