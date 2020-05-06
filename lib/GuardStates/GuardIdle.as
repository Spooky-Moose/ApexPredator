package lib.GuardStates{

	import lib.GuardAgent;
	import lib.Player;

	public class GuardIdle implements IGuardStates {

		public function update(a: GuardAgent, p:Player) {
			//trace("Idle update");
			a.numCycles++;
			if (a.numCycles > 30) {
				a.setGuardState(GuardAgent.WANDER);
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
			a.gotoAndPlay("e-guard_idle");
			trace("Idle enter");
		}
		
		public function exit(a: GuardAgent) {
			trace("Idle exit");
		}

	}

}