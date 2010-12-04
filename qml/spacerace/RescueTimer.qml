import Qt 4.7
import "global.js" as SharedScript

Text {
    property int hours: 0
    property int minutes: 0
    property int seconds: 0
    property int milliseconds: 0
    property bool running: false
    property bool menuMode: true;

    color: "#8888ff"
    text: "<b>" + format(hours) + " : " + format(minutes) + " : " + format(seconds) + (menuMode ? " : " + format(milliseconds) : "")

    Component.onCompleted: reset();

    function reset()
    {
        SharedScript.clockTime = new Date();
    }

    function format(value, maxLength)
    {
        var str = "" + value;
        if (str.length == 1)
            str = "0" + str;
        return str;
    }

    function gameStep()
    {
        if (!running)
            return;
        var date = new Date(new Date() - SharedScript.clockTime);
        hours = date.getHours() - 1;
        minutes = date.getMinutes();
        seconds = date.getSeconds();
        milliseconds = date.getMilliseconds();
    }
}
