package lib.ScientistStates {

	import lib.ScientistAgent;
	import lib.Player;
	import flash.display.MovieClip;

	public class ScientistUnderAttack extends MovieClip implements IScientistStates {

		public function update(a: ScientistAgent, p: Player) {
			if (a.numCycles == 0) {
				p.killCount += 1;
				a.numCycles++;
			}
		}

		public function enter(a: ScientistAgent) {
			trace("Under attack enter");
			if (a.scaleX == 1.5) a.x += 150;
			if (a.scaleX == -1.5) a.x -= 150;
			a.gotoAndPlay("e-scientist_dead");
		}

		public function exit(a: ScientistAgent) {
			trace("Under attack exit");
		}

	}

}