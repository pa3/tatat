package {
	import net.flashpunk.Entity;

	import types.SmashedMonster;

	public class Monster extends Entity {

		private static var MONSTER_BLOCK_MAPS_1:Vector.<int> = Vector.<int>(
				[
					0, 0, 0, 1, 1, 0, 0, 0,
					0, 0, 1, 1, 1, 1, 0, 0,
					0, 1, 1, 1, 1, 1, 1, 0,
					1, 1, 0, 1, 1, 0, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1,
					0, 0, 1, 0, 0, 1, 0, 0,
					0, 1, 0, 1, 1, 0, 1, 0,
					1, 0, 1, 0, 0, 1, 0, 1
				]
		);

		private static var MONSTER_BLOCKS_MAP_2:Vector.<int> = Vector.<int>(
				[
					0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0,
					0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0,
					0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0,
					0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1,
					1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1,
					0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0
				]
		);

		private static var MONSTER_BLOCKS_MAP_3:Vector.<int> = Vector.<int>(
				[
					0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0,
					0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1,
					1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0,
					0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0,
					1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1
				]
		);

		private static var MONSTERS_BLOCKS_MAP:Vector.<Vector.<int>> = Vector.<Vector.<int>>(
				[MONSTER_BLOCK_MAPS_1, MONSTER_BLOCKS_MAP_2, MONSTER_BLOCKS_MAP_3, MONSTER_BLOCK_MAPS_1, MONSTER_BLOCKS_MAP_2, MONSTER_BLOCKS_MAP_3]
		);
		private static var MONSTERS_WIDTHS:Vector.<int> = Vector.<int>(
				[8, 11, 12, 8, 11, 12]
		);
		private static var MONSTERS_HEIGHTS:Vector.<int> = Vector.<int>(
				[8, 8, 8, 8, 8, 8]
		);
		private static var MONSTERS_COLORS:Vector.<BlockColor> = Vector.<BlockColor>(
				[BlockColor.RED, BlockColor.BLUE, BlockColor.GREEN, BlockColor.ORANGE, BlockColor.PURPLE, BlockColor.YELLOW]
		);
		private static var MONSTERS_FIGURE_BLOCKS:Vector.<Vector.<int>> = Vector.<Vector.<int>>(
				[Vector.<int>([21, 22, 23, 24]), Vector.<int>([24, 25, 26, 36]), Vector.<int>([42, 43, 48, 49]),
			     Vector.<int>([23, 24, 25, 27]), Vector.<int>([23, 24, 33, 34]), Vector.<int>([39, 40, 41, 30])]
		);
		private static var MONSTERS_FIGURE_PIVOTS:Vector.<int> = Vector.<int>(
				[22, 25, 42, 24, 24, 40]
		);

		private var _blocks:Vector.<Block> = new Vector.<Block>();
		private var _positionOnTape:int;

		private var _figureBlocksIndexes:Vector.<int>;
		private var _pivotBlockIndex:int;

		public static function createMonster(type:int):Monster {
			return new Monster(
					MONSTERS_WIDTHS[type],
					MONSTERS_HEIGHTS[type],
					MONSTERS_BLOCKS_MAP[type],
					MONSTERS_COLORS[type],
					MONSTERS_FIGURE_BLOCKS[type],
					MONSTERS_FIGURE_PIVOTS[type]
			);
		}

		public function Monster(width:int, height:int, pixelsMap:Vector.<int>, color:BlockColor, figureBlocksIndexes:Vector.<int>, pivotBlockIndex:int) {

			var xOffset:int = (8 - width)/2;
			for (var i:int = 0; i < height; i++) {
				for (var j:int = 0; j < width; j++) {
					if (pixelsMap[i*width + j] != 0) {
						_blocks.push(Block.createBlock(color, xOffset + j, i, 0));
					}
				}
			}
			_pivotBlockIndex = pivotBlockIndex;
			_figureBlocksIndexes = figureBlocksIndexes;
		}

		override public function added():void {
			super.added();
			for each (var aBlock:Block in _blocks) {
				world.add(aBlock);
			}
		}

		public function set positionOnTape(position:int):void {
			_positionOnTape = position;
			for each (var aBlock:Block in _blocks) {
				aBlock.setTapePosition(position);
			}
		}

		public function get positionOnTape():int {
			return _positionOnTape;
		}

		public function breakApart():SmashedMonster {
			var figureBlocks:Vector.<Block> = new Vector.<Block>();
			var splinters:Vector.<Block> = _blocks.concat();
			positionOnTape = 0;
			for (var i:int = 0; i < _figureBlocksIndexes.length; i++) {
				figureBlocks.push(_blocks[_figureBlocksIndexes[i]]);
				splinters.splice(splinters.indexOf(_blocks[_figureBlocksIndexes[i]]), 1);
			}
			return new SmashedMonster(new Figure(figureBlocks, _blocks[_pivotBlockIndex]), splinters);
		}

		public function getBlocks():Vector.<Block> {
			return _blocks;
		}
	}
}
