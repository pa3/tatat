package {
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class EventBus {

    private static var _listeners:Dictionary = new Dictionary();

    public function EventBus() {
        throw new Error("You don't want to create EventBus instance");
    }

    public static function addListener(messageClass:Class, handler:Function):void {
        if (!_listeners[messageClass]) {
            _listeners[messageClass] = new Vector.<Function>();
        }
        var currentListeners:Vector.<Function> =  _listeners[messageClass];
        currentListeners.push(handler);
    }

    public static function dispatch(message:*):void {
        var messageClass:Class = Class(getDefinitionByName(getQualifiedClassName(message)));
        if (_listeners[messageClass]) {
            var listenersOfPassedMessage:Vector.<Function> = _listeners[messageClass];
            for each (var aListener in listenersOfPassedMessage) {
                addListener.call(null, message);
            }
        }
    }
}
}
