#if js
import js.Browser;
#end

import hxd.App;
import hxd.Res;
import h3d.Engine;
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
		
	public static function main()
	{
		Res.initEmbed();
		new Main();
	}
	
	private function changeScene(scene : Scenes) : Void
	{
		lastScene = scene;
		currentScene = switch scene
		{
			case MENU: new MenuScene(sharedData);
			case OPTIONS: new OptionsScene(sharedData);
			case PLAY: new PlayScene(sharedData);
			case GAME_OVER: new GameOverScene(sharedData);
		}
		setScene2D(currentScene);
	}
	
	override function onResize()
	{
		#if js
		var width : Int = Browser.window.outerWidth;
		var height : Int = Browser.window.outerHeight;
		var engine : Engine = Engine.getCurrent();
		if (width != engine.width || height != engine.height)
		{
			engine.resize(width, height);
		}
		if (width != currentScene.width || height != currentScene.height)
		{
			currentScene.resize(width, height);
		}
		#end
		trace(currentScene.width);
	}

	override function init()
	{
		sharedData = new SharedData(changeScene);
		changeScene(MENU); 
	}

	override function update(elapsed : Float)
	{
		currentScene.update(elapsed);
	}
	
}