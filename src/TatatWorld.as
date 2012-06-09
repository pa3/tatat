package {
	import flash.geom.Vector3D;

	import net.flashpunk.FP;
import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class TatatWorld extends World {

    public static var _camera:Camera = new Camera();

    private var _tape:Tape = new Tape();

    private var _tapeRollTimer:Number = 0.0;


    private var _board:Board = new Board();
    private var _input:TatatInput = new TatatInput();

    public function TatatWorld() {
		super();
		add(_camera);
		add(_tape);
		var masher:Masher = new Masher();
		masher.x = 160;
		masher.layer = int.MIN_VALUE;
		add(masher);
		add(_board);
		add(_input);
		add(new FallenBlocksCollector());
		_tape.addMonster(Monster.createMonster(5));
	}


    override public function update():void {
        super.update();
        applyInput();

        _tapeRollTimer += FP.elapsed;
        if (_tapeRollTimer >= Registry.tapeRollDelay) {
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
