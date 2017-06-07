package scene;

import h2d.Scene;
import scene.Scenes;

class UpdatableScene extends Scene
{
	
	private var sharedData : SharedData;

	public function new(sharedData : SharedData)
	{
		super();
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