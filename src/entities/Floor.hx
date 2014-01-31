package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Floor extends Entity {

	public function new(x:Float, y:Float) {
		super(x, y);

		graphic = new Image("graphics/block2.png");
		setHitbox(70, 70);
		type = "floor";
	}

	public override function update() {
		moveBy(-7, 0);
		if(x + 70 <= 0) {
			x = 700;
		}
		super.update();
	}

}