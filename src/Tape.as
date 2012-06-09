package {
import flash.sampler._getInvocationCount;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

public class Tape extends Entity {
    [Embed(source="/resources/tape_n_board.png")]
    private var TapeAndBoardImage:Class;

    private var _monsters:Vector.<Monster> = new Vector.<Monster>();
    private var _monstersToSmash:Vector.<Monster> = new Vector.<Monster>();
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
        getRidOfDeadMonsters();
    }

    public function rollTape():void {
        for each (var m:Monster in _monsters) {
            m.positionOnTape++;
            if (m.positionOnTape > 0) {
                _monstersToSmash.push(m);
                Registry.masher.smash(m);
                spawnMonster();
            }
        }
        for each (var smashed:Monster in _monstersToSmash) {
            if (_monsters.indexOf(smashed) != -1) {
                _monsters.splice(_monsters.indexOf(smashed), 1);
            }
        }
        FP.log(_monstersToSmash.length);

    }

    private function addAndInitNewMonsters():void {

        for each (var m:Monster in _monstersToAdd) {
            world.add(m);
            m.positionOnTape = -20;
        }
        _monsters = _monsters.concat(_monstersToAdd);
        _monstersToAdd.length = 0;
    }

    private function getRidOfDeadMonsters():void {
        for each (var m:Monster in _monstersToDelete) {
            if (_monstersToSmash.indexOf(m) != -1) {
                _monstersToSmash.splice(_monstersToSmash.indexOf(m), 1);
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

	public function getMonstersOnTape():Vector.<Monster> {
		return _monsters;
	}

    private function spawnMonster():void {
        addMonster(Monster.createMonster(MathUtil.randomInt(0,5)));
    }
    

}
}
