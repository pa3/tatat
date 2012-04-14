package {
import flash.sampler._getInvocationCount;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

public class TapeAndBoard extends Entity {
    [Embed(source="/resources/tape_n_board.png")]
    private var TapeAndBoardImage:Class;
    public function TapeAndBoard() {
        graphic = new Image(TapeAndBoardImage);
        layer = int.MAX_VALUE;
    }

}
}
