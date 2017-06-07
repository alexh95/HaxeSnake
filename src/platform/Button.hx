package platform;

import h2d.Font;
import h2d.RenderContext;
import h2d.Sprite;
import h2d.Text;
import h2d.Tile;
import h2d.css.Style;
import hxd.Event;
import hxd.Res;
import hxd.res.FontBuilder;

enum ButtonState
{
	DEFAULT;
	HOVERING;
	CLICKING;
}

class Button extends Sprite
{
	private var state(default, set) : ButtonState;
	private var currentTile : Tile;
	private var clicking: Bool;
	
	public var width : Int;
	public var height : Int;

	public var text(default, null) : Text;
	public var defaultTile(default, set) : Tile;
	public var hoveringTile(default, set) : Tile;
	public var clickingTile(default, set) : Tile;

	public var onClickDown : Void -> Void = function() {};
	public var onClickUp : Void -> Void = function() {};

	public function new(parent : Sprite, font : Font, buttonText : String, width : Int, height : Int)
	{
		super(parent);
		state = DEFAULT;

		this.width = width;
		this.height = height;

		text = new Text(font, this);
		text.text = buttonText;
		text.setPos((width - text.textWidth) >> 1, (height - text.textHeight) >> 1);

		this.defaultTile = Tile.fromColor(0xFF0000, width, height);
		this.hoveringTile = Tile.fromColor(0x0000FF, width, height);
		this.clickingTile = Tile.fromColor(0x00FF00, width, height);
		
		clicking = false;

		getScene().addEventListener(function(event : Event)
		{
			if (event.kind == EMove || event.kind == EPush || event.kind == ERelease)
			{
				var ex = event.relX;
				var ey = event.relY;
				var inside = x <= ex && ex <= x + width && y <= ey && ey <= y + height;
				var leftButton = event.button == 0;

				switch event.kind
				{
				case EMove:
					if (inside)
						{
							if (clicking) state = CLICKING;
							else state = HOVERING;
						}
						else
						{
							state = DEFAULT;
						}
				case EPush:
						if (inside && leftButton)
						{
							state = CLICKING;
							onClickDown();
							clicking = true;
						}
				case ERelease:
						if (inside && leftButton && clicking)
						{
							state = HOVERING;
							onClickUp();
						}
						clicking = false;
				default:
				}
			}
		});
	};

	private inline function set_defaultTile(defaultTile : Tile) : Tile
	{
		this.defaultTile = defaultTile;
		state = state;
		return defaultTile;
	}

	private inline function set_hoveringTile(hoveringTile : Tile) : Tile
	{
		this.hoveringTile = hoveringTile;
		state = state;
		return hoveringTile;
	}

	private inline function set_clickingTile(clickingTile : Tile) : Tile
	{
		this.clickingTile = clickingTile;
		state = state;
		return clickingTile;
	}

	private inline function set_state(state : ButtonState) : ButtonState
	{
		this.state = state;
		switch state 
		{
		case DEFAULT: currentTile = defaultTile;
		case HOVERING: currentTile = hoveringTile;
		case CLICKING: currentTile = clickingTile;
		}
	return state;
	}

	override function draw(ctx : RenderContext)
	{
		emitTile(ctx, currentTile);
	}
}