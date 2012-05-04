package {
import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class TatatWorld extends World {

    public static var _camera:Camera = new Camera();

    private var _masher:Masher;

    private var _tape:Tape = new Tape();

    private var _tapeRollTimer:Number = 0.0;
    private const TAPE_ROLL_DELAY:Number = 0.8;

    private var _board:Board = new Board();
    private var _input:TatatInput = new TatatInput();

    public function TatatWorld() {
        super();
        FP.console.enable();
        add(_camera);
        add(_tape);
        _masher = new Masher(this);
        _masher.x = 160;
        _masher.layer = int.MIN_VALUE;
        add(_masher);
        add(_board);
        add(_input);
        _tape.addMonster(Monster.createMonsterOfType3());
    }


    override public function update():void {
        super.update();
        applyInput();

        _tapeRollTimer += FP.elapsed;
        if (_tapeRollTimer >= TAPE_ROLL_DELAY) {
            _tapeRollTimer =  0;
            _tape.rollTape();
            _board.moveCurrentFigureDown();
        }
    }

    private function applyInput():void {
        if (_input.triggered(Key.DOWN)) {
            _tape.rollTape();
            _board.moveCurrentFigureDown();
            _tapeRollTimer =  0;
        }
    }
}
}
