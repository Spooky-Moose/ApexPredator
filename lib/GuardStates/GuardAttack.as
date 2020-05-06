package lib.GuardStates {

	import lib.GuardAgent;
	import lib.Player;
	import flash.display.MovieClip;

	public class GuardAttack implements IGuardStates {

		private var num: Number = 0;
		private var count: Number = 0;
		private var hit: Boolean = false;

		public function update(a: GuardAgent, p: Player) {
			num++;
			count--;
			if(count == 0){
				hit = false;
			}
			
			if (p.playerStage == 1) {
				guardAttack(a, p, p.baby.bHitBox);
				if (p.hidden) {
					a.setGuardState(GuardAgent.IDLE);
				}
			}
			if (p.playerStage == 2) {
				guardAttack(a, p, p.teen.tHitBox);
				if (p.attack) {
					a.setGuardState(GuardAgent.UNDERATTACK);
				}
			}
			if (p.playerStage == 3) {
				guardAttack(a, p, p.adult.aHitBox);
				if (p.attack) {
					a.setGuardState(GuardAgent.UNDERATTACK);
				}
			}
		}

		private function guardAttack(a: GuardAgent, p: Player, hitBox: MovieClip) {
			if (!hitBox.hitTestObject(a.gAttackedHitBox)) {
				a.setGuardState(GuardAgent.CHASE);
			}
			
			if (hitBox.hitTestObject(a.gAttackHitBox) && !hit) {
				if(p.playerStage == 1) p.captured = true;
				count = 23;
				p.lives--;
				hit = true;
			}
			
			if ((p.x) - (a.x) < 0){
				a.scaleX = 1.5;
			} else if ((p.x) - (a.x) > 0){
				a.scaleX = -1.5;
			}
		}

		public function enter(a: GuardAgent) {
			trace("guard attack enter");
			a.gotoAndPlay("e-guard_attack");
		}

		public function exit(a: GuardAgent) {
			trace("guard attack exit");
		}

	}

}