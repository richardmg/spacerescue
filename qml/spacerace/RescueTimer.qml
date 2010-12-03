import Qt 4.7
import "global.js" as SharedScript

Text {
    property int hours: 0
    property int minutes: 0
    property int seconds: 0
    property int milliseconds: 0

    color: "red"
    text: "<b>" + format(hours) + " : " + format(minutes) + " : " + format(seconds) + " : " + format(milliseconds)

    Component.onCompleted: reset();

    function reset()
    {
        SharedScript.clockTime = new Date();
    }

    function format(value)
    {
        return value;
//        return Math.round(value * Math.pow(10, 1)) / Math.pow(10, 1)
    }

    function gameStep()
    {
        var d = new Date(new Date() - SharedScript.clockTime);
        var h = (d.getHours() - SharedScript.clockTime.getHours());
        var m = (d.getMinutes() - SharedScript.clockTime.getMinutes());
        var s = (d.getSeconds() - SharedScript.clockTime.getSeconds());
        var ms = d.getMilliseconds() - SharedScript.clockTime.getMilliseconds();
        var sumMs = (h * 60 * 60 * 1000) + (m * 60 * 1000) + (s * 1000) + ms;

        hours = d.getHours() - 1;
        minutes = d.getMinutes();
        seconds = d.getSeconds();
        milliseconds = d.getMilliseconds();
    }
}
