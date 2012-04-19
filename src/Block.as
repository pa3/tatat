package {
import flash.geom.Matrix3D;
import flash.geom.Vector3D;

import mx.printing.FlexPrintJob;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

public class Block extends Entity{

    private var camera:Camera = null;

    private var _position:Vector3D;
    private var velocity:Vector3D = new Vector3D();
    private var _movement:Vector3D = new Vector3D();
    private const GRAVITY:Number = 20;

    [Embed(source="/resources/red_block.png")]
    private static var RedBlockImage:Class;
    [Embed(source="/resources/blue_block.png")]
    private static var BlueBlockImage:Class;
    [Embed(source="/resources/green_block.png")]
    private static var GreenBlockImage:Class;

    private var state:BlockState = BlockState.PART_OF_THE_MONSTER;

    public static function createBlock(color:BlockColor, boardX:int,  boardY:int,  boardZ:int):Block {
        switch (color) {
            case BlockColor.RED:
                return new Block(new Image(RedBlockImage), boardX, boardY, boardZ);
                break;
            case BlockColor.GREEN:
                return new Block(new Image(GreenBlockImage), boardX, boardY, boardZ);
                break;
            case BlockColor.BLUE:
                return new Block(new Image(BlueBlockImage), boardX, boardY, boardZ);
                break;
        }
        return null;
    }

    public function Block(skin:Image, boardX:int, boardY:int, boardZ:int) {
        _position = new Vector3D(boardX, boardY, boardZ, 0);
        graphic = skin;
        camera = TatatWorld._camera;
    }


    override public function update():void {
        super.update();

        switch (state) {
            case BlockState.PART_OF_THE_MONSTER:
                break;
            case BlockState.FREE_MODE:
                velocity.y += FP.elapsed*GRAVITY;
                _movement.x = velocity.x;
                _movement.y = velocity.y;
                _movement.z = velocity.z;
                _movement.scaleBy(FP.elapsed);
                _position = position.add(_movement);
                break;
        }

        
        var cameraSpacePosition:Vector3D = camera.worldPositionToScreenPoint(position);
        x = cameraSpacePosition.x + 235;
        y = cameraSpacePosition.y + 99;

        // closest blocks should be drawn last
        layer = -cameraSpacePosition.z;

    }

    public function setBoardZ(z:int):void {
        position.z = z;
    }

    public function get position():Vector3D {
        return _position;
    }

    public function startFalling(newVelocity:Vector3D):void {
        state = BlockState.FREE_MODE;
        velocity = newVelocity.clone();
    }
}
}
