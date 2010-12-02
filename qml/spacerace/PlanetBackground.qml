import Qt 4.7
import "global.js" as SharedScript

Item {
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property string bgimage: ""

    function gameStep()
    {
        SharedScript.updateScreenPositionFor(this);
    }

    Image {
        id: planet
        source: bgimage
    }
}
