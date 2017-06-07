package snake;

import h2d.Sprite;
import h2d.Tile;
import platform.GridAnimation;
import snake.SnakeDirection;

enum SnakeComponent
{
	HEAD;
	BODY_I;
	BODY_CORNER;
	TAIL;
}

class SnakeSegment extends GridAnimation
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
		N => 0,
		E => 1,
		S => 0,
		W => 2,
	];
	
	private static var DIRECTION_ROW_INDEX_CORNER_EAST : Map<SnakeDirection, Int> = [
		N => 3,
		E => 0,
		S => 2,
		W => 0,
	];
	
	private static var DIRECTION_ROW_INDEX_CORNER_SOUTH : Map<SnakeDirection, Int> = [
		N => 0,
		E => 0,
		S => 0,
		W => 3,
	];
	
	private static var DIRECTION_ROW_INDEX_CORNER_WEST : Map<SnakeDirection, Int> = [
		N => 0,
		E => 0,
		S => 1,
		W => 0,
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
		if (this.direction != direction)
		{
			lastDirection = this.direction;
			this.direction = direction;
			updateFrame();
		}
		return direction;
	}

	private inline function set_component(component : SnakeComponent) : SnakeComponent
	{
		if (this.component != component)
		{
			this.component = component;
			updateFrame();
		}
		return component;
	}
	
}