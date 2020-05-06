package lib.GuardStates {

	import lib.GuardAgent;
	import lib.Player;
	import flash.display.MovieClip;

	public class GuardChase implements IGuardStates {

		public function update(a: GuardAgent, p:Player) {
			//trace("Chase update");
			if(a.scaleX == 1.5) a.x -= a.speed;
			if(a.scaleX == -1.5) a.x += a.speed;
			
			if (p.playerStage == 1 && !p.hidden){
				guardAttack(a, p, p.baby.bHitBox)
				if(a.numCycles == 0){
					startCounter(a);
					a.numCycles++;
				}
			}
			
			if (p.playerStage == 2){
				guardAttack(a, p, p.teen.tHitBox);
				if(a.numCycles == 0){
					startCounter(a);
					a.numCycles++;
				}
			}
			
			if (p.playerStage == 3){
				guardAttack(a, p, p.adult.aHitBox);
				if(a.numCycles == 0){
					startCounter(a);
					a.numCycles++;
				}
			}
			
			a.count++;
			if(a.count == 90){
				a.setGuardState(GuardAgent.IDLE);
			}
		}
		
		public function startCounter(a:GuardAgent){
			a.count = 0;
		}
			
		private function guardAttack(a: GuardAgent, p: Player, hitBox: MovieClip) {
			if (!hitBox.hitTestObject(a.gChaseHitBox)) a.setGuardState(GuardAgent.WANDER);
			if (hitBox.hitTestObject(a.gAttackHitBox)) a.setGuardState(GuardAgent.ATTACK);
		}
		
		public function enter(a: GuardAgent) {
			trace("Chase enter");
			a.gotoAndPlay("e-guard_chase");
			a.speed = Math.floor(Math.random() * 5) + 7;
		}
		
		public function exit(a: GuardAgent) {
			trace("Chase exit");
		}

	}

}