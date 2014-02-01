package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Floor extends Entity {

	private var timeSinceFlavourChange:Float;
	private var flavour:Int;

	public function new(x:Float, y:Float) {
		super(x, y);

		graphic = new Image("graphics/block2.png");
		setHitbox(70, 70);
		type = "floor";
		timeSinceFlavourChange = 15;
		flavour = 2;
	}

	public function changeFlavour() {
		timeSinceFlavourChange += HXP.elapsed;
		if(timeSinceFlavourChange >= 20) {
			if(Std.random(2) == 0) {
				if(flavour == 1) {
					flavour = 2;
				} else {
					flavour = 1;
				}
				timeSinceFlavourChange = 0;
			}
		}
	}

	public override function update() {
		changeFlavour();
		moveBy(-7, 0);
		if(x + 70 <= 0) {
			x = 700;
			graphic = new Image("graphics/block" + flavour + ".png");
		}
		super.update();
	}

}