package {
import flash.display.Sprite;

import net.flashpunk.Engine;
import net.flashpunk.FP;

[SWF(width="320", height="400", backgroundColor="000000")]
public class Tatat extends Engine{
    public function Tatat() {
        super(320,400,60,false);
    }
    override public function init():void {
        FP.screen.color = 0x0;
        //FP.screen.scale = 2;
        FP.world=new TatatWorld();
    }
}
}


