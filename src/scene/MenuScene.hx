package scene;

#if js
import js.Browser;
#end

import h2d.Text;
import hxd.Event;
import hxd.Res;
import hxd.res.Font;
import platform.Button;

class MenuScene extends UpdatableScene
{
	
	override public function init()
	{
		var titleText = new Text(Res.cour.build(128), this);
		titleText.text = "Menu";
		titleText.textColor = 0xFF0000;
		titleText.setPos((width - titleText.textWidth) / 2, height / 5 - titleText.textHeight);
		
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
	
	override public function resize(width : Int, height : Int) : Void
	{
		super.resize(width, height);
		removeChildren();
		init();
	}

	private function onClickPlay()
	{
		sharedData.changeScene(PLAY);
	}

	private function onClickOptions()
	{
		sharedData.changeScene(OPTIONS);
	}
	
	private function onClickExit()
	{
		#if js
		Browser.window.close();
		#end
	}
	
}