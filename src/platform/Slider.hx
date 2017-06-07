package platform;

import h2d.RenderContext;
import h2d.Sprite;
import h2d.Tile;
import hxd.Event;

/**
 * ...
 * @author AlexH
 */
enum SliderState 
{
	DEFAULT;
	HOVERING;
	DRAGGING;
}
 
class Slider extends Sprite
{
	
	public var width : Int;
	public var height : Int;
	
	public var value(default, set) : Float;

	private var dragging : Bool;
	
	private var sliderTile(default, set) : Tile;
	private var sliderState(default, set) : SliderState;
	private var sliderCursorTile(default, set) : Tile;
	
	private var sliderCursorDefaultTile(default, set) : Tile;
	private var sliderCursorHoveringTile(default, set) : Tile;
	private var sliderCursorDraggingTile(default, set) : Tile;
	
	public var onValueChange : Float -> Float -> Void;
	
	public function new(parent : Sprite, width : Int, height : Int)
	{
		super(parent);
		sliderState = DEFAULT;
		
		this.width = width;
		this.height = height;
		
		this.sliderTile = Tile.fromColor(0xFF0000, width, height);
		this.sliderCursorDefaultTile = Tile.fromColor(0xFF0000, height, 3 * height);
		this.sliderCursorHoveringTile = Tile.fromColor(0x0000FF, height, 3 * height);
		this.sliderCursorDraggingTile = Tile.fromColor(0x00FF00, height, 3 * height);
		this.sliderCursorTile.dy = -height;
		
		value = 0.5;
		dragging = false;
		
		getScene().addEventListener(function(event : Event)
		{
			if (event.kind == EMove || event.kind == EPush || event.kind == ERelease)
			{
				var ex = event.relX;
				var ey = event.relY;
				var inside = x <= ex && ex <= x + width && y - height <= ey && ey <= y + 2 * height;
				var leftButton = event.button == 0;
				
				switch event.kind
				{
					case EMove:
						if (dragging)
						{
							value = (ex - x) / width;
							trace(value);
						}
						else if (inside)
						{
							sliderState = HOVERING;
						}
						else 
						{
							sliderState = DEFAULT;
						}
					case EPush:
						if (inside && leftButton)
						{
							dragging = true;
							value = (ex - x) / width;
							sliderState = DRAGGING;
						}
					case ERelease:
						if (dragging && leftButton)
						{
							dragging = false;
							sliderState = if (inside) HOVERING else DEFAULT;
						}
					default:
				}
			}
		});
	}

	private inline function set_value(value : Float) : Float
	{
		if (value < 0) value = 0;
		else if (value > 1) value = 1;
		
		this.sliderCursorTile.dx = cast width * (value) - (height >> 1);
		
		if (onValueChange != null)
		{
			onValueChange(value, this.value);
		}
		
		this.value = value;
		return this.value;
	}
	
	private inline function set_sliderState(sliderState : SliderState) : SliderState
	{
		this.sliderState = sliderState;
		switch this.sliderState
		{
			case DEFAULT: sliderCursorTile = sliderCursorDefaultTile;
			case HOVERING: sliderCursorTile = sliderCursorHoveringTile;
			case DRAGGING: sliderCursorTile = sliderCursorDraggingTile;
		}
		return this.sliderState;
	}
	
	private inline function set_sliderCursorTile(sliderCursorTile : Tile) : Tile
	{
		if (this.sliderCursorTile != null)
		{
			sliderCursorTile.dx = this.sliderCursorTile.dx;
			sliderCursorTile.dy = this.sliderCursorTile.dy;
		}
		this.sliderCursorTile = sliderCursorTile;
		return this.sliderCursorTile;
	}
	
	private inline function set_sliderTile(sliderTile : Tile) : Tile
	{
		this.sliderTile = sliderTile;
		return this.sliderTile;
	}
	
	private inline function set_sliderCursorDefaultTile(sliderCursorDefaultTile : Tile) : Tile
	{
		this.sliderCursorDefaultTile = sliderCursorDefaultTile;
		sliderState = sliderState;
		return this.sliderCursorDefaultTile;
	}
	
	private inline function set_sliderCursorHoveringTile(sliderCursorHoveringTile : Tile) : Tile
	{
		this.sliderCursorHoveringTile  = sliderCursorHoveringTile ;
		sliderState = sliderState;
		return this.sliderCursorHoveringTile ;
	}
	
	private inline function set_sliderCursorDraggingTile(sliderCursorDraggingTile : Tile) : Tile
	{
		this.sliderCursorDraggingTile = sliderCursorDraggingTile;
		sliderState = sliderState;
		return this.sliderCursorDraggingTile;
	}
	
	override function draw(ctx : RenderContext)
	{
		emitTile(ctx, sliderTile);
		emitTile(ctx, sliderCursorTile);
	}
	
}
