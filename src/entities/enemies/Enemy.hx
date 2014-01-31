package entities.enemies;

import com.haxepunk.Entity;
import com.haxepunk.HXP;

class Enemy extends Entity {

	public function new(x:Float, y:Float) {
		super(x, y);
		type = "enemy";
	}





	public override function update() {

		moveBy(-7, 0);
		if(x + width <= 0) {
			HXP.scene.remove(this);
		}

		super.update();
	}

}