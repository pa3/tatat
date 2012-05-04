package {
import flash.utils.Dictionary;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.utils.Input;

public class TatatInput extends Entity {

    private var DOWN_KEY_DELAY:Number = 0.1;

    private var _holdTimeByKey:Dictionary = new Dictionary();

    public function TatatInput() {
        Registry.input = this;
    }

    public function triggered(key:int):Boolean {
        var timeHeld:Number = _holdTimeByKey[key];
        if (timeHeld != undefined && timeHeld <= 0) {
            _holdTimeByKey[key] = DOWN_KEY_DELAY;
            return true;
        }
        return false;
    }

    override public function update():void {
        super.update();

        var lastPressedKey:int = Input.lastKey;
        if (Input.pressed(lastPressedKey)) {
            _holdTimeByKey[lastPressedKey] = 0;
        } else if (Input.released(lastPressedKey)) {
            delete _holdTimeByKey[lastPressedKey];
        } else {
            if (_holdTimeByKey[lastPressedKey] != undefined) {
                _holdTimeByKey[lastPressedKey] -= FP.elapsed;
            }
        }
    }
}
}
