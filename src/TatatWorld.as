package {
import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class TatatWorld extends World {

    public static var _camera:Camera = new Camera();

    private var _masher:Masher;

    private var _tape:Tape = new Tape();

    public function TatatWorld() {
        super();
        FP.console.enable();
        add(_camera);
        add(_tape);

        _masher = new Masher(this);
        _masher.x = 160;
        _masher.layer = int.MIN_VALUE;
        add(_masher);

        add(new Board());

        _tape.addMonster(Monster.createMonsterOfType1());
    }


    override public function update():void {
        super.update();
    }

//    public function addFigure(f:Figure):void {
//        _currentFigure = f;
//        f.init(this);
//        add(f);
////        _currentFigure.moveDown();
////        _currentFigure.moveDown();
////        _currentFigure.moveLeft();
////        _currentFigure.moveLeft();
//    }
//
//    public function itIsTimeToSpawnNewMonster():void {
//        _currentFigure = null;
////        if (_monsters.length == 0) {
////            addMonster(Monster.createMonsterOfType3())
////        }
//    }
}
}
