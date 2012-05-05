package {

public class BlockColor {


	[Embed(source="/resources/red_block.png")]
	private static var RedBlockImage:Class;
 	[Embed(source="/resources/blue_block.png")]
 	private static var BlueBlockImage:Class;
 	[Embed(source="/resources/green_block.png")]
 	private static var GreenBlockImage:Class;
	[Embed(source="/resources/orange_block.png")]
	private static var OrangeBlockImage:Class;
 	[Embed(source="/resources/white_block.png")]
 	private static var WhiteBlockImage:Class;
 	[Embed(source="/resources/purple_block.png")]
 	private static var PurpleBlockImage:Class;
 	[Embed(source="/resources/yellow_block.png")]
 	private static var YellowBlockImage:Class;

	public static var RED:BlockColor = new BlockColor(RedBlockImage);
	public static var GREEN:BlockColor = new BlockColor(GreenBlockImage);
	public static var BLUE:BlockColor = new BlockColor(BlueBlockImage);
	public static var YELLOW:BlockColor = new BlockColor(YellowBlockImage);
	public static var WHITE:BlockColor = new BlockColor(WhiteBlockImage);
	public static var ORANGE:BlockColor = new BlockColor(OrangeBlockImage);
	public static var PURPLE:BlockColor = new BlockColor(PurpleBlockImage);

	private var _spriteClass:Class;

	public static function get randomColor():BlockColor {
		var color:int = MathUtil.randomInt(0,6);
		switch (color) {
			case 0:
				return RED;
			case 1:
				return BLUE;
			case 2:
				return GREEN;
			case 3:
				return YELLOW;
			case 4:
				return PURPLE;
			case 5:
				return ORANGE;
			default:
				return WHITE;
		}
	}


	public function get spriteClass():Class {
		return _spriteClass;
	}

	public function BlockColor(spriteImageClass:Class) {
		_spriteClass = spriteImageClass;
	}
}
}
