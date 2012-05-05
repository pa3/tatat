package {
	import flash.geom.Vector3D;

	import net.flashpunk.Entity;

	public class TatatLabelRenderer extends Entity {

		private var _blocks:Vector.<Block>;
		private var _label:TatatLabel

		public function TatatLabelRenderer(label:TatatLabel, leftTopPoint:Vector3D,  blocks:Vector.<Block>) {
			_label = label;
			if (blocks.length != _label.amountOfVoxels) {
				throw new Error("Need " + _label.amountOfVoxels + " blocks to build label, but " + blocks.length + " have been passed.")
			}
			_blocks = blocks.concat();
			var blocksPositions:Vector.<Vector3D> = new Vector.<Vector3D>();
			var width:int = _label.width;
			var height:int = _label.height;
			for (var i:int = 0; i < height; i++) {
				for (var j:int = 0; j < width; j++) {
					if (_label.text[i*width+j] != 0) {
						blocksPositions.push(leftTopPoint.add(new Vector3D(-j, i, 0)));
					}
				}
			}

			updateBlocksPositions(blocksPositions);
		}


		private function updateBlocksPositions(positions:Vector.<Vector3D>):void {
			for (var i:int = 0; i < _blocks.length; i++) {
				_blocks[i].position = positions[i];
			}
		}
	}
}
