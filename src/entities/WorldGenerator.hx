package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Engine;
import com.haxepunk.graphics.Image;

class WorldGenerator extends Entity {

	private var popSticks:Array<String>;
	private var lollipops:Array<String>;
	private var simpleCandies:Array<String>;

	private var timeSinceBlock:Float;
	private var timeSincePop:Float;
	private var timeSinceSimpleCandy:Float;
	private var timeSinceDecor:Float;
	private var timeSinceSpider:Float;

	public function new(x:Float, y:Float) {
		super(x, y);

		visible = false;

		timeSinceDecor = 1;
		timeSinceBlock = 0;
		timeSincePop = 1;
		timeSinceSimpleCandy = 1;
		timeSinceSpider = -5;

		popSticks = ["lollipopBase", "lollipopBaseBeige", "lollipopBaseBrown"];
		lollipops = ["lollipopFruitGreen", "lollipopFruitRed", "lollipopFruitYellow", "lollipopGreen", "lollipopRed", "lollipopWhiteGreen", "lollipopWhiteRed"];
		simpleCandies = ["candyBlue", "candyGreen", "candyRed", "candyYellow", "canePinkSmall", "heart"];


	}	

	private function decorate() {
		timeSinceDecor += HXP.elapsed;
		createLollipop();
		createSimpleCandy();
	}


	private function createLollipop() {
		timeSincePop += HXP.elapsed;

		if(timeSincePop >= 0.5 && timeSinceDecor > 0.01) {
			if(Std.random(100) == 0) {
				HXP.scene.add(new entities.Decorative(HXP.width, 315, new Image("graphics/decorative/" + lollipops[Std.random(7)] + ".png")));
				HXP.scene.add(new entities.Decorative(HXP.width, 385, new Image("graphics/decorative/" + popSticks[Std.random(3)] + ".png")));
				timeSincePop = 0;
				timeSinceDecor = 0;
			}
		}
	}

	private function createSimpleCandy() {
		timeSinceSimpleCandy += HXP.elapsed;
		if(timeSinceSimpleCandy >= 0.5 && timeSinceDecor > 0.01) {
			if(Std.random(100) == 0) {
				HXP.scene.add(new entities.Decorative(HXP.width, 385, new Image("graphics/decorative/" + simpleCandies[Std.random(6)] + ".png")));
				timeSinceSimpleCandy = 0;
				timeSinceDecor = 0;
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

	private function createSpider() {
		timeSinceSpider += HXP.elapsed;
		if(timeSinceSpider >= 1) {
			if(Std.random(200) == 0) {
				HXP.scene.add(new entities.enemies.Spider(HXP.width + 50, 404));
				timeSinceSpider = 0;
			}
		}
	}

	public override function update() {

		createBlock();
		decorate();
		createSpider();
		super.update();


	}

}