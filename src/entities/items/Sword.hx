package entities.items;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
 
class Sword extends Entity {

	private var time:Float;
	private var offset:Int;

	public function new(x:Float, y:Float) {
		super(x, y);
		setHitbox(70, 70);
		graphic = new Image("graphics/items/sword.png");
		time = 0;
		offset = 0;
	}

	private function checkCollision() {
		var e:Entity = collide("enemy", x, y);
		if(e != null) {
			if(cast(e, entities.enemies.Enemy).enemyName == "Spider") {
				cast(e, entities.enemies.Spider).die();
			}
		}
	}

	public override function update() {
		time += HXP.elapsed;
		if(time <= 0.3) {
			offset++;
			if(cast(HXP.scene, scenes.TestScene).player.isJumping()) {
				moveTo(cast(HXP.scene, scenes.TestScene).player.x + 45 + offset, cast(HXP.scene, scenes.TestScene).player.y + 10);
			} else if(cast(HXP.scene, scenes.TestScene).player.isCrouching) {
				moveTo(cast(HXP.scene, scenes.TestScene).player.x + 45 + offset, cast(HXP.scene, scenes.TestScene).player.y + 25);
			} else {
				moveTo(cast(HXP.scene, scenes.TestScene).player.x + 45 + offset, cast(HXP.scene, scenes.TestScene).player.y + 35);
			}
		} else {
			cast(HXP.scene, scenes.TestScene).player.hideSword();
			HXP.scene.remove(this);
		}
		checkCollision();
		super.update();
	}

}	