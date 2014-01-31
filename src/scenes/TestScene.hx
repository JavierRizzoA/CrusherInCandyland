package scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

class TestScene extends Scene {

	public var player:entities.Player;
	private var score:Text;
	private var timeAcum:Float;

	public function new() {
		super();
	}

	public override function begin() {
		player = new entities.Player(HXP.halfWidth - 33, 363);
		score = new Text("0", 10, 10, {color: 0x000000, size: 20});
		timeAcum = 0;


		for(a in 0 ... 11) {
			add(new entities.Floor(a * 70, 455));
		}

		addGraphic(score);
		add(player);
		add(new entities.WorldGenerator(0, 0));

		//createLollipop();
		//add(new entities.enemies.Blocker(HXP.width + 50, 404));
	}

	private function displayScore() {
		score.text = "" + player.getScore();
	}

	private function secondTick() {
		timeAcum = 0;
		player.giveScore(1);
	}

	public override function update() {
		timeAcum += HXP.elapsed;
		if(timeAcum >= 1) {
			secondTick();
		}
		/*var rnd:Int = Std.random(100);
		if(rnd == 0) {
			add(new entities.enemies.Blocker(HXP.width + 50, 404));
		}
		if(rnd == 1) {
			createLollipop();
		}*/
		displayScore();

		super.update();
	}
}