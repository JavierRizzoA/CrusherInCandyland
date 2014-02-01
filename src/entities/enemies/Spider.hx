package entities.enemies;

import com.haxepunk.graphics.Image;

class Spider extends Enemy {

	private var walkingAnim:Array<Image>;

	public function new(x:Float, y:Float) {
		super();

		setHitbox(72, 51);
		enemyName = "Spider";

		
		super.update();

	}

	public override function update() {

	}


}