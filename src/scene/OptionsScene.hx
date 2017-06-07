package scene;

import h2d.Text;
import hxd.Res;
import platform.Button;
import platform.Slider;

class OptionsScene extends UpdatableScene 
{
	
	private function formatFloat(value : Float, decimals : Int) : String
	{
		var base : Int = 1;
		while (decimals-- > 0) base *= 10;
		return "" + Math.round(value * base) / base;
	}
	
	override public function init() 
	{	
		var speedText = new Text(Res.cour.build(64), this);
		speedText.y = height / 4 - speedText.textHeight;
		speedText.textColor = 0xFF0000;
		
		var speedSlider = new Slider(this, Math.floor(width * 0.8), 20);
		speedSlider.setPos((cast width - speedSlider.width) / 2, 2 * height / 4 - speedSlider.height);
		speedSlider.onValueChange = function(newValue : Float, oldValue : Float)
		{
			speedText.text = "Speed = " + formatFloat(newValue, 2);
			speedText.x = (width - speedText.textWidth) / 2;
			sharedData.snakeSpeed = newValue;
		}
		speedSlider.value = sharedData.snakeSpeed;
		
		var buttonMenu = new Button(this, Res.cour.build(64), "To Menu", 400, 80);
		buttonMenu.text.textColor = 0x000000;
		buttonMenu.onClickUp = onClickMenu;
		buttonMenu.setPos((width - buttonMenu.width) / 2, 3 * height / 4 - buttonMenu.height);
	}
	
	override public function resize(width : Int, height : Int) : Void
	{	
		super.resize(width, height);
		removeChildren();
		init();
	}
	
	private function onClickMenu()
	{
		sharedData.changeScene(MENU);
	}
	
}