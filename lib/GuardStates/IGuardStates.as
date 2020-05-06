package lib.GuardStates{
	
	import lib.GuardAgent;
	import lib.Player;

	public interface IGuardStates {

		function update(a: GuardAgent, p: Player);
		function enter(a: GuardAgent);
		function exit(a: GuardAgent);

	}

}