import Qt 4.7
import SpaceDebris 1.0
import "global.js" as SharedScript

Image {
    id: ship
    property real universeX: 0                      // location of ship on the map
    property real universeY: 0                      // location of ship on the map
    property real universez: 1                      // location of ship on the map

    property real thrust: 0                         // current speed gain (0 -> 1)
    property real engineSize: 1                     // how fast the ship will move upon full thrust
    property real directionInRadians: 0             // orientation of ship
    property bool mouseControlled: false            // ship controlled by mouse or sensor

    property real _rotationNoThrust: 40             // x rotation where ship have no thrust
    property real _rotationFullThrust: 25           // x rotation where ship have full thrust
    property real _rotationMaxBank: 50              // y rotation when ship rotate the most
    property real _directionAtMaxBank: Math.PI/9    // orientation of ship at _rotationMaxBank
    property real _speedX: 0                        // current speed along x-axis
    property real _speedY: 0                        // current speed along y-axis
    property real _speedMaxX: 7                     // abs(_speedX) <=_speedMaxX
    property real _speedMaxY: 7                     // abs(_speedY) <=_speedMaxY
    property real _wobble: 0                        // visual shaking of ship

    rotation: (180 * directionInRadians / Math.PI)// + ((thrust == 1) ? _wobble : 0);
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

    function setUniverseDirection(x, y) {
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
            var thrustRange = ship._rotationFullThrust - ship._rotationNoThrust;
            var t = ((rotationX - ship._rotationNoThrust) / thrustRange);
            if (t < 0) t = 0;
            if (t > 1) t = 1;
            ship.thrust = t;
        }

        onRotationYChanged: {
            var r = rotationY / ship._rotationMaxBank;
            if (r < -1) r = -1;
            if (r >  1) r =  1;
            directionInRadians += r * _directionAtMaxBank;
        }
    }

    function moveShip()
    {
        var sx = _speedX + (thrust * engineSize * Math.sin(directionInRadians));
        var sy = _speedY - (thrust * engineSize * Math.cos(directionInRadians));
//        var sx = (thrust*3 * engineSize * Math.sin(directionInRadians));
//        var sy = - (thrust*3 * engineSize * Math.cos(directionInRadians));
        if (sx > _speedMaxX) sx = _speedMaxX;
        else if (sx < -_speedMaxX) sx = -_speedMaxX;
        if (sy > _speedMaxY) sy = _speedMaxY;
        else if (sy < -_speedMaxY) sy = -_speedMaxY;
        _speedX = sx
        _speedY = sy

        universeX += _speedX;
        universeY += _speedY;

        SharedScript.shipCollisionCenterX = universeX + (ship.width / 2);
        SharedScript.shipCollisionCenterY = universeY + (ship.height / 2);
    }

    function animateShip() {
        var nr = fire.imgNr + 1;
        if (nr > fire.imgCount) nr = 1;
        fire.imgNr = nr;
        fire.opacity = 0.4 + (0.6 * Math.random());
        ship._wobble = -3 + (3 * Math.random());
        fire.flipImage = Math.random() > 0.5 ? 1 : -1;
    }

    function gameStep() {
        animateShip();
        moveShip();
    }

    //    Rectangle {
    //        id: collisionBounding
    //        color: "red"
    //        opacity: 0.4
    //        width:  2 * SharedScript._shipCollisionRadius
    //        height: 2 * SharedScript._shipCollisionRadius
    //        anchors.centerIn: parent
    //    }

}
