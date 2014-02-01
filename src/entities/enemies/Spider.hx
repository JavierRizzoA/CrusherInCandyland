package entities.enemies;

import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Spider extends Enemy {

	private var walkingAnim:Array<Image>;
	private var frameTime:Float;
	private var currentFrame:Int;

	public function new(x:Float, y:Float) {
		super(x, y);

		setHitbox(72, 51);
		enemyName = "Spider";

		walkingAnim = [new Image("graphics/enemies/spider_walk1.png"), new Image("graphics/enemies/spider_walk2.png")];
		currentFrame = 0;
		graphic = walkingAnim[currentFrame];
		frameTime = 0;
		super.update();

	}

	private function updateAnim():Void {
		frameTime += HXP.elapsed;
		if(frameTime >= 0.1) {
			if(currentFrame == 0) {
				currentFrame = 1;
			} else {
				currentFrame = 0;
			}
			frameTime = 0;
			graphic = walkingAnim[currentFrame];
		}
	}

	public function die():Void {
		cast(HXP.scene, scenes.TestScene).player.giveScore(25);
		HXP.scene.add(new entities.Decorative(x, y, new Image("graphics/enemies/spider_dead.png"), false));
		HXP.scene.remove(this);
	}

	public override function update() {
		if(cast(HXP.scene, scenes.TestScene).moving) {
			moveBy(-3, 0);
			if(x + width <= 0) {
				HXP.scene.remove(this);
			}
		}
		updateAnim();
		super.update();
	}


}