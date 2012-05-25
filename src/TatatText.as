package {
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;

	public class TatatText extends Graphiclist{
		public function TatatText(text:String, fontSize:int) {
			var letters:Array = text.split("");
			for (var i:int = 0; i < letters.length; i++) {
				add(new Text(letters[i], (int)(0.6*fontSize*i), (int)(0.2*fontSize*i),{size:fontSize}));
			}
		}
	}
}
