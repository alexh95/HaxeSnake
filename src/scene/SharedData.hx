package scene;

class SharedData 
{
	
	public var snakeSpeed : Float = 0.3;
	
	public var changeScene(default, null) : Scenes -> Void;
	
	public function new(changeScene : Scenes -> Void) 
	{
		this.changeScene = changeScene;
	}
	
}