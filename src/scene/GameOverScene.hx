package scene;
import h2d.Text;
import hxd.Res;
import platform.Button;

/**
 * ...
 * @author AlexH
 */
class GameOverScene extends UpdatableScene
{
	override public function init()
	{
		var text = new Text(Res.cour.build(64), this);
		text.text = "Game Over";
		text.setPos((width - text.textWidth) / 2, height / 3 - text.textHeight);
		text.textColor = 0xFF0000;
		
		var buttonMenu = new Button(this, Res.cour.build(64), "To Menu", 400, 80);
		buttonMenu.text.textColor = 0x000000;
		buttonMenu.onClickDown = onClickMenu;
		buttonMenu.setPos((width - buttonMenu.width) / 2, 2 * height / 3 - buttonMenu.height);
	}

	private function onClickMenu()
	{
		changeScene(MENU);
	}
}