package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Engine;
import com.haxepunk.graphics.Image;

class WorldGenerator extends Entity {

	private var popSticks:Array<String>;
	private var lollipops:Array<String>;

	private var timeSinceBlock:Float;
	private var timeSincePop:Float;

	public function new(x:Float, y:Float) {
		super(x, y);

		visible = false;
		timeSinceBlock = 0;
		timeSincePop = 0;

		popSticks = ["lollipopBase.png", "lollipopBaseBeige.png", "lollipopBaseBrown.png"];
		lollipops = ["lollipopFruitGreen.png", "lollipopFruitRed.png", "lollipopFruitYellow.png", "lollipopGreen.png", "lollipopRed.png", "lollipopWhiteGreen.png", "lollipopWhiteRed.png"];


	}	


	private function createLollipop() {

		

		timeSincePop += HXP.elapsed;

		if(timeSincePop >= 0.5) {
			if(Std.random(100) == 0) {
				HXP.scene.add(new entities.Decorative(HXP.width, 315, new Image("graphics/decorative/" + lollipops[Std.random(7)])));
				HXP.scene.add(new entities.Decorative(HXP.width, 385, new Image("graphics/decorative/" + popSticks[Std.random(3)])));
				timeSincePop = 0;
			}
		}
	}

	private function createBlock() {

		timeSinceBlock += HXP.elapsed;

		if(timeSinceBlock >= 0.5) {
			if(Std.random(100) == 0) {
				HXP.scene.add(new entities.enemies.Blocker(HXP.width + 50, 404));
				timeSinceBlock = 0;
			}
		} 		
	}

	public override function update() {
		/*var rnd:Int = Std.random(100);
		if(rnd == 0) {
			add(new entities.enemies.Blocker(HXP.width + 50, 404));
		}
		if(rnd == 1) {
			createLollipop();
		}
		super.update();*/
		createBlock();
		createLollipop();
		super.update();


	}

}