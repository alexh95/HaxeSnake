package snake;

import h2d.Tile;
import h2d.Bitmap;
import h2d.Sprite;
import hxd.Res;

class SnakeGrid extends Sprite
{
	public var width(default, null) : Int;
	public var height(default, null) : Int;
	
	public function new(parent : Sprite, rows : Int, cols : Int) 
	{
		super(parent);
		var snakeTileBitmapData : Tile = Res.SnakeGridTile.toTile();
		width = snakeTileBitmapData.width * rows;
		height = snakeTileBitmapData.height * cols;
		for (rowIndex in 0...rows)
		{
			for (colIndex in 0...cols)
			{
				var snakeTile = new Bitmap(snakeTileBitmapData, this);
				snakeTile.x = rowIndex * snakeTileBitmapData.width;
				snakeTile.y = colIndex * snakeTileBitmapData.height;
			}
		}
	}
}