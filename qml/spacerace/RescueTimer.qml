import Qt 4.7
import "global.js" as SharedScript

Text {
    property int hours: 0
    property int minutes: 0
    property int seconds: 0
    property int milliseconds: 0
    property bool running: false
    property bool menuMode: true;
    property string label:  ""

    color: "#8888ff"
    text: "<b>" + label + format(hours) + " : " + format(minutes) + " : " + format(seconds) + (menuMode ? " : " + format(milliseconds) : "")

    Component.onCompleted: reset();

    function reset()
    {
        SharedScript.clockTime = new Date();
        gameStep();
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
