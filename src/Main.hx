import com.haxepunk.Engine;
import com.haxepunk.HXP;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
		HXP.scene = new scenes.TestScene();
#else
		HXP.scene = new scenes.MainMenu();
#end
		//HXP.scene = new MainScene();
		//HXP.scene = new scenes.TestScene();
	}

	public static function main() { new Main(); }

}