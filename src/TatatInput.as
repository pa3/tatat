package {
import flash.utils.Dictionary;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.utils.Input;

public class TatatInput extends Entity {

    private const DOWN_KEY_DELAY:Number = 0.1;
    private const FIRST_PRESS_DELAY:Number = 0.5;

    private var _holdTimeByKey:Dictionary = new Dictionary();

    public function TatatInput() {
        Registry.input = this;
    }

    public function triggered(key:int):Boolean {
        var keyInfo:PressedKeyInfo = _holdTimeByKey[key];
        if (keyInfo != undefined && keyInfo.holdTime <= 0) {
			keyInfo.holdTime = _holdTimeByKey[key].firstPress ? FIRST_PRESS_DELAY : DOWN_KEY_DELAY;
			keyInfo.firstPress = false;
            return true;
        }
        return false;
    }

    override public function update():void {
        super.update();

        var lastPressedKey:int = Input.lastKey;
        if (Input.pressed(lastPressedKey)) {
            _holdTimeByKey[lastPressedKey] = new PressedKeyInfo();
        } else if (Input.released(lastPressedKey)) {
            delete _holdTimeByKey[lastPressedKey];
        } else {
            if (_holdTimeByKey[lastPressedKey] != undefined) {
                _holdTimeByKey[lastPressedKey].holdTime -= FP.elapsed;
            }
        }
    }
}
}

class PressedKeyInfo {
	public var firstPress:Boolean = true;
	public var holdTime:Number = 0.0;
}
