package {
import flash.geom.Matrix3D;
import flash.geom.Point;
import flash.geom.Vector3D;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class Camera extends Entity{
    public var roll:Number = 0;
    public var position:Vector3D = new Vector3D(1, 0.71, -1.2, 0);
    public var looksAt:Vector3D = new Vector3D(0, 0, 0, 0);
    public var xScale:Number = 0.066;
    public var yScale:Number = 0.076;
    public var zScale:Number = 0.091;

    private var world2ScreenMatrix:Matrix3D;


    public function Camera() {

        var up:Vector3D = new Vector3D(Math.sin(roll), -Math.cos(roll), Math.sin(roll), 0);
        var forward:Vector3D = looksAt.subtract(position);
        forward.normalize();
        var right:Vector3D = up.crossProduct(forward);
        right.normalize();
        up =  right.crossProduct(forward);
        up.normalize();

        var rotationMatrix:Matrix3D = new Matrix3D(Vector.<Number>(
                [
                    right.x, right.y, right.z, 0,
                    up.x, up.y,  up.z, 0,
                    forward.x, forward.y,  forward.z, 0,
                    0, 0, 0, 1
                ]
        ));

        var transitionMatrix:Matrix3D = new Matrix3D(Vector.<Number>(
                [
                    1, 0, 0, -position.x,
                    0, 1, 0, -position.y,
                    0, 0, 1, -position.z,
                    0, 0, 0, 1
                ]
        ));

        var scaleMatrix:Matrix3D = new Matrix3D(Vector.<Number>(
                [
                    xScale, 0, 0, 0,
                    0, yScale, 0, 0,
                    0, 0, zScale, 0,
                    0, 0, 0, 1
                ]
        ));

        world2ScreenMatrix = rotationMatrix.clone();
        world2ScreenMatrix.prepend(transitionMatrix);
        world2ScreenMatrix.append(scaleMatrix);
        world2ScreenMatrix.invert();
    }

    override public function update():void {
        super.update();

        if (Input.check(Key.X)) {
            position = position.add(new Vector3D(0.001, 0, 0, 0));
        }
        if (Input.check(Key.Z)) {
            position = position.add(new Vector3D(-0.001, 0, 0, 0));
        }
        if (Input.check(Key.C)) {
            position = position.add(new Vector3D(0, 0.01, 0, 0));
        }
        if (Input.check(Key.V)) {
            position = position.add(new Vector3D(0, -0.01, 0, 0));
        }
        if (Input.check(Key.B)) {
            position = position.add(new Vector3D(0, 0, 0.01, 0));
        }
        if (Input.check(Key.Q)) {
            xScale+=0.0005;
        }

        if (Input.check(Key.W)) {
            xScale-=0.0005;
        }

        if (Input.check(Key.E)) {
            yScale+=0.0005;
        }
        if (Input.check(Key.R)) {
            yScale-=0.0005;
        }

        if (Input.check(Key.T)) {
            zScale+=0.0005;
        }

        if (Input.check(Key.Y)) {
            zScale-=0.0005;
        }



        var up:Vector3D = new Vector3D(Math.sin(roll), -Math.cos(roll), Math.sin(roll), 0);
        var forward:Vector3D = looksAt.subtract(position);
        forward.normalize();
        var right:Vector3D = up.crossProduct(forward);
        right.normalize();
        up =  right.crossProduct(forward);
        up.normalize();

        var rotationMatrix:Matrix3D = new Matrix3D(Vector.<Number>(
                [
                    right.x, right.y, right.z, 0,
                    up.x, up.y,  up.z, 0,
                    forward.x, forward.y,  forward.z, 0,
                    0, 0, 0, 1
                ]
        ));

        var transitionMatrix:Matrix3D = new Matrix3D(Vector.<Number>(
                [
                    1, 0, 0, -position.x,
                    0, 1, 0, -position.y,
                    0, 0, 1, -position.z,
                    0, 0, 0, 1
                ]
        ));

        var scaleMatrix:Matrix3D = new Matrix3D(Vector.<Number>(
                [
                    xScale, 0, 0, 0,
                    0, yScale, 0, 0,
                    0, 0, zScale, 0,
                    0, 0, 0, 1
                ]
        ));

        world2ScreenMatrix = rotationMatrix.clone();
        world2ScreenMatrix.prepend(transitionMatrix);
        world2ScreenMatrix.append(scaleMatrix);
        world2ScreenMatrix.invert();

        //FP.log(position.toString() + "," + xScale + "," + yScale + "," + zScale);

    }

    public function worldPositionToScreenPoint(position:Vector3D):Vector3D {
        return world2ScreenMatrix.transformVector(position);
    }

}
}
