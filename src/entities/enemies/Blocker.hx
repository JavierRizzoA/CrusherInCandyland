package entities.enemies;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

class Blocker extends Enemy {

	private var madGraphic:Image;
	private var sadGraphic:Image;
	private var gavePoints:Bool;

	public function new(x:Float, y:Float) {
		super(x, y);

		setHitbox(51, 51);
		enemyName = "Blocker";

		madGraphic = new Image("graphics/enemies/blockerMad.png");
		sadGraphic = new Image("graphics/enemies/blockerSad.png");

		graphic = madGraphic;

		gavePoints = false;


	}



	public override function update() {

		if((x + 51) < cast(HXP.scene, scenes.TestScene).player.x) {
			graphic = sadGraphic;
			if(!gavePoints) {
				cast(HXP.scene, scenes.TestScene).player.giveScore(10);
				gavePoints = true;
			}
		}

		super.update();
	}

}