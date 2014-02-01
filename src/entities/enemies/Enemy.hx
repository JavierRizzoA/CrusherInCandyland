package entities.enemies;

import com.haxepunk.Entity;
import com.haxepunk.HXP;

class Enemy extends Entity {

	public var enemyName:String;

	public function new(x:Float, y:Float) {
		super(x, y);
		type = "enemy";
		enemyName = "enemy";

	}





	public override function update() {

		if(cast(HXP.scene, scenes.TestScene).moving) {
			moveBy(-7, 0);
			if(x + width <= 0) {
				HXP.scene.remove(this);
			}
		}
		super.update();
		
	}

}