package lib {

	import lib.ScientistStates.ScientistFlee;
	import lib.ScientistStates.ScientistIdle;
	import lib.ScientistStates.ScientistUnderAttack;
	import lib.ScientistStates.ScientistWander;
	import lib.ScientistStates.IScientistStates;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class ScientistAgent extends MovieClip {

		public static const FLEE: IScientistStates = new ScientistFlee();
		public static const IDLE: IScientistStates = new ScientistIdle();
		public static const UNDERATTACK: IScientistStates = new ScientistUnderAttack();
		public static const WANDER: IScientistStates = new ScientistWander();

		private var _currentState: IScientistStates = IDLE;
		
		public var count: Number = 0;

		public var radius: Number;
		public var numCycles: int = 0;
		public var speed:Number = 0;
		public var wanderingRandom:Number = 0;

		public function ScientistAgent() {
			// constructor code
			x = 1625;
			y = 590;
			scaleX = 1.50;
			scaleY = 1.50;
		}

		public function update(p:Player): void {
			_currentState.update(this,p);
		}

		public function setScientistState(newState: IScientistStates): void {
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}

	}

}