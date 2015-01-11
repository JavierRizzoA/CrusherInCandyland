package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;

class GameOver extends Scene {

	private var bgImage:Image;
	private var scoreText:Text;
	private var killerText:Text;
	private var killerImage:Image;
	private var playButton:Entity;
	private var offsetX:Int;
	private var offsetY:Int;


	public function new(score:Int, killer:String) {
		super();
		scoreText = new Text("Score: " + score, 20, 185, {color: 0x000000, size: 45, align: flash.text.TextFormatAlign.CENTER});
		killerText = new Text(killer, {color: 0x000000, size: 20, align: flash.text.TextFormatAlign.CENTER});
		killerImage = new Image("graphics/enemies/" + killer + ".png");
		bgImage = new Image("graphics/gui/gameOver.png");
		playButton = new entities.gui.PlayButton(125, 400);
		switch(killer) {
			case "Blocker":
				offsetX = -25;
				offsetY = -25;
				//break;
			case "Spider":
				offsetX = -35;
				offsetY = -22;
				//break;
			default:
				offsetX = 0;
				offsetY = 0;
				//break;
		}
	}

	public override function begin() {
		addGraphic(Image.createCircle(50, 0xE7DFC2), 0, 510-25, 220-25);
		addGraphic(bgImage, 10);
		addGraphic(scoreText);
		addGraphic(new Text("Killed by:", 495, 176, {color: 0x000000, size: 20}), 0);
		addGraphic(killerImage, 0, 535 + offsetX, 245 + offsetY);
		addGraphic(killerText, 0, 535 - killerText.textWidth / 2, 290);
		add(playButton);
		playButton.x -= playButton.width / 2;
		playButton.y -= playButton.height / 2;
	}

}
