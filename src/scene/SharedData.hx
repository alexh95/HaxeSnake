package scene;

class SharedData 
{
	
	public var snakeSpeed : Float;
	
	public var changeScene(default, null) : Scenes -> Void;
	
	public function new(changeScene : Scenes -> Void) 
	{
		snakeSpeed = 0.3;
		this.changeScene = changeScene;
	}
	
}