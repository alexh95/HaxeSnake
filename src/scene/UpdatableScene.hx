package scene;

import h2d.Scene;
import scene.Scenes;

class UpdatableScene extends Scene
{
	private var changeScene : Scenes -> Void;
	private var sharedData : SharedData;

	public function new(changeScene : Scenes -> Void, sharedData : SharedData)
	{
		super();
		this.changeScene = changeScene;
		this.sharedData = sharedData;
		init();
	}

	public function init()
	{
	}

	public function update(elapsed : Float)
	{
	}
}