import Qt 4.7
import "global.js" as SharedScript

Item {
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real speedX: 0
    property real speedY: 0
    property real rotationSpeed: 0

    property string bgimage: ""

    width: planet.width
    height: planet.height

    function gameStep()
    {
        universeX += speedX;
        universeY += speedY;
        rotation += rotationSpeed;
        SharedScript.updateScreenPositionFor(this);
    }

    Image {
        id: planet
        source: bgimage
    }
}
