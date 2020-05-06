package lib.GuardStates {

	import lib.GuardAgent;
	import lib.Player;
	import flash.display.MovieClip;

	public class GuardUnderAttack extends MovieClip implements IGuardStates {

		public function update(a: GuardAgent, p: Player) {
			if (a.numCycles == 0) {
				p.killCount += 1;
				a.numCycles++;
			}
		}

		public function enter(a: GuardAgent) {
			trace("Under attack enter");
			if (a.scaleX == 1.5) a.x += 150;
			if (a.scaleX == -1.5) a.x -= 150;
			a.gotoAndPlay("e_guard-dead");
		}

		public function exit(a: GuardAgent) {
			trace("Under attack exit");
		}

	}

}