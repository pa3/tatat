package {
import flash.geom.Vector3D;

import mx.printing.FlexPrintJob;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

import types.SmashedMonster;

public class Masher extends Entity {

    [Embed(source="/resources/masher.png")]
    private var MasherImage:Class;

    private var state:MasherState = MasherState.WAITING;
    private var currentSpeed:Number = 0.0;

    private const MOVE_DOWN_INITIAL_VELOCITY:Number = 500;
    private const MOVE_DOWN_ACCELERATION:Number = 5000;
    private const MOVE_UP_VELOCITY:Number = -250;

    private const BOTTOM_POSITION_Y:int = 40;
    private const UPPER_POSITION_Y:int = -50;

    private var _monstersHolder:TatatWorld;

    private var _monsterToSmash:Monster;
    private var _movingDownTimer:Number;
    
    private var _monsterDestroyed:Boolean = false;

    public function Masher(monstersHolder:TatatWorld) {
        _monstersHolder = monstersHolder;
        graphic = new Image(MasherImage);
        y = UPPER_POSITION_Y;
        Registry.masher = this;
    }

    public function smash(monsterToSmash:Monster):void {
        if (state == MasherState.WAITING) {
            state = MasherState.MOVING_DOWN;
            currentSpeed = MOVE_DOWN_INITIAL_VELOCITY;
            _movingDownTimer = 0;
            _monsterToSmash = monsterToSmash;
            _monsterDestroyed = false;
        }
    }


    override public function update():void {
        super.update();

        y += FP.elapsed * currentSpeed;

        switch (state) {
            case MasherState.MOVING_DOWN:
                currentSpeed += FP.elapsed * MOVE_DOWN_ACCELERATION;
                _movingDownTimer += FP.elapsed;
                if (isTimeToSmash()) {
                    smashMonster();
                }
                if (y > BOTTOM_POSITION_Y) {
                    y = BOTTOM_POSITION_Y;
                    currentSpeed = MOVE_UP_VELOCITY;
                    state = MasherState.MOVING_UP;
                }
                break;
            case MasherState.MOVING_UP:
                if (y < UPPER_POSITION_Y) {
                    currentSpeed = 0.0;
                    y = UPPER_POSITION_Y;
                    state = MasherState.WAITING;
                }
                break;
        }
    }

    private function smashMonster():void {
        _monsterDestroyed = true;
        var smashedMonster:SmashedMonster = _monsterToSmash.breakApart();
        Registry.board.addFigure(smashedMonster.figure);
        Registry.tape.removeMonster(_monsterToSmash);
        for each (var aBlock:Block in smashedMonster.splinters) {
            aBlock.startFalling();
        }
    }

    private function isTimeToSmash():Boolean {
        // TODO: get rid of time and user masher position instead
        return _movingDownTimer > 0.1 && !_monsterDestroyed;
    }
}
}

