package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import com.haxepunk.masks.Pixelmask;

class Player extends Entity {

	private var jumping:Bool;
	private var onFloor:Bool;
	private var jumpMaxHeight:Float;
	private var jumpHeight:Float;

	private var frameAcum:Float;
	private var currentAnim:Int;
	private var walkingAnims:Array<Image>;
	private var walkingMasks:Array<Pixelmask>;
	private var jumpingAnim:Image;
	private var jumpingMask:Pixelmask;
	private var score:Int;

	private var swordDrawn:Bool;

	public function new(x:Float, y:Float) {
		super(x, y);

		setHitbox(40, 92);
		type = "player";

		Input.define("jump", [Key.SPACE]);
		Input.define("pause", [Key.P]);
		Input.define("sword", [Key.D]);

		jumping = false;
		onFloor = true;

		frameAcum = 0;
		currentAnim = 1;

		walkingAnims = [for(i in 1 ... 12) new Image("graphics/player/walk/walk" + i + ".png")];
		walkingMasks=[for(i in 1 ... 12) new Pixelmask("graphics/player/walk/walk" + i + ".png")];

		jumpingAnim = new Image("graphics/player/jump.png");
		jumpingMask = new Pixelmask("graphics/player/jump.png");


		graphic = walkingAnims[0];
		//mask = walkingMasks[0];
		score = 0;
		swordDrawn = false;
	}

	private function handleInput() {

		if(Input.pressed("jump")) {
			if(onFloor) {
				jumping = true;
				jumpMaxHeight = y - 150;
				jumpHeight = 0;
			}
		}

		if(Input.check("pause")) {
			//HXP.engine.paused = false;
			//HXP.scene = new scenes.TestScene();
		}

		if(Input.pressed("sword") && !swordDrawn) {
			HXP.scene.add(new entities.items.Sword(x + 45, y + 35));
			swordDrawn = true;
		}
	}

	private function updateAnim(updateTime:Float) {
		if(onFloor) {
			frameAcum += updateTime;
			if(frameAcum >= 0.03) {
				if(currentAnim == 10) {
					currentAnim = 0;
				} else {
					currentAnim++;
				}
				frameAcum = 0;
				graphic = walkingAnims[currentAnim];
				//mask = walkingMasks[currentAnim];
			}
		} else {
			graphic = jumpingAnim;
			//mask = jumpingMask;
		}
	}


	private function jump() {
		if(y > jumpMaxHeight) {
			moveBy(0, -8);

			jumpHeight += 8;
			onFloor = false;
		} else {
			jumping = false;
		}
	}

	public override function moveCollideY(e:Entity) {
		if(e.type == "floor") {
			onFloor = true;
		}
		return true;
	}

	private function checkCollision() {
		var e:Entity = collide("enemy", x, y);
		if(e != null) {
			//HXP.engine.paused = true;
			die(cast(e, entities.enemies.Enemy).enemyName);
		}
	}
	
	public function isJumping():Bool {
		if(jumping) {
			return true;
		} else {
			return false;
		}
	}

	public function giveScore(s:Int):Void {
		score += s;
	}

	public function getScore():Int {
		return score;
	}

	public function hideSword():Void {
		swordDrawn = false;
	}

	private function die(killer:String):Void {
		//HXP.engine.paused = true;
		HXP.scene = new scenes.GameOver(score, killer);
	}

	public override function update() {
		handleInput();
		checkCollision();
		updateAnim(HXP.elapsed);
		if(jumping) {
			jump();
		} else if(!onFloor) {
			moveBy(0, 10, "floor");
		}


		super.update();
	}

}