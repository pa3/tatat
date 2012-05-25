package {
import flash.geom.Vector3D;
import flash.geom.Vector3D;

public class MathUtil {
		public static function randomInt(from:int, to:int):int {
			return Math.round(Math.random()*(to - from) + from);
		}

        public static function vectorsLerp(from:Vector3D, to:Vector3D, amt:Number) {
            var distance:Vector3D = to.subtract(from);
            distance.scaleBy(amt);
            return from.add(distance);
        }

        public static function numbresLerp(from:Number, to:Number, amt:Number) {
            return from + amt*(to-from);
        }

	}
}
