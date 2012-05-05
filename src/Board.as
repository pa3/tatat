package {
	import flash.geom.Point;
	import flash.geom.Vector3D;

	import net.flashpunk.Entity;
	import net.flashpunk.utils.Key;

	public class Board extends Entity {
		private const WIDTH:int = 8;
		private const HEIGHT:int = 13;

		private var _blocks:Vector.<Block> = new Vector.<Block>(WIDTH*HEIGHT);
		private var _currentFigure:Figure = null;

		public function Board() {
			Registry.board = this;
		}

		private function applyInputs():void {
			if (_currentFigure) {

				if (Registry.input.triggered(Key.LEFT)) {
					_currentFigure.moveLeft();
				}
				if (Registry.input.triggered(Key.RIGHT)) {
					_currentFigure.moveRight();
				}
				if (Registry.input.triggered(Key.UP)) {
					_currentFigure.rotate()
				}
			}
		}

		public function isPlaceFree(x:int, y:int):Boolean {
			if (y >= HEIGHT) {
				return true;
			}
			return (_blocks[x + WIDTH*y] == null);
		}

		override public function update():void {
			super.update();
			applyInputs();
		}


		public function addFigure(figure:Figure):void {
			_currentFigure = figure;
		}

		public function figureLanded(figure:Figure):void {
			_currentFigure = null;
			if (figure.isOutOfDaBorad()) {
				throw new Error("gameOver");
			}
			for each (var b:Block in figure.getBlocks()) {
				var position:Point = b.getBoardPosition();
				_blocks[int(position.x) + WIDTH*int(position.y)] = b;
			}
			findAndDestroyFilledLines();
		}

		public function moveCurrentFigureDown():void {
			if (_currentFigure) {
				_currentFigure.moveDown();
			}
		}

		private function findAndDestroyFilledLines():void {
			var filledLines:Vector.<int> = getFilledLinesIndexes();
			demolishLines(filledLines);
			collapseLines(filledLines);
		}

		private function getFilledLinesIndexes():Vector.<int> {
			var filledLines:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < HEIGHT; i++) {
				if (isLineFilled(i)) {
					filledLines.unshift(i);
				}
			}
			return filledLines;
		}

		private function collapseLines(lineIndexes:Vector.<int>):void {
			for each (var line:int in lineIndexes) {
				for (var i:int = line; i < HEIGHT-1; i++) {
					for (var j:int = 0; j < WIDTH; j++) {
						_blocks[i*WIDTH + j] = _blocks[(i+1)*WIDTH + j];
						if (_blocks[i*WIDTH + j]) _blocks[i*WIDTH + j].setBoardPosition(j, i);
					}
				}
			}
		}

		private function demolishLines(lineIndexes:Vector.<int>):void {
			for each (var line:int in lineIndexes) {
				for (var i:int = 0; i < WIDTH; i++) {
					_blocks[line*WIDTH + i].startFalling(new Vector3D(Math.random() * 2 - 1, Math.random() * 1 + 12, Math.random() * 20 - 2))
					_blocks[line*WIDTH + i] = null;
				}
			}
		}

		private function isLineFilled(lineNumber:int):Boolean {
			var filled:Boolean = true;
			for (var j:int = 0; j < WIDTH; j++) {
				if (_blocks[lineNumber*WIDTH + j] == null) {
					filled = false;
					break;
				}
			}
			return filled;
		}
	}
}
