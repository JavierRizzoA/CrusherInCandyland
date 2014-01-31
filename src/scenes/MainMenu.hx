package scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

class MainMenu extends Scene {

	public function new() {
		super();
	}

	public override function begin() {
		/*player = new entities.Player(HXP.halfWidth - 33, 363);
		for(a in 0 ... 11) {
			add(new entities.Floor(a * 70, 455));
		}

		add(player);
		createLollipop();
		add(new entities.enemies.Blocker(HXP.width + 50, 404));*/

		addGraphic(new Image("graphics/gui/menuBg.png"));
		add(new entities.gui.PlayButton(244, 283));
	}

	public override function update() {

		super.update();
	}
}