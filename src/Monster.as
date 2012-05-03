package {
import flash.display.BitmapData;
import flash.geom.Vector3D;

import net.flashpunk.Entity;
import net.flashpunk.graphics.Image;

import types.SmashedMonster;

public class Monster extends Entity{

    private static var monster1PixelsMap:Vector.<int> = Vector.<int>(
            [
                0,0,0,1,1,0,0,0,
                0,0,1,1,1,1,0,0,
                0,1,1,1,1,1,1,0,
                1,1,0,1,1,0,1,1,
                1,1,1,1,1,1,1,1,
                0,0,1,0,0,1,0,0,
                0,1,0,1,1,0,1,0,
                1,0,1,0,0,1,0,1
            ]
    );

    private static var monster2PixelsMap:Vector.<int> = Vector.<int>(
            [
                0,0,1,0,0,0,0,0,1,0,0,
                0,0,0,1,0,0,0,1,0,0,0,
                0,0,1,1,1,1,1,1,1,0,0,
                0,1,1,0,1,1,1,0,1,1,0,
                1,1,1,1,1,1,1,1,1,1,1,
                1,0,1,1,1,1,1,1,1,0,1,
                1,0,1,0,0,0,0,0,1,0,1,
                0,0,0,1,1,0,1,1,0,0,0
            ]
    );

    private static var monster3PixelsMap:Vector.<int> = Vector.<int>(
            [
                0,0,0,0,1,1,1,1,0,0,0,0,
                0,1,1,1,1,1,1,1,1,1,1,0,
                1,1,1,1,1,1,1,1,1,1,1,1,
                1,1,1,0,0,1,1,0,0,1,1,1,
                1,1,1,1,1,1,1,1,1,1,1,1,
                0,0,0,1,1,0,0,1,1,0,0,0,
                0,0,1,1,0,1,1,0,1,1,0,0,
                1,1,0,0,0,1,1,0,0,0,1,1
            ]
    );




    private var blocks:Vector.<Block> = new Vector.<Block>();
    private var _positionOnTape:int;

    //private var position:Vector3D = new Vector3D();

    private var _figureBlocksIndexes:Vector.<int>;
    private var _pivotBlockIndex:int;

    public static function createMonsterOfType1():Monster {
        return new Monster(8, 8, monster1PixelsMap, BlockColor.RED, Vector.<int>([21,22,23,24]),22);
    }

    public static function createMonsterOfType2():Monster {
        return new Monster(11, 8, monster2PixelsMap, BlockColor.BLUE, Vector.<int>([24,25,26,36]),26);
    }

    public static function createMonsterOfType3():Monster {
        return new Monster(12, 8, monster3PixelsMap, BlockColor.GREEN, Vector.<int>([42,43,48,49]),43);
    }

    public function Monster(width:int, height:int, pixelsMap:Vector.<int>, color:BlockColor, figureBlocksIndexes:Vector.<int>, pivotBlockIndex:int) {

        for (var i:int = 0; i < height; i++) {
            for (var j:int = 0; j < width; j++) {
                if (pixelsMap[i*width+j] != 0) {
                    blocks.push(Block.createBlock(color, j, i, 0));
                }
            }
        }
        _pivotBlockIndex = pivotBlockIndex;
        _figureBlocksIndexes = figureBlocksIndexes;
    }

    override public function added():void {
        super.added();
        for each (var aBlock:Block in blocks) {
            world.add(aBlock);
        }
    }

    public function set positionOnTape(position:int):void {
        _positionOnTape = position;
        for each (var aBlock:Block in blocks) {
            aBlock.setTapePosition(position);
        }
    }

    public function get positionOnTape():int {
        return _positionOnTape;
    }

    public function breakApart():SmashedMonster {
        var figureBlocks:Vector.<Block> = new Vector.<Block>();
        var splinters:Vector.<Block> = blocks.concat();
        positionOnTape = 0;
        for (var i:int = 0; i < _figureBlocksIndexes.length; i++) {
            figureBlocks.push(blocks[_figureBlocksIndexes[i]]);
            splinters.splice(splinters.indexOf(blocks[_figureBlocksIndexes[i]]),1);
        }
        return new SmashedMonster(new Figure(figureBlocks, blocks[_pivotBlockIndex]), splinters);
    }

}
}
