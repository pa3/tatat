package {
import flash.display.BitmapData;
import flash.geom.Vector3D;

import flashx.textLayout.operations.FlowOperation;

import net.flashpunk.FP;

import net.flashpunk.World;

public class TatatWorld extends World {

    public static var _camera:Camera = new Camera();

    private var monsters:Vector.<Monster> = new Vector.<Monster>();
    private var tapeRollTimer:Number = 0;
    private var TAPE_ROLL_DELAY:Number = 0.5;


    private var _masher:Masher = new Masher();

    public function TatatWorld() {
        super();

        FP.console.enable();

        add(_camera);

        add(new TapeAndBoard());

        _masher.x = 160;
        _masher.layer = int.MIN_VALUE;
        add(_masher);

        addMonster(Monster.createMonsterOfType1());
//        addMonster(Monster.createMonsterOfType2());
//        addMonster(Monster.createMonsterOfType3());
    }

    private function addMonster(m:Monster):void {
        add(m);
        monsters.push(m);
        m.positionOnTape = -10;
    }


    override public function update():void {
        super.update();
        tapeRollTimer -= FP.elapsed;
        if (tapeRollTimer <= 0) {
            tapeRollTimer = TAPE_ROLL_DELAY;
            rollTape();
        }

    }

    private function rollTape():void {
        var monsterToRemove:Monster = null;
        for each (var aMonster:Monster in monsters) {
            aMonster.positionOnTape++;
            if (aMonster.positionOnTape > 0) {
                _masher.smash();
                remove(aMonster);
                monsterToRemove = aMonster;
            }
        }
        if (monsterToRemove != null) {
            monsters.splice(monsters.indexOf(monsterToRemove),1);
        }
    }

}
}
