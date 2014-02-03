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

	public var isCrouching:Bool;
	private var crouchImg:Image;
	private var crouchTime:Float;

	public function new(x:Float, y:Float) {
		super(x, y);

		setHitbox(40, 92);
		type = "player";

		Input.define("jump", [Key.SPACE]);
		Input.define("sword", [Key.D]);
		Input.define("crouch", [Key.S]);

		jumping = false;

		frameAcum = 0;
		currentAnim = 1;

		walkingAnims = [for(i in 1 ... 12) new Image("graphics/player/walk/walk" + i + ".png")];
		walkingMasks=[for(i in 1 ... 12) new Pixelmask("graphics/player/walk/walk" + i + ".png")];

		jumpingAnim = new Image("graphics/player/jump.png");
		jumpingMask = new Pixelmask("graphics/player/jump.png");

		isCrouching = false;
		crouchImg = new Image("graphics/player/crouch.png");


		graphic = walkingAnims[0];
		//mask = walkingMasks[0];
		score = 0;
		swordDrawn = false;
	}

	private function handleInput() {

		if(Input.pressed("jump")) {
			if(onFloor()) {
				if(isCrouching) {
					getUp();
				}
				jumping = true;
				jumpMaxHeight = y - 150;
				jumpHeight = 0;
			}
		}

		if(Input.pressed("sword") && !swordDrawn) {	
			HXP.scene.add(new entities.items.Sword(x + 45, y + 35));
			swordDrawn = true;
		}
		if(Input.pressed("crouch") && !jumping) {
			crouch();
		}
	}

	private function updateAnim(updateTime:Float) {
		if(onFloor()) {
			if(isCrouching) {
				crouchTime += HXP.elapsed;
				if(crouchTime >= 0.4) {
					getUp();
				}
			} else {
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
			}
		} else {
			if(!isCrouching) {
				graphic = jumpingAnim;
			}
		}
	}


	private function jump() {
		if(y > jumpMaxHeight) {
			moveBy(0, -8);
			jumpHeight += 8;
		} else {
			jumping = false;
		}
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

	private function onFloor():Bool {
		var f:Entity = collide("floor", x, y);
		if(f != null) {
			return true;
		} else {
			return false;
		}
	}

	private function applyGravity():Void {
		if(jumping) {
			jump();
		} else {
			if(!onFloor()) {
				moveBy(0, 10);
			}

			var f:Entity = collide("floor", x, y);
			if(f != null) {
				y = f.y - (height - 1);
			}
		}
	}

	private function crouch():Void {
		isCrouching = true;
		graphic = crouchImg;
		setHitbox(40, 71);
		crouchTime = 0;
	}

	private function getUp():Void {
		isCrouching = false;
		graphic = walkingAnims[currentAnim];
		setHitbox(40, 92);
	}


	public override function update() {
		handleInput();
		checkCollision();
		updateAnim(HXP.elapsed);
		applyGravity();

		super.update();
	}

}