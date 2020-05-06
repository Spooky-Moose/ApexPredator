package lib.ScientistStates {

	import lib.ScientistAgent;
	import lib.Player;
	import flash.display.MovieClip;

	public class ScientistFlee implements IScientistStates {

		public function update(a: ScientistAgent, p: Player) {
			if (a.scaleX == 1.5) a.x -= a.speed;
			if (a.scaleX == -1.5) a.x += a.speed;

			if (p.playerStage == 1) {
				if (!p.baby.bHitBox.hitTestObject(a.sFleeHitBox) && !p.hidden) {
					if(a.numCycles == 0){
						startCounter(a);
						a.numCycles++;
					}
				}
			}
			if (p.playerStage == 2) {
				if (!p.teen.tHitBox.hitTestObject(a.sFleeHitBox)) {
					if(a.numCycles == 0){
						startCounter(a);
						a.numCycles++;
					}
				}
				if (p.attack) {
					a.setScientistState(ScientistAgent.UNDERATTACK);
				}
			}
			if (p.playerStage == 3) {
				if (!p.adult.aHitBox.hitTestObject(a.sFleeHitBox)) {
					if(a.numCycles == 0){
						startCounter(a);
						a.numCycles++;
					}
				}
				if (p.attack) {
					a.setScientistState(ScientistAgent.UNDERATTACK);
				}
			}
			a.count++;
			if(a.count == 90){
				a.setScientistState(ScientistAgent.IDLE);
			}
		}
		public function startCounter(a:ScientistAgent){
			a.count = 0;
		}

		public function enter(a: ScientistAgent) {
			trace("Flee enter");
			a.gotoAndPlay("e-scientist_flee");
			a.speed = Math.floor(Math.random() * 5) + 5;

			//flips the scientist so it runs away correctly
			if (a.scaleX == 1.5) {
				a.scaleX = -1.5;
			} else if (a.scaleX == -1.5) {
				a.scaleX = 1.5;
			}
		}

		public function exit(a: ScientistAgent) {
			trace("Flee exit");
		}

	}

}