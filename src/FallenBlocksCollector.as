package {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;

	public class FallenBlocksCollector extends Entity{

		private var blocks:Vector.<Block> = new Vector.<Block>();

		public function FallenBlocksCollector() {
			Registry.blocksCollector = this;
		}

		public function monitorBlock(aBlock:Block):void {
		    blocks.push(aBlock);
		}

		override public function update():void {
			super.update();
			var blocksToDelete:Vector.<Block> =	blocks.filter(function(item:Block, index:int, vector:Vector.<Block>):Boolean {
				return item.position.y > 40;
			});
			for each (var aBlock:Block in blocksToDelete ) {
				world.remove(aBlock);
				blocks.splice(blocks.indexOf(aBlock),1);
			}
		}
	}
}
