package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Decorative extends Entity {

	

	public function new(x:Float, y:Float, image:Image) {
		super(x, y);
		layer = 100;
		image.alpha = 0.5;
		graphic = image;
	}

	public override function update() {
		if(cast(HXP.scene, scenes.TestScene).moving) {
			moveBy(-7, 0);
			if(x + 100 <= 0) {
				HXP.scene.remove(this);
			}
		}
		super.update();
	}

}