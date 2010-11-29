import Qt 4.7

Image {
    id: ship
    property real thrust: 0
    property real orientation: 0
    property real wobble: 0

    rotation: orientation + ((thrust == 1) ? wobble : 0);
    source: "qrc:/space/img/spaceship1.gif"

    function setGlobalDirection(x, y) {
        var halfShipHeight = ship.height / 2;
        var halfShipWidth = ship.width / 2;
        var relX = ship.pos.x + halfShipWidth - x;
        var relY = ship.pos.y + halfShipHeight - y;
        var rad = -Math.atan2(relX, relY);
        orientation = 180 * rad / Math.PI;

        var thrustStart = 120;
        var thrustEnd = 150;
        var thrustUnomalized = Math.sqrt((relX * relX) + (relY * relY)) - thrustStart;
        thrustUnomalized = thrustUnomalized / (thrustEnd - thrustStart);
        if (thrustUnomalized < 0) thrustUnomalized = 0;
        if (thrustUnomalized > 1) thrustUnomalized = 1;
        thrust = thrustUnomalized;
    }

    Text {
        x: 50
        id: text
        text: fire.imgNr
    }

    Image {
        id: fire
        property int imgNr: 1
        property int imgCount: 2
        property int flipImage: 1;

        anchors.top: ship.bottom
        anchors.horizontalCenter: ship.horizontalCenter
        width: sourceSize.width * thrust * flipImage;
        height: sourceSize.height * thrust
        source: "qrc:/space/img/fire" + imgNr + ".gif"
        opacity: thrust

        Timer {
            interval: 50; running: true; repeat: true
            onTriggered: {
                var nr = fire.imgNr + 1;
                if (nr > fire.imgCount) nr = 1;
                fire.imgNr = nr;
                fire.opacity = 0.4 + (0.6 * Math.random());
                ship.wobble = -3 + (3 * Math.random());
                fire.flipImage = Math.random() > 0.5 ? 1 : -1;
            }
        }
    }
}
