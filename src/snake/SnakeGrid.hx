package snake;

import h2d.Drawable;
import h2d.Tile;
import h2d.Bitmap;
import h2d.Sprite;
import hxd.Res;

class SnakeGrid extends Drawable
{
	
	public var width(default, null) : Int;
	public var height(default, null) : Int;
	
	public function new(parent : Sprite, rows : Int, cols : Int) 
	{
		super(parent);
		var snakeGridTile : Tile = Res.SnakeGridTile.toTile();
		width = snakeGridTile.width * rows;
		height = snakeGridTile.height * cols;
		for (rowIndex in 0...rows)
		{
			for (colIndex in 0...cols)
			{
				var snakeTile = new Bitmap(snakeGridTile, this);
				snakeTile.x = rowIndex * snakeGridTile.width;
				snakeTile.y = colIndex * snakeGridTile.height;
			}
		}
	}
	
}