package {
	import flash.geom.Vector3D;

	import net.flashpunk.Entity;
import net.flashpunk.FP;

public class TatatLabelRenderer extends Entity {

		private var _blocks:Vector.<Block>;
		private var _label:TatatLabel;
        private var _blocksFinalPositions:Vector.<Vector3D>;
        private var _blocksInitialPosition:Vector.<Vector3D>;
        private var _animationElapsedTime:Number;
        private var _animationDuration:Number;
        private var _isAnimating:Boolean;


		public function TatatLabelRenderer(label:TatatLabel, leftTopPoint:Vector3D,  blocks:Vector.<Block>) {
			_label = label;
			if (blocks.length != _label.amountOfVoxels) {
				throw new Error("Need " + _label.amountOfVoxels + " blocks to build label, but " + blocks.length + " have been passed.")
			}
			_blocks = blocks.concat();
			//var blocksPositions:Vector.<Vector3D> = new Vector.<Vector3D>();
            _blocksFinalPositions = new Vector.<Vector3D>();

			var width:int = _label.width;
			var height:int = _label.height;
			for (var i:int = 0; i < height; i++) {
				for (var j:int = 0; j < width; j++) {
					if (_label.text[i*width+j] != 0) {
                        _blocksFinalPositions.push(leftTopPoint.add(new Vector3D(-j, i, 0)));
					}
				}
			}
            _blocksInitialPosition = new Vector.<Vector3D>();
            for each (var aBlock:Block in _blocks) {
                _blocksInitialPosition.push(aBlock.position.clone());
            }

			updateBlocksPositions(_blocksFinalPositions);
		}


        public function startBuildUpAnimation(animationTime:Number) {
            _animationElapsedTime = 0;
            _animationDuration = animationTime;
            _isAnimating = true;
        }
        
        override public function update():void {
            super.update();
            if (_isAnimating) {
                _animationElapsedTime += FP.elapsed;
                if (_animationElapsedTime >= _animationDuration) {
                    updateBlocksPositions(_blocksFinalPositions);
                    _isAnimating = false;
                } else {
                    var currentPositions:Vector.<Vector3D> = new Vector.<Vector3D>();
                    for (var i:int = 0; i < _blocksInitialPosition.length; i++) {
                        currentPositions.push(MathUtil.vectorsLerp(_blocksInitialPosition[i], _blocksFinalPositions[i], _animationElapsedTime/_animationDuration));
                    }
                    updateBlocksPositions(currentPositions);
                }
            }
        }

        private function updateBlocksPositions(positions:Vector.<Vector3D>):void {
			for (var i:int = 0; i < _blocks.length; i++) {
				_blocks[i].position = positions[i];
			}
		}
	}
}
