package lib {

	import lib.GuardStates.GuardChase;
	import lib.GuardStates.GuardIdle;
	import lib.GuardStates.GuardUnderAttack;
	import lib.GuardStates.GuardWander;
	import lib.GuardStates.GuardAttack;
	import lib.GuardStates.IGuardStates;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class GuardAgent extends MovieClip {

		public static const CHASE: IGuardStates = new GuardChase();
		public static const IDLE: IGuardStates = new GuardIdle();
		public static const UNDERATTACK: IGuardStates = new GuardUnderAttack();
		public static const WANDER: IGuardStates = new GuardWander();
		public static const ATTACK: IGuardStates = new GuardAttack();

		private var _currentState: IGuardStates = new GuardIdle();
		
		public var count: Number = 0;		
		
		public var radius: Number;
		public var numCycles: int = 0;
		public var speed:Number = 0;
		public var wanderingRandom:Number = 0;

		public function GuardAgent() {
			// constructor code
			x = 1250;
			y = 590;
			scaleX = 1.50;
			scaleY = 1.50;
			gotoAndPlay("e-guard_idle");
		}

		public function update(p:Player): void {
			_currentState.update(this,p);
		}

		public function setGuardState(newState: IGuardStates): void {
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