package snake;

import h2d.Sprite;
import h2d.Tile;
import platform.AnimationGrid;
import snake.SnakeDirection;

enum SnakeComponent
{
	HEAD;
	BODY_I;
	BODY_CORNER;
	TAIL;
}

class SnakeSegment extends AnimationGrid
{
	private static var TILE_ROWS = 4;
	private static var TILE_COLS = 4;
	
	private static var COMPONENT_COL_INDEX : Map<SnakeComponent, Int> = [
		HEAD => 0,
		BODY_I => 1,
		BODY_CORNER => 2,
		TAIL => 3,
	];
	
	private static var DIRECTION_ROW_INDEX : Map<SnakeDirection, Int> = [
		N => 0,
		E => 1,
		S => 2,
		W => 3,
	];
	
	private static var DIRECTION_ROW_INDEX_CORNER_NORTH : Map<SnakeDirection, Int> = [
		N => -1,
		E => 1,
		S => -1,
		W => 2,
	];
	
	private static var DIRECTION_ROW_INDEX_CORNER_EAST : Map<SnakeDirection, Int> = [
		N => 3,
		E => -1,
		S => 2,
		W => -1,
	];
	
	private static var DIRECTION_ROW_INDEX_CORNER_SOUTH : Map<SnakeDirection, Int> = [
		N => -1,
		E => 0,
		S => -1,
		W => 3,
	];
	
	private static var DIRECTION_ROW_INDEX_CORNER_WEST : Map<SnakeDirection, Int> = [
		N => 0,
		E => -1,
		S => 1,
		W => -1,
	];
	
	private static inline function DIRECTION_ROW_INDEX_BODY_CORNER(lastDirection : SnakeDirection, direction : SnakeDirection) : Int  
	{
		return switch lastDirection
		{
			case N: DIRECTION_ROW_INDEX_CORNER_NORTH[direction];
			case E: DIRECTION_ROW_INDEX_CORNER_EAST[direction];
			case S: DIRECTION_ROW_INDEX_CORNER_SOUTH[direction];
			case W: DIRECTION_ROW_INDEX_CORNER_WEST[direction];
		}
	}

	private var width : Int;
	private var height : Int;
	
	private var lastDirection : SnakeDirection = N;
	public var direction(default, set) : SnakeDirection = N;
	public var component(default, set) : SnakeComponent = HEAD;

	public var row(default, set) : Int = 0;
	public var col(default, set) : Int = 0;
	
	public function new(parent : Sprite, frames : Array<Array<Tile>>)
	{
		super(parent, frames);
		width = frames[0][0].width;
		height = frames[0][0].height;
	}

	private inline function updateFrame()
	{
		setFrame((component == BODY_CORNER) ? DIRECTION_ROW_INDEX_BODY_CORNER(lastDirection, direction) : DIRECTION_ROW_INDEX[direction], COMPONENT_COL_INDEX[component]);
	}

	private inline function set_direction(direction : SnakeDirection) : SnakeDirection
	{
		lastDirection = this.direction;
		this.direction = direction;
		updateFrame();
		return direction;
	}

	private inline function set_component(component : SnakeComponent) : SnakeComponent
	{
		this.component = component;
		updateFrame();
		return component;
	}
	
	private inline function set_row(row : Int) : Int
	{
		this.row = row;
		y = row * height;
		return row;
	}
	
	private inline function set_col(col : Int) : Int
	{
		this.col = col;
		x = col * width;
		return col;
	}
}