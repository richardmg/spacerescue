import Qt 4.7
import SpaceDebris 1.0

Image {
    id: ship
    property real thrust: 0                 // current speed gain (0 -> 1)
    property real engineSize: 10            // how fast the ship will move upon full thrust
    property real directionInRadians: 0     // orientation of ship
    property real logicalPosX               // location of ship on the map
    property real logicalPosY               // location of ship on the map
    property real wobble: 0                 // visual shaking of ship

    rotation: (180 * directionInRadians / Math.PI)// + ((thrust == 1) ? wobble : 0);
    source: "qrc:/space/img/spaceship1.gif"

    function setGlobalDirection(x, y) {
        var halfShipHeight = ship.height / 2;
        var halfShipWidth = ship.width / 2;
        var relX = ship.pos.x + halfShipWidth - x;
        var relY = ship.pos.y + halfShipHeight - y;
        directionInRadians = -Math.atan2(relX, relY);

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
        text: shipRotation.rotationX + ", " + shipRotation.rotationY + ", " + shipRotation.rotationZ
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
    }

    ShipRotation {
        id: shipRotation
//        property real xx: 0
//        property real yy: 0
//        property real zz: 0

//        onShipRotationChanged: {
//            xx = rotationX;
//            yy = rotationY;
//            zz = rotationZ;
//        }
    }

    function moveShip()
    {
        var moveX = thrust * engineSize * Math.sin(directionInRadians);
        var moveY = thrust * engineSize * Math.cos(directionInRadians);
        logicalPosX += moveX;
        logicalPosY += moveY;
    }

    function animateShip() {
        var nr = fire.imgNr + 1;
        if (nr > fire.imgCount) nr = 1;
        fire.imgNr = nr;
        fire.opacity = 0.4 + (0.6 * Math.random());
        ship.wobble = -3 + (3 * Math.random());
        fire.flipImage = Math.random() > 0.5 ? 1 : -1;
    }

    function gameStep() {
        animateShip();
        moveShip();
    }
}
