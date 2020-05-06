package lib.ScientistStates {

	import lib.ScientistAgent;
	import lib.Player;

	public class ScientistIdle implements IScientistStates {

		public function update(a: ScientistAgent, p: Player) {
			a.numCycles++;
			if (a.numCycles > 30) {
				a.setScientistState(ScientistAgent.WANDER);
			}

			if (p.playerStage == 1) {
				if (p.baby.bHitBox.hitTestObject(a.sVisionHitBox) && !p.hidden) {
					a.setScientistState(ScientistAgent.FLEE);
				}
			}
			if (p.playerStage == 2) {
				if (p.teen.tHitBox.hitTestObject(a.sVisionHitBox)) {
					a.setScientistState(ScientistAgent.FLEE);
				}
			}
			if (p.playerStage == 3) {
				if (p.adult.aHitBox.hitTestObject(a.sVisionHitBox)) {
					a.setScientistState(ScientistAgent.FLEE);
				}
			}
		}

		public function enter(a: ScientistAgent) {
			trace("Idle enter");
			a.gotoAndPlay("e-scientist_idle");
		}

		public function exit(a: ScientistAgent) {
			trace("Idle exit");
		}

	}

}