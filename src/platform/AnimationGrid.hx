package platform;

import h2d.RenderContext;
import h2d.Sprite;
import h2d.Tile;

/**
 * ...
 * @author AlexH
 */
class AnimationGrid extends Sprite 
{
	private var frameGrid : Array<Array<Tile>>;
	public var frameGridRow : Int = 0;
	public var frameGridCol : Int = 0;
	
	public function new(parent : Sprite, frameGrid : Array<Array<Tile>>) 
	{
		super(parent);
		this.frameGrid = frameGrid;
	}
	
	private inline function getFrame() : Tile 
	{
		return frameGrid[frameGridRow][frameGridCol];
	}
	
	public inline function setFrame(frameGridRow : Int, frameGridCol : Int)
	{
		this.frameGridRow = frameGridRow;
		this.frameGridCol = frameGridCol;
	}
	
	override function draw(ctx : RenderContext) 
	{
		emitTile(ctx, getFrame());
	}
}