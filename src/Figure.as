package {
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Point;

import flashx.textLayout.operations.FlowOperation;

import net.flashpunk.Entity;
import net.flashpunk.FP;

public class Figure extends Entity {

    private var _blocks:Vector.<Block>;

    private var _blocksRelativePositions:Vector.<Point> = new Vector.<Point>();
    private var _pivotBlockPosition:Point = new Point();


    private var _rotationMatrix:Matrix = new Matrix();
    private var _moveRightMatrix:Matrix = new Matrix();
    private var _moveLeftMatrix:Matrix = new Matrix();
    private var _moveDownMatrix:Matrix = new Matrix();

    public function Figure(blocks:Vector.<Block>, pivotBlock:Block) {
        _blocks = blocks;
        _pivotBlockPosition.x = pivotBlock.getBoardPosition().x;
        _pivotBlockPosition.y = pivotBlock.getBoardPosition().y;
        FP.log(_pivotBlockPosition);

//        _pivotBlockPosition.x = 3;//pivotBlock.position.x;
//        _pivotBlockPosition.y = 13;//pivotBlock.position.y;

        for each (var b:Block in _blocks) {
            _blocksRelativePositions.push(new Point(b.position.x - pivotBlock.position.x, b.position.y - pivotBlock.position.y));
        }

        updateBlocksPositions(_pivotBlockPosition, _blocksRelativePositions);

        _rotationMatrix.rotate(Math.PI/2);
        _moveLeftMatrix.translate(1,0);
        _moveRightMatrix.translate(-1,0);
        _moveDownMatrix.translate(0,-1);
    }

    public function moveDown():void {
        if (!performMovement(_moveDownMatrix)) {
            Registry.board.figureLanded(this);
        }
        FP.log(_pivotBlockPosition);

    }

    public function moveLeft():void {
        performMovement(_moveLeftMatrix);
    }

    public function moveRight():void {
        performMovement(_moveRightMatrix);
    }

    public function rotate():void {
        var newRelativePositions:Vector.<Point> = new Vector.<Point>(_blocksRelativePositions.length);
        for (var i:int = 0; i < _blocksRelativePositions.length; i++) {
            newRelativePositions[i] = _rotationMatrix.transformPoint(_blocksRelativePositions[i]);
            newRelativePositions[i].x = int(newRelativePositions[i].x);
            newRelativePositions[i].y = int(newRelativePositions[i].y);
        }
        if (isBlocksPositionOk(_pivotBlockPosition, newRelativePositions)) {
            updateBlocksPositions(_pivotBlockPosition, newRelativePositions);
            _blocksRelativePositions = newRelativePositions;
        }
    }

    public function getBlocks():Vector.<Block> {
        return _blocks;
    }

    /**
     * Returns true if movement was successful 
     */
    private function performMovement(transformation:Matrix):Boolean {
        var newPivotPointPosition:Point = transformation.transformPoint(_pivotBlockPosition);
        if (isBlocksPositionOk(newPivotPointPosition, _blocksRelativePositions)) {
            updateBlocksPositions(newPivotPointPosition, _blocksRelativePositions);
            _pivotBlockPosition = newPivotPointPosition;
            return true;
        } else {
            return false;
        }
    }

    private function updateBlocksPositions(pivot:Point, relativePositions:Vector.<Point>):void {
        for (var i:int = 0; i < _blocks.length; i++) {
            _blocks[i].setBoardPosition(Math.round(pivot.x + relativePositions[i].x),
                    Math.round(pivot.y + relativePositions[i].y));
        }
    }


    private function isBlocksPositionOk(pivot:Point, relativePositions:Vector.<Point>):Boolean {
        for each (var aPosition:Point in relativePositions) {
            if ( (pivot.x + aPosition.x > 7) || (pivot.x + aPosition.x < 0)) {
                return false;
            }
            if (pivot.y + aPosition.y < 0) {
                return false;
            }
            
            if (!Registry.board.isPlaceFree(int(pivot.x + aPosition.x),int(pivot.y + aPosition.y))) {
                return false;
            }
        }
        return true;
    }


}
}
