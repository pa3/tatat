package {
import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class Board  extends Entity{
    private const WIDTH:int = 8;
    private const HEIGHT:int = 14;

    private var _blocks:Vector.<Block> = new Vector.<Block>(WIDTH*HEIGHT);
    private var _currentFigure:Figure = null;

    public function Board() {
        Registry.board = this;
    }

    private function applyInputs():void {
        if (_currentFigure) {
            if (Input.pressed(Key.LEFT)) {
                _currentFigure.moveLeft();
            }
            if (Input.pressed(Key.RIGHT)) {
                _currentFigure.moveRight();
            }
            if (Input.pressed(Key.DOWN)) {
                _currentFigure.moveDown();
            }
            if (Input.pressed(Key.UP)) {
                _currentFigure.rotate()
                //_currentFigure.rotate();
            }
        }
    }

    public function isPlaceFree(x:int,  y:int):Boolean {
        if (y >= HEIGHT) {
            return true;
        }
        return (_blocks[x+WIDTH*y] == null);
    }

    override public function update():void {
        super.update();
        applyInputs();
    }

    public function addFigure(figure:Figure):void {
        _currentFigure = figure;
    }

    public function figureLanded(figure:Figure):void {
        _currentFigure = null;
        for each (var b:Block in figure.getBlocks()) {
            var position:Point = b.getBoardPosition();
            _blocks[int(position.x)+WIDTH*int(position.y)] = b;
        }
    }

    public function dropFigureDown():void {
        if (_currentFigure) {
            _currentFigure.moveDown();
        }
    }
}
}
