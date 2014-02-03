package entities.gui;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class PlayButton extends Entity {

	private var image:Image;

	public function new(x:Float, y:Float) {
		super(x, y);
		image = new Image("graphics/gui/playButton.png");
		graphic = image;
		Input.define("space", [Key.SPACE]);
		setHitbox(210, 70);
	}





	public override function update() {
		if(collidePoint(x, y, Input.mouseX, Input.mouseY)) {
			image.alpha = 0.7;
			if(Input.mousePressed) {
				HXP.scene = new scenes.TestScene();
			}
		} else {
			image.alpha = 1;
		}
		if(Input.pressed("space")) {
			HXP.scene = new scenes.TestScene();
		}
		super.update();
	}

}