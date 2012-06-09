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

    public function get splinters():Vector.<Block> {
        return _splinters;
    }

}
}
