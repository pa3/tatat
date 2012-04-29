package {
import flash.sampler._getInvocationCount;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

public class Tape extends Entity {
    [Embed(source="/resources/tape_n_board.png")]
    private var TapeAndBoardImage:Class;

    private var _tapeRollTimer:Number = 0.0;
    private const TAPE_ROLL_DELAY:Number = 0.5;
    private var _monsters:Vector.<Monster> = new Vector.<Monster>();
    private var _monstersToDelete:Vector.<Monster> = new Vector.<Monster>();
    private var _monstersToAdd:Vector.<Monster> = new Vector.<Monster>();


    public function Tape() {
        graphic = new Image(TapeAndBoardImage);
        layer = int.MAX_VALUE;
        Registry.tape = this;
    }

    override public function update():void {
        super.update();
        addAndInitNewMonsters();
        rollTape();
        getRidOfDeadMonsters();
    }

    private function rollTape():void {
        _tapeRollTimer += FP.elapsed;
        if (_tapeRollTimer >= TAPE_ROLL_DELAY) {
            _tapeRollTimer =  0;
            for each (var m:Monster in _monsters) {
                m.positionOnTape++;
                if (m.positionOnTape > 0) {
                    Registry.masher.smash(m);
                }
            }
//            if (_currentFigure)
//                _currentFigure.moveDown();
        }
    }

    private function addAndInitNewMonsters():void {
        _monsters = _monsters.concat(_monstersToAdd);
        for each (var m:Monster in _monstersToAdd) {
            world.add(m);
            m.positionOnTape = -10;
        }
        _monstersToAdd.length = 0;
    }

    private function getRidOfDeadMonsters():void {
        for each (var m:Monster in _monstersToDelete) {
            if (_monsters.indexOf(m) != -1) {
                _monsters.splice(_monsters.indexOf(m), 1);
                world.remove(m);
            }
        }
        _monstersToDelete.length = 0;
    }


    public function addMonster(m:Monster):void {
        _monstersToAdd.push(m);
    }

    public function removeMonster(m:Monster):void {
        _monstersToDelete.push(m);
    }


    public function spawnMonster():void {

    }
}
}
