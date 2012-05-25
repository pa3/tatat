package {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class MenuItem extends Entity{
		private const FONT_SIZE:int = 20;

		private var _markerView:Graphic;
		private var _textView:TatatText;
		private var _selectCallback:Function;
		private var _selected:Boolean;
		private var _justSelected:Boolean;
		private var _nextMenuItem:MenuItem;
		private var _prevMenuItem:MenuItem;

		public function MenuItem(text:String, selectCallback:Function, x:int, y:int) {
			this.x = x;
			this.y = y;
			this._selectCallback = selectCallback;
			_markerView = new Text(">", -(int)(0.8*FONT_SIZE), -(int)(0.3*FONT_SIZE), {size:FONT_SIZE});
			_textView = new TatatText(text, FONT_SIZE);
			selected = false;
			addGraphic(_markerView);
			addGraphic(_textView);
		}

		public function set selected(value:Boolean):void {
			_markerView.visible = value;
			_justSelected = value;
			_selected = false;
		}

		public function set nextItem(value:MenuItem):void {
			_nextMenuItem = value;
		}

		public function set prevItem(value:MenuItem):void {
			_prevMenuItem = value;
		}

		override public function update():void {
			super.update();

			if (_selected) {
				if (Input.pressed(Key.SPACE) || Input.pressed(Key.ENTER) || Input.pressed(Key.X) || Input.pressed(Key.Z)) {
					_selectCallback.apply();
				}

				if (Input.pressed(Key.DOWN)) {
					selected = false;
					if (_nextMenuItem)
						_nextMenuItem.selected = true;
				}

				if (Input.pressed(Key.UP)) {
					selected = false;
					if (_prevMenuItem)
						_prevMenuItem.selected = true;
				}
			}

			// Prevent other menu items from switching by the same keystroke
			if (_justSelected) {
				_selected = _justSelected;
				_justSelected = false;
			}


		}
	}
}
