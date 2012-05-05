package {

public class BlockColor {
    public static var RED:BlockColor = new BlockColor();
    public static var GREEN:BlockColor = new BlockColor();
    public static var BLUE:BlockColor = new BlockColor();
	public static function get randomColor():BlockColor {
		var color:int = MathUtil.randomInt(0,2);
		switch (color) {
			case 0:
				return RED;
			case 1:
				return BLUE;
			default:
				return GREEN;
		}
	}
}
}
