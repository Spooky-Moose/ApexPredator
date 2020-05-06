package lib.ScientistStates {

	import lib.ScientistAgent;
	import lib.Player;

	public class ScientistWander implements IScientistStates {

		public function update(a: ScientistAgent, p: Player) {
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
				a.setScientistState(ScientistAgent.IDLE);
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
			trace("Wander enter");
			a.gotoAndPlay("e-scientist_wander");
			a.speed = Math.floor(Math.random() * 10) + 3;
			a.wanderingRandom = Math.random();
		}

		public function exit(a: ScientistAgent) {
			trace("Wander exit");
		}

	}

}