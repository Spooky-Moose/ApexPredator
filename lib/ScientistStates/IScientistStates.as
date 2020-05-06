package lib.ScientistStates{
	
	import lib.ScientistAgent;
	import lib.Player;

	public interface IScientistStates {

		// Interface methods:
		function update(a: ScientistAgent, p: Player);
		function enter(a: ScientistAgent);
		function exit(a: ScientistAgent);

	}

}