package lib {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.KeyboardEvent;
	
	public class SecurityCamera extends MovieClip {
		
		private var cycle:Number = 0;

		public function SecurityCamera() {
			// constructor code
			x = 225;
			y = 200;
		}
		
		public function update(){
			walk(arm,cam,cycle);
			cycle += 0.04;
		}
		
		private function walk(segA:MovieClip,segB:MovieClip,cyc:Number):void{
			var angle0:Number = Math.sin(cyc) * 10 + 190;
			var angle1:Number = Math.sin(cyc + -1.57) * 10 + 20;
			segA.rotation = angle0;
			segB.rotation = (segA.rotation + angle1) + 200;
			segB.x = segA.x + Math.cos((segA.rotation + 270) * Math.PI/180) * 136;
			segB.y = segA.y + Math.sin((segA.rotation + 270) * Math.PI/180) * 136;
		}
		
	}
	
}
