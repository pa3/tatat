package {
	public class MathUtil {
		public static function randomInt(from:int, to:int):int {
			return Math.round(Math.random()*(to - from) + from);
		}

	}
}
