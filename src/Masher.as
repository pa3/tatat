package {
import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

public class Masher extends Entity{

    [Embed(source="/resources/masher.png")]
    private var MasherImage:Class;

    private var state:MasherState = MasherState.WAITING;
    private var currentSpeed:Number = 0.0;

    private const MOVE_DOWN_INITIAL_VELOCITY:Number = 100;
    private const MOVE_DOWN_ACCELERATION:Number = 1000;
    private const MOVE_UP_VELOCITY:Number = -50;

    private const BOTTOM_POSITION_Y:int = 40;
    private const UPPER_POSITION_Y:int = -50;


    public function Masher() {
        graphic = new Image(MasherImage);
        y = UPPER_POSITION_Y;
    }

    public function smash():void {
        if (state == MasherState.WAITING) {
            state = MasherState.MOVING_DOWN;
            currentSpeed = MOVE_DOWN_INITIAL_VELOCITY;
        }
    }


    override public function update():void {
        super.update();

        y+=FP.elapsed*currentSpeed;

        switch (state) {
            case MasherState.MOVING_DOWN:
                    currentSpeed+=FP.elapsed*MOVE_DOWN_ACCELERATION;
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
}
}

