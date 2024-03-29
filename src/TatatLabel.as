package {
	public class TatatLabel {

		private var _text:Vector.<int>;
		private var _width:int;

		public function get text():Vector.<int> {
			return _text;
		}

		public function get width():int {
			return _width;
		}

		public function get height():int {
			return _text.length/_width;
		}

		public function get amountOfVoxels():int {
			var amount:int = 0;
			for each (var voxel:int in _text) {
				amount += voxel;
			}
			return amount;
		}

		public function TatatLabel(text:Vector.<int>, width:int) {
			_text = text;
			_width = width;
		}



		public static const GAME_OVER_LABEL:TatatLabel = new TatatLabel(Vector.<int>(
		          [
		              0,1,1,1,0,0,0,0,1,1,1,0,1,0,0,0,1,0,1,1,1,1,1,
		              1,0,0,0,1,0,0,1,0,0,1,0,1,1,0,1,1,0,1,0,0,0,0,
		              1,0,0,0,0,0,1,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,0,
		              1,0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,1,0,1,1,1,1,0,
		              1,0,0,1,1,0,1,1,1,1,1,0,1,0,0,0,1,0,1,0,0,0,0,
		              1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,
		              0,1,1,1,0,0,1,0,0,0,1,0,1,0,0,0,1,0,1,1,1,1,1,
					  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					  0,1,1,1,0,0,1,0,0,0,1,0,1,1,1,1,1,0,1,1,1,1,0,
					  1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,1,
					  1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,1,
					  1,0,0,0,1,0,1,0,0,0,1,0,1,1,1,1,0,0,1,1,1,1,0,
					  1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,1,0,1,0,0,
					  1,0,0,0,1,0,0,1,0,1,0,0,1,0,0,0,0,0,1,0,0,1,0,
					  0,1,1,1,0,0,0,0,1,0,0,0,1,1,1,1,1,0,1,0,0,0,1

		          ]
		  		), 23
		);

		public static const TATAT_TITLE:TatatLabel = new TatatLabel(Vector.<int>(
		          [
		              1,1,1,1,1,0,0,0,1,1,1,0,1,1,1,1,1,0,0,0,1,1,1,0,1,1,1,1,1,
		              0,0,1,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0,1,0,0,
		              0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,
		              0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,
		              0,0,1,0,0,0,1,1,1,1,1,0,0,0,1,0,0,0,1,1,1,1,1,0,0,0,1,0,0,
		              0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,
		              0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0

		          ]
		  		), 29
		);


	}
}
