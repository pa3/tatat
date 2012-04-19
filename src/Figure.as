package {
import net.flashpunk.Entity;

public class Figure extends Entity {

    private var _blocks:Vector.<Block>;

    public function Figure(blocks:Vector.<Block>) {
        _blocks = blocks;
    }

    public function moveDown() {
        for each (var aBlock:Block in _blocks) {
            aBlock.position.y++;
        }
    }
    public function moveLeft() {
        for each (var aBlock:Block in _blocks) {
            aBlock.position.x++;
        }
    }
    public function moveRight() {
        for each (var aBlock:Block in _blocks) {
            aBlock.position.x--;
        }
    }

    public function moveUp() {
        for each (var aBlock:Block in _blocks) {
            aBlock.position.y--;
        }
    }

    public function rotate():void {

    }

}
}
