package snake;

import h2d.Anim;
import h2d.Bitmap;
import h2d.Sprite;
import h2d.Tile;
import h2d.Drawable;
import hxd.Res;

class Snake extends Drawable
{
	
	private static var TILE_SIZE = 64;
	
	private static var TILE_ROW_MOVEMENT : Map<SnakeDirection, Int> = [
		N => -1,
		E => 0,
		S => 1,
		W => 0,
	];
	private static var TILE_COL_MOVEMENT : Map<SnakeDirection, Int> = [
		N => 0,
		E => 1,
		S => 0,
		W => -1,
	];
	
	private var snakeTiles : Array<Array<Tile>>;
	private var gridRows : Int;
	private var gridCols : Int;
	
	private var snake : Array<SnakeSegment>;
	
	private var newDirection : SnakeDirection = N;
	public var direction(default, null) : SnakeDirection = N;

	public function new(parent : Sprite, initialLength : Int, gridRows : Int, gridCols : Int)
	{
		super(parent);
		this.gridRows = gridRows;
		this.gridCols = gridCols;
		snakeTiles = Res.SnakeSpritesheet.toTile().grid(TILE_SIZE);
		snake = new Array<SnakeSegment>();
		for (segmentIndex in 0...initialLength)
		{
			snake[segmentIndex] = new SnakeSegment(this, snakeTiles);
			snake[segmentIndex].row = (gridRows >> 1) + segmentIndex;
			snake[segmentIndex].col = gridCols >> 1;
			
			snake[segmentIndex].direction = N;
			if (segmentIndex == 0) snake[segmentIndex].component = HEAD;
			else if (segmentIndex == (initialLength - 1)) snake[segmentIndex].component = TAIL;
			else snake[segmentIndex].component = BODY_I;
		}
	}
	
	public function getNonSnakeTile() : {row : Int, col : Int}
	{
		var nRow : Int;
		var nCol : Int;
		var collision : Bool;
		
		do {
			collision = false;
			nRow = Std.random(gridRows);
			nCol = Std.random(gridCols);
			for (snakeSegment in snake)
			{
				collision = collision || (snakeSegment.row == nRow && snakeSegment.col == nCol);
			}
		} while (collision);
		
		return { row: nRow, col: nCol };
	}
	
	public inline function getHeadPos() : {row : Int, col : Int}
	{
		return { row: snake[0].row, col: snake[0].col };
	}
	
	public function processInput(up : Bool, left : Bool, down : Bool, right : Bool)
	{
		switch direction
		{
			case N, S: 
				if (left && !right) newDirection = W;
				else if (!left && right) newDirection = E;
			case E, W:
				if (up && !down) newDirection = N;
				else if (!up && down) newDirection = S;
		}
	}
	
	public function grow()
	{
		var newSnakeSegment = new SnakeSegment(this, snakeTiles);
		var tailSnakeSegment = snake[snake.length - 1];
		newSnakeSegment.row = tailSnakeSegment.row;
		newSnakeSegment.col = tailSnakeSegment.col;
		newSnakeSegment.alpha = 0;
		snake.push(newSnakeSegment);
	}

	public function processMovement() : Bool
	{
		direction = newDirection;
		snake[0].direction = direction;
		
		var nextHeadRowPos = snake[0].row + TILE_ROW_MOVEMENT[direction];
		var nextHeadColPos = snake[0].col + TILE_COL_MOVEMENT[direction];
		
		// Test bounds
		if (nextHeadRowPos < 0 || nextHeadRowPos >= gridRows ||
			nextHeadColPos < 0 || nextHeadColPos >= gridCols)
		{
			return false;
		}
		
		// Test self collision
		for (snakeSegment in snake)
		{
			if (snakeSegment.component != TAIL)
			{
				if (snakeSegment.row == nextHeadRowPos && snakeSegment.col == nextHeadColPos)
				{
					return false;
				}
			}
		}
		
		// Move the snake
		var segmentIndex = snake.length - 1;
		while (segmentIndex > 0)
		{
			var nextSegmentIndex = segmentIndex - 1;
			var currSegment = snake[segmentIndex];
			var nextSegment = snake[nextSegmentIndex];
			
			if (currSegment.alpha == 0) 
				currSegment.alpha = 1;

			currSegment.row = nextSegment.row;
			currSegment.col = nextSegment.col;

			if (currSegment.direction != nextSegment.direction) 
				currSegment.component = BODY_CORNER;
			else 
				currSegment.component = BODY_I;

			currSegment.direction = nextSegment.direction;
			segmentIndex = nextSegmentIndex;
		}

		snake[0].row = nextHeadRowPos;
		snake[0].col = nextHeadColPos;
		
		if (snake[snake.length - 1].component != TAIL)
			snake[snake.length - 1].component = TAIL;
			
		return true;
	}
	
}
