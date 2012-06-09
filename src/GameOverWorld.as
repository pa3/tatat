package {
	import flash.geom.Vector3D;

	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class GameOverWorld extends World {

		[Embed(source="/resources/tape_n_board.png")]
		private var TapeAndBoardImage:Class;
		private var _blocks:Vector.<Block> = new Vector.<Block>();
		private var _gameOverLabel:TatatLabelRenderer;
		private var _pressXKey:Entity;

		public function GameOverWorld(blocks:Vector.<Block>) {
			addTape();
			addMasher();
			addPassedBlocks(blocks);
			createAndAddMissingBlocks();
			addContinueText();
			startGameOverLabelConstruction();
		}

		private function addContinueText():void {
			_pressXKey = new Entity(50,420, new TatatText("Press <X> to continue",20));
			add(_pressXKey);
		}


		private function startGameOverLabelConstruction():void {
			_gameOverLabel = new TatatLabelRenderer(TatatLabel.GAME_OVER_LABEL, new Vector3D(11, -5, 10),
								_blocks.splice(0, TatatLabel.GAME_OVER_LABEL.amountOfVoxels));
			add(_gameOverLabel);
			for each (var aBlock:Block in _blocks) {
				aBlock.startFalling(new Vector3D(MathUtil.randomInt(-50,50),MathUtil.randomInt(-50,50),0));
			}
			_gameOverLabel.startBuildUpAnimation(1);

			var pressKeyTween:VarTween = new VarTween();
			pressKeyTween.tween(_pressXKey, "y", 240, 1);
			addTween(pressKeyTween, true);
		}

		private function createAndAddMissingBlocks():void {
			var amountOfNeededBlocks:int = TatatLabel.GAME_OVER_LABEL.amountOfVoxels - _blocks.length;
			if (amountOfNeededBlocks > 0) {
				for (var i:int = 0; i < amountOfNeededBlocks; i++ ) {
					var block:Block = Block.createBlock(BlockColor.randomColor, MathUtil.randomInt(-50,50),MathUtil.randomInt(-50,50),0);
					_blocks.push(block);
					add(block);
				}
			}
		}


		override public function update():void {
			super.update();
			if (Input.pressed(Key.X)) {
				FP.world = new MenuWorld();
			}
		}

		private function addPassedBlocks(blocks:Vector.<Block>):void {
			for each (var aBlock:Block in blocks) {
				var blockToAdd:Block = aBlock.clone();
				_blocks.push(blockToAdd);
				add(blockToAdd);
			}
		}

		private function addMasher():void {
			var masher:Masher = new Masher();
			masher.x = 160;
			masher.layer = int.MIN_VALUE;
			add(masher);
		}

		private function addTape():void {
			var tape:Entity = new Entity(0, 0, new Image(TapeAndBoardImage));
			tape.layer = 1000;
			add(tape);
		}

	}

}
