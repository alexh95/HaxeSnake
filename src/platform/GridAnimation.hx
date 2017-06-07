package platform;

import h2d.RenderContext;
import h2d.Sprite;
import h2d.Tile;
import platform.GridBitmap;

class GridAnimation extends GridBitmap 
{
	
	public var tiles(default, null) : Array<Array<Tile>>;
	
	public var rows(default, null) : Int;
	public var cols(default, null) : Int;
	
	public var tilesRow(default, set) : Int = 0;
	public var tilesCol(default, set) : Int = 0;
	
	public function new(parent : Sprite, tiles : Array<Array<Tile>>) 
	{
		super(tiles[0][0], parent);
		rows = tiles.length;
		cols = tiles[0].length;
		this.tiles = tiles;
		setFrame(0, 0);
	}
	
	public inline function setFrame(tilesRow : Int, tilesCol : Int)
	{
		this.tilesRow = tilesRow;
		this.tilesCol = tilesCol;
		tile = tiles[this.tilesRow][this.tilesCol];
	}
	
	private inline function set_tilesRow(tilesRow : Int) : Int
	{
		if (this.tilesRow != tilesRow)
		{
			this.tilesRow = tilesRow;
			setFrame(this.tilesRow, tilesCol);
		}
		return this.tilesRow;
	}
	
	private inline function set_tilesCol(tilesCol : Int) : Int
	{
		if (this.tilesCol != tilesCol)
		{
			this.tilesCol = tilesCol;
			setFrame(tilesRow, this.tilesCol);	
		}
		return this.tilesCol;
	}
	
}