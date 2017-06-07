package platform;
import h2d.Bitmap;
import h2d.Sprite;
import h2d.Tile;

class GridBitmap extends Bitmap
{
	
	public var row(default, set) : Int;
	public var col(default, set) : Int;

	public function new(tile : Tile, parent : Sprite) 
	{
		super(tile, parent);
	}
	
	private inline function set_row(row : Int) : Int
	{
		this.row = row;
		y = row * tile.height;
		return row;
	}

	private inline function set_col(col : Int) : Int
	{
		this.col = col;
		x = col * tile.width;
		return col;
	}
	
}