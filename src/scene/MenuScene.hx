package scene;

import js.Browser;

import h2d.Text;
import hxd.Event;
import hxd.Res;
import hxd.res.Font;
import platform.Button;

class MenuScene extends UpdatableScene
{
	private var testButton : platform.Button;
	
	override public function init()
	{
		var text = new Text(Res.cour.build(128), this);
		text.text = "Menu";
		text.textColor = 0xFF0000;
		text.setPos((width - text.textWidth) / 2, height / 5 - text.textHeight);
		
		var buttonPlay = new Button(this, Res.cour.build(64), "Play", 400, 80);
		buttonPlay.text.textColor = 0x000000;
		buttonPlay.onClickUp = onClickPlay;
		buttonPlay.setPos((width - buttonPlay.width) / 2, 2 * height / 5 - buttonPlay.height);

		var buttonOptions = new Button(this, Res.cour.build(64), "Options", 400, 80);
		buttonOptions.text.textColor = 0x000000;
		buttonOptions.onClickUp = onClickOptions;
		buttonOptions.setPos((width - buttonOptions.width) / 2, 3 * height / 5 - buttonOptions.height);
		
		var buttonExit = new Button(this, Res.cour.build(64), "Quit", 400, 80);
		buttonExit.text.textColor = 0x000000;
		buttonExit.onClickUp = onClickExit;
		buttonExit.setPos((width - buttonOptions.width) / 2, 4 * height / 5 - buttonOptions.height);
	}
	
	override public function update(elapsed : Float) 
	{
		
	}

	private function onClickPlay()
	{
		changeScene(PLAY);
	}

	private function onClickOptions()
	{
		changeScene(OPTIONS);
	}
	
	private function onClickExit()
	{
		Browser.window.close();
	}
}