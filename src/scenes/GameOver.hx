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


	public function new(score:Int, killer:String) {
		super();
		scoreText = new Text("Score: " + score, 20, 185, {color: 0x000000, size: 45, align: flash.text.TextFormatAlign.CENTER});
		killerText = new Text(killer, {color: 0x000000, size: 20, align: flash.text.TextFormatAlign.CENTER});
		killerImage = new Image("graphics/enemies/" + killer + ".png");
		bgImage = new Image("graphics/gui/gameOver.png");
		playButton = new entities.gui.PlayButton(125, 400);
	}

	public override function begin() {
		addGraphic(Image.createCircle(50, 0xE7DFC2), 0, 510-25, 220-25);
		addGraphic(bgImage);
		addGraphic(scoreText);
		addGraphic(new Text("Killed by:", 495, 176, {color: 0x000000, size: 20}), 0);
		addGraphic(killerImage, 0, 510, 220);
		addGraphic(killerText, 535 - killerText.textWidth / 2, 290);
		add(playButton);
		playButton.x -= playButton.width / 2;
		playButton.y -= playButton.height / 2;
	}

}