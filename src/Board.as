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

            if (Registry.input.triggered(Key.LEFT)) {
                _currentFigure.moveLeft();
            }
            if (Registry.input.triggered(Key.RIGHT)) {
                _currentFigure.moveRight();
            }
            if (Registry.input.triggered(Key.UP)) {
                _currentFigure.rotate()
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

    private function checkForFilledLines():void {

        for (var i:int = 0; i < HEIGHT; i++) {
            if (isLineFilled(i)) {
                for (var j:int = 0; j < WIDTH; j++) {
                    _blocks[i*WIDTH+j].startFalling()
                    _blocks[i*WIDTH+j] = null;
                }
            }
        }
    }

    private function isLineFilled(lineNumber:int):Boolean {
        var filled:Boolean = true;
        for (var j:int = 0; j < WIDTH; j++) {
            if (_blocks[lineNumber*WIDTH+j] == null) {
                filled = false;
                break;
            }
        }
        return filled;
    }

    public function addFigure(figure:Figure):void {
        _currentFigure = figure;
    }

    public function figureLanded(figure:Figure):void {
        _currentFigure = null;
        // TODO: if figure is out of the board - go to game over state
        for each (var b:Block in figure.getBlocks()) {
            var position:Point = b.getBoardPosition();
            _blocks[int(position.x)+WIDTH*int(position.y)] = b;
        }
        checkForFilledLines();
    }

    public function moveCurrentFigureDown():void {
        if (_currentFigure) {
            _currentFigure.moveDown();
        }
    }
}
}
