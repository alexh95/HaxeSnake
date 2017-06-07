import js.Browser;

import hxd.App;
import hxd.Res;
import scene.GameOverScene;
import scene.Scenes;
import scene.MenuScene;
import scene.OptionsScene;
import scene.PlayScene;
import scene.SharedData;
import scene.UpdatableScene;

class Main extends App
{	
	private var lastScene: Scenes;
	private var currentScene : UpdatableScene;
	private var sharedData : SharedData;

	private function changeScene(scene : Scenes)
	{
		var width : Int = Browser.window.outerWidth;
		var height : Int = Browser.window.outerHeight;
		h3d.Engine.getCurrent().resize(width, height);
		
		lastScene = scene;
		switch scene
		{
			case MENU: setScene2D(currentScene = new MenuScene(changeScene, sharedData));
			case OPTIONS: setScene2D(currentScene = new OptionsScene(changeScene, sharedData));
			case PLAY: setScene2D(currentScene = new PlayScene(changeScene, sharedData));
			case GAME_OVER: setScene2D(currentScene = new GameOverScene(changeScene, sharedData));
		}
	}

	override function init()
	{
		sharedData = new SharedData();
		changeScene(MENU);
	}

	override function update(elapsed : Float)
	{
		currentScene.update(elapsed);
	}
	
	override function onResize()
	{
		changeScene(lastScene);
	}
	
	static function main()
	{
		Res.initEmbed();
		new Main();
	}
}