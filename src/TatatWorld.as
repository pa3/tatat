package {
import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class TatatWorld extends World {

    public static var _camera:Camera = new Camera();
    private var _monsters:Vector.<Monster> = new Vector.<Monster>();
    private var _monstersToDelete:Vector.<Monster> = new Vector.<Monster>();
    private var _monstersToAdd:Vector.<Monster> = new Vector.<Monster>();

    private var _masher:Masher;

    private var _tapeRollTimer:Number = 0.0;
    private const TAPE_ROLL_DELAY:Number = 0.1;

    private var _currentFigure:Figure;

    private var _blocksOnBoard:Vector.<Block>;


    public function TatatWorld() {
        super();
        FP.console.enable();
        add(_camera);
        add(new TapeAndBoard());

        _masher = new Masher(this);
        _masher.x = 160;
        _masher.layer = int.MIN_VALUE;
        add(_masher);

        addMonster(Monster.createMonsterOfType1());
    }

    private function addMonster(m:Monster):void {
        _monstersToAdd.push(m);
    }

    public function removeMonster(m:Monster):void {
        _monstersToDelete.push(m);
    }
    
    override public function update():void {
        super.update();
        addAndInitNewMonsters();
        applyInputs();
        rollTape();
        getRidOfDeadMonsters();
    }

    private function applyInputs():void {
        if (_currentFigure) {
            if (Input.pressed(Key.LEFT)) {
                _currentFigure.moveLeft();
            }
            if (Input.pressed(Key.RIGHT)) {
                _currentFigure.moveRight();
            }
            if (Input.pressed(Key.DOWN)) {
                _currentFigure.moveDown();
            }
            if (Input.pressed(Key.UP)) {
                _currentFigure.moveUp();
            }
        }
    }

    private function addAndInitNewMonsters():void {
        _monsters = _monsters.concat(_monstersToAdd);
        for each (var m:Monster in _monstersToAdd) {
            add(m);
            m.positionOnTape = -10;
        }
        _monstersToAdd.length = 0;
    }

    private function getRidOfDeadMonsters():void {
        for each (var m:Monster in _monstersToDelete) {
            if (_monsters.indexOf(m) != -1) {
                _monsters.splice(_monsters.indexOf(m), 1);
                remove(m);
            }
        }
        _monstersToDelete.length = 0;
    }

    private function rollTape():void {
        _tapeRollTimer += FP.elapsed;
        if (_tapeRollTimer >= TAPE_ROLL_DELAY) {
            _tapeRollTimer =  0;
            for each (var m:Monster in _monsters) {
                m.positionOnTape++;
                if (m.positionOnTape > 0) {
                    _masher.smash(m);
                }
            }
//            if (_currentFigure)
//                _currentFigure.moveDown();
        }
    }

    public function addFigure(f:Figure):void {
        _currentFigure = f;
        add(f);
        _currentFigure.moveDown();
        _currentFigure.moveDown();
        _currentFigure.moveLeft();
        _currentFigure.moveLeft();
    }

}
}
