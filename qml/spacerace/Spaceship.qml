import Qt 4.7
import SpaceDebris 1.0

Image {
    id: ship
    property real thrust: 0                     // current speed gain (0 -> 1)
    property real engineSize: 10                // how fast the ship will move upon full thrust
    property real directionInRadians: 0         // orientation of ship
    property real logicalPosX: 0                // location of ship on the map
    property real logicalPosY: 0                // location of ship on the map
    property real wobble: 0                     // visual shaking of ship

    property real rotationNoThrust: 40          // x rotation where ship have no thrust
    property real rotationFullThrust: 25        // x rotation where ship have full thrust
    property real rotationMaxBank: 50           // y rotation when ship rotate the most
    property real directionAtMaxBank: Math.PI/9 // orientation of ship at rotationMaxBank

    property bool mouseControlled: false        // ship controlled by mouse or sensor

    rotation: (180 * directionInRadians / Math.PI)// + ((thrust == 1) ? wobble : 0);
    source: "qrc:/space/img/spaceship1.gif"

    Image {
        id: fire
        property int imgNr: 1
        property int imgCount: 2
        property int flipImage: 1;

        anchors.top: ship.bottom
        anchors.horizontalCenter: ship.horizontalCenter
        width: sourceSize.width * thrust * flipImage;
        height: sourceSize.height * thrust
        source: "qrc:/space/img/fire" + imgNr + ".png"
    }

    function setGlobalDirection(x, y) {
        if (!ship.mouseControlled)
            return;

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

    ShipRotation {
        id: shipRotation
        enabled: ship.mouseControlled == false;

        onRotationXChanged: {
            var thrustRange = ship.rotationFullThrust - ship.rotationNoThrust;
            var t = ((rotationX - ship.rotationNoThrust) / thrustRange);
            if (t < 0) t = 0;
            if (t > 1) t = 1;
            ship.thrust = t;
        }

        onRotationYChanged: {
            var r = rotationY / ship.rotationMaxBank;
            if (r < -1) r = -1;
            if (r >  1) r =  1;
            directionInRadians += r * directionAtMaxBank;
        }
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
