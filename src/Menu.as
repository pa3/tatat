package {
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;

	/**
	 * Damn messy appearance/disappearance included. Next time for should use tweens. =)
	 */
	public class Menu extends World {

		private var _items:Vector.<MenuItem> = new Vector.<MenuItem>();
		private var _itemsCurrentY:Number = 400.0;
		private var _itemsInitialY:Number = 0.0;
		private var _itemsDestinationY:Number = 0.0;
		private var _animationTimer:Number = 0.0;
		private var _animationDuration:Number = 0.0;
		private var _inAnimationState:Boolean = false;
		private const APPEARANCE_TIME_IN_SECONDS:Number = 1.0;

		private var _animationCompleteCallback:Function = null;

		private var _play:MenuItem = new MenuItem("PLAY GAME", playGame, 90, _itemsCurrentY + 70);
		private var _source:MenuItem = new MenuItem("GET SOURCE CODE", goToGitHub, 90, _itemsCurrentY + 100);
		private var _inspiration:MenuItem = new MenuItem("INSPIRATION", openPicture, 90, _itemsCurrentY + 130);
		private var _gameFullName:Entity = new Entity(20, _itemsCurrentY, new TatatText("The Awful Truth About Tetris", 20));

		public function Menu() {
			addTitle();
			addGamesFullName();
			addMenuItems();
			_animationCompleteCallback = onMenuShown;
			show();
		}

		private function show():void {
			_title.startBuildUpAnimation(APPEARANCE_TIME_IN_SECONDS);
			_inAnimationState = true;
			_itemsDestinationY = 150;
			_itemsInitialY = _itemsCurrentY;
			_animationDuration = APPEARANCE_TIME_IN_SECONDS;
			_animationTimer = 0;
		}

		private function hide():void {
			_title.startBreakApartAnimation(APPEARANCE_TIME_IN_SECONDS);
			_inAnimationState = true;
			_itemsDestinationY = 400;
			_itemsInitialY = _itemsCurrentY;
			_animationDuration = APPEARANCE_TIME_IN_SECONDS;
			_animationTimer = 0;
		}

		private function addGamesFullName():void {
			add(_gameFullName);
		}

		public function playGame():void {
			_play.selected = false;
			_source.selected = false;
			_inspiration.selected = false;
			_animationCompleteCallback = onMenuHidden;
			hide();
		}

		private function onMenuHidden():void {
			FP.world = new TatatWorld();
		}

		private function onMenuShown():void {
			_play.selected = true;
		}

		public function goToGitHub():void {
			navigateToURL(new URLRequest("https://github.com/pa3/tatat"), "_blank");
		}

		public function openPicture():void {
			navigateToURL(new URLRequest("http://www.flickr.com/photos/eduardosangil/5325189136/in/photostream"), "_blank");
		}

		private function addMenuItems():void {
			add(_play);
			add(_source);
			add(_inspiration);
			_play.nextItem = _source;
			_play.prevItem = _inspiration;
			_source.nextItem = _inspiration;
			_source.prevItem = _play;
			_inspiration.nextItem = _play;
			_inspiration.prevItem = _source;
			_items.push(_play);
			_items.push(_source);
			_items.push(_inspiration);
		}

		private var _title:TatatLabelRenderer;

		private function addTitle():void {
			var titleBlocks:Vector.<Block> = new Vector.<Block>();
			for (var i:int = 0; i < TatatLabel.TATAT_TITLE.amountOfVoxels; i++) {
				var block:Block = Block.createBlock(BlockColor.RED, 0, 0, 0);
				block.position.x = MathUtil.randomInt(-50, 50);
				block.position.y = MathUtil.randomInt(-50, 50);
				block.position.z = MathUtil.randomInt(-50, 50);
				titleBlocks.push(block);
				add(block);
			}
			_title = new TatatLabelRenderer(TatatLabel.TATAT_TITLE, new Vector3D(13, -2, 10), titleBlocks);
//			_title.startBuildUpAnimation(APPEARANCE_TIME_IN_SECONDS);
			add(_title);
		}

		override public function update():void {
			super.update();

			if (_inAnimationState) {
				_animationTimer += FP.elapsed;
				if (_animationTimer < _animationDuration) {
					var itemsX:Number = MathUtil.numbresLerp(_itemsInitialY, _itemsDestinationY, _animationTimer/_animationDuration);
					setTextsYPosition(itemsX);
					FP.log(_animationTimer);
				} else {
					setTextsYPosition(_itemsDestinationY);
					_itemsCurrentY = _itemsDestinationY;
					_inAnimationState = false;
					if (_animationCompleteCallback) {
						_animationCompleteCallback.apply();
					}
				}
			}
		}

		private function setTextsYPosition(value:Number):void {
			_gameFullName.y = value;
			_play.y = value + 70;
			_source.y = value + 100;
			_inspiration.y = value + 130;
		}
	}
}
