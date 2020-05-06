package lib.GuardStates{

	import lib.GuardAgent;
	import lib.Player;

	public class GuardWander implements IGuardStates {

		public function update(a: GuardAgent, p:Player) {
			//trace("Wander update");
			
			a.numCycles++;
			if (a.numCycles < 40 && a.wanderingRandom > 0.35) {
				a.x -= a.speed
				a.scaleX = 1.5;
			}
			if (a.numCycles < 40 && a.wanderingRandom < 0.35) {
				a.x += a.speed;
				a.scaleX = -1.5;
			}
			if (a.numCycles > 40) {
				a.setGuardState(GuardAgent.IDLE);
			}

			if(p.playerStage == 1){
				if(p.baby.bHitBox.hitTestObject(a.gVisionHitBox) && !p.hidden){
					a.setGuardState(GuardAgent.CHASE);
				}
			}
			if(p.playerStage == 2){
				if(p.teen.tHitBox.hitTestObject(a.gVisionHitBox)){
					a.setGuardState(GuardAgent.CHASE);
				}
			}
			if(p.playerStage == 3){
				if(p.adult.aHitBox.hitTestObject(a.gVisionHitBox)){
					a.setGuardState(GuardAgent.CHASE);
				}
			}
		}
		
		public function enter(a: GuardAgent) {
			trace("Wander enter");
			a.gotoAndPlay("e-guard_wander");
			
			//When guard enters, he should walk left and right randomly.
			//switch animation to walk left and right depending on direction moving
		
			a.speed = Math.floor(Math.random() * 10) + 3;
			a.wanderingRandom = Math.random();
			
			//Need a random determiner.
		}
		
		public function exit(a: GuardAgent) {
			trace("Wander exit");
		}

	}

}