package entities.items;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
 
class Sword extends Entity {

	private var time:Float;
	private var offset:Int;

	public function new(x:Float, y:Float) {
		super(x, y);
		graphic = new Image("graphics/items/sword.png");
		time = 0;
		offset = 0;
	}


	public override function update() {
		time += HXP.elapsed;
		if(time <= 0.3) {
			offset++;
			//moveBy(1, 0, "enemy");
			if(cast(HXP.scene, scenes.TestScene).player.isJumping()) {
				moveTo(cast(HXP.scene, scenes.TestScene).player.x + 45 + offset, cast(HXP.scene, scenes.TestScene).player.y + 10);
			} else {
				moveTo(cast(HXP.scene, scenes.TestScene).player.x + 45 + offset, cast(HXP.scene, scenes.TestScene).player.y + 35);
			}
		} else {
			cast(HXP.scene, scenes.TestScene).player.hideSword();
			HXP.scene.remove(this);
		}
		super.update();
	}

}	