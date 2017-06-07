package scene;

import h2d.Anim;
import h2d.Sprite;
import hxd.BitmapData;
import hxd.Event;
import hxd.Key;
import hxd.Res;
import platform.GridBitmap;
import scene.UpdatableScene;
import snake.Snake;
import snake.SnakeGrid;

class PlayScene extends UpdatableScene
{
	
	private static var FRAMES_PER_MOVE_MIN : Float = 60;
	private static var FRAMES_PER_MOVE_MAX : Float = 5;

	private static var SNAKE_GRID_ROWS = 11;
	private static var SNAKE_GRID_COLS = 11;
	private static var SNAKE_INITIAL_LENGTH = 3;

	private inline function snakeSpeedToFramesPerMove() : Float
	{
		return FRAMES_PER_MOVE_MAX + (FRAMES_PER_MOVE_MIN - FRAMES_PER_MOVE_MAX) * (1.0 - sharedData.snakeSpeed);
	}

	private var framesPerMove : Float;
	private var framesPerMoveCounter : Float;

	private var container : Sprite;
	private var snakeGrid : SnakeGrid;
	private var snake : Snake;
	private var food : GridBitmap;

	private function setChildrenPos() : Void
	{
		container.setPos((width - snakeGrid.width) / 2, (height - snakeGrid.height) / 2);
		snake.setPos(snakeGrid.x, snakeGrid.y);
	}
	
	override public function init()
	{
		framesPerMove = snakeSpeedToFramesPerMove();
		framesPerMoveCounter = 0;
		
		container = new Sprite(this);
		snakeGrid = new SnakeGrid(container, SNAKE_GRID_ROWS, SNAKE_GRID_COLS);
		snake = new Snake(container, SNAKE_INITIAL_LENGTH, SNAKE_GRID_ROWS, SNAKE_GRID_COLS);
		food = new GridBitmap(Res.pball.toTile(), container);
		relocateFood();
		
		setChildrenPos();
	}
	
	override public function resize(width : Int, height : Int) : Void
	{	
		super.resize(width, height);
		setChildrenPos();
	}

	private function relocateFood()
	{
		var newFoodPos = snake.getNonSnakeTile();
		food.row = newFoodPos.row;
		food.col = newFoodPos.col;
	}

	override function update(elapsed : Float)
	{
		framesPerMoveCounter += elapsed;

		var up : Bool = Key.isDown(Key.W) || Key.isDown(Key.UP);
		var left : Bool = Key.isDown(Key.A) || Key.isDown(Key.LEFT);
		var down : Bool = Key.isDown(Key.S) || Key.isDown(Key.DOWN);
		var right : Bool = Key.isDown(Key.D) || Key.isDown(Key.RIGHT);

		snake.processInput(up, left, down, right);

		if (framesPerMoveCounter > framesPerMove)
		{
			while (framesPerMoveCounter > framesPerMove) framesPerMoveCounter -= framesPerMove;

			var gameOver = !snake.processMovement();
			if (gameOver)
			{
				sharedData.changeScene(GAME_OVER);
			}
			else
			{
				var snakeHeadPos = snake.getHeadPos();
				if (snakeHeadPos.row == food.row && snakeHeadPos.col == food.col)
				{
					snake.grow();
					relocateFood();
				}
			}
		}
	}
	
}
