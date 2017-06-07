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

	public function init() : Void
	{ 
	}
	
	public function resize(width : Int, height : Int) : Void
	{
		this.width = width;
		this.height = height;
	}

	public function update(elapsed : Float) : Void
	{
	}
	
}