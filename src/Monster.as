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
                1,1,0,0,0,1,1,0,0,0,1,1,
            ]
    );




    private var blocks:Vector.<Block> = new Vector.<Block>();
    private var _positionOnTape:int;

    //private var position:Vector3D = new Vector3D();

    public static function createMonsterOfType1():Monster {
        return new Monster(8, 8, monster1PixelsMap, BlockColor.RED);
    }

    public static function createMonsterOfType2():Monster {
        return new Monster(11, 8, monster2PixelsMap, BlockColor.BLUE);
    }

    public static function createMonsterOfType3():Monster {
        return new Monster(12, 8, monster3PixelsMap, BlockColor.GREEN);
    }

    public function Monster(width:int, height:int, pixelsMap:Vector.<int>, color:BlockColor) {
        for (var i:int = 0; i < width; i++) {
            for (var j:int = 0; j < height; j++) {
                if (pixelsMap[i*width+j] != 0) {
                    blocks.push(Block.createBlock(color, j, i, 0));
                }
            }
        }
    }

    override public function added():void {
        super.added();
        for each (var aBlock:Block in blocks) {
            world.add(aBlock);
        }
    }

    public function set positionOnTape(position:int):void {
        _positionOnTape = position
        for each (var aBlock:Block in blocks) {
            aBlock.setBoardZ(position);
        }
    }

    public function get positionOnTape():int {
        return _positionOnTape;
    }

    public function breakApart():SmashedMonster {
        var figureBlocks:Vector.<Block> = blocks.splice(21, 4);
        return new SmashedMonster(new Figure(figureBlocks), blocks);
    }

}
}
