package types {
public class SmashedMonster {
    private var _figure:Figure;
    private var _splinters:Vector.<Block>;

    public function SmashedMonster(figure:Figure, splinters:Vector.<Block>) {
        _figure = figure;
        _splinters = splinters;
    }


    public function get figure():Figure {
        return _figure;
    }

    public function set figure(value:Figure):void {
        _figure = value;
    }

    public function get splinters():Vector.<Block> {
        return _splinters;
    }

    public function set splinters(value:Vector.<Block>):void {
        _splinters = value;
    }
}
}
