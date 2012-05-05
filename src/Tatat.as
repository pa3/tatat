package {
import flash.display.Sprite;

import net.flashpunk.Engine;
import net.flashpunk.FP;

[SWF(width="360", height="400", backgroundColor="000000")]
public class Tatat extends Engine{
    public function Tatat() {
        super(360,400,60,false);
    }
    override public function init():void {
        FP.screen.color = 0x0;
        FP.world=new TatatWorld();
    }
}
}


