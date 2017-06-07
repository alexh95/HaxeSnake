package snake;

import h2d.Bitmap;
import h2d.Tile;
import h2d.Drawable;
import h2d.Sprite;
import hxd.Res;

class Food extends Drawable
{
	private var width : Int;
	private var height : Int;

	public var offsetX : Int;
	public var offsetY : Int;

	public var row(default, set) : Int;
	public var col(default, set) : Int;

	public function new(parent : Sprite, offsetX : Int = 0, offsetY : Int = 0)
	{
		super(parent);
		this.offsetX = offsetX;
		this.offsetY = offsetY;

		var pball : Bitmap = new Bitmap(Res.pball.toTile(), this);
		width = pball.tile.width;
		height = pball.tile.height;
	}

	private inline function set_row(row : Int) : Int
	{
		this.row = row;
		y = offsetY + row * height;
		return row;
	}

	private inline function set_col(col : Int) : Int
	{
		this.col = col;
		x = offsetX + col * width;
		return col;
	}
}