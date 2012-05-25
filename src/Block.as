package {
import flash.geom.Matrix3D;
import flash.geom.Point;
import flash.geom.Vector3D;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

public class Block extends Entity{

	private const GRAVITY:Number = 20;

    private var _camera:Camera = null;
    private var _position:Vector3D;
    private var _velocity:Vector3D = new Vector3D();
	private var _isFalling:Boolean = false;

    public static function createBlock(color:BlockColor, boardX:int,  boardY:int,  boardZ:int):Block {
			return new Block(new Image(color.spriteClass), boardX, boardY, boardZ);
    }

    public function Block(skin:Image, boardX:int, boardY:int, boardZ:int) {
        _position = new Vector3D(boardX, boardY, boardZ, 0);
        graphic = skin;
        _camera = TatatWorld._camera;
    }

    override public function update():void {
		super.update();

		if (_isFalling) {
			_velocity.y += FP.elapsed*GRAVITY;
			var movement:Vector3D = _velocity.clone();
			movement.scaleBy(FP.elapsed);
			_position = position.add(movement);
		}

		var cameraSpacePosition:Vector3D = _camera.worldPositionToScreenPoint(position);
		x = cameraSpacePosition.x + 238;
		y = cameraSpacePosition.y + 94;

		// closest blocks should be drawn last
		layer = -cameraSpacePosition.z;

	}

    public function setTapePosition(z:int):void {
        position.z = z;
    }
    
    public function setBoardPosition(x:int,  y:int):void {
        position.x = x+2;
        position.y = 22-y;
    }
    public function getBoardPosition():Point {
        return new Point(position.x-2,22 - position.y);
    }

    public function get position():Vector3D {
        return _position;
    }

    public function set position(value:Vector3D):void {
        _position = value.clone();
    }

    public function startFalling(newVelocity:Vector3D = null):void {
        if (newVelocity == null) {
            newVelocity = new Vector3D(Math.random() * 2 - 1, Math.random() * 1 + 12, Math.random() * 1 - 2);
        }
		_isFalling = true;
        _velocity = newVelocity.clone();
		Registry.blocksCollector.monitorBlock(this);
    }
}
}
