import Qt 4.7
import SpaceDebris 1.0
import "global.js" as SharedScript

GameObject {
    id: localRoot
    property real thrust: 0                         // current speed gain (0 -> 1)
    property real engineSize: 1                     // how fast the ship will move upon full thrust
    property bool mouseControlled: false            // ship controlled by mouse or sensor

    width: ship.width
    height: ship.height
    boundingRadius: 20

    Image {
        id: ship
        property real _directionInRadians: Math.PI/2     // orientation of ship
        property real _rotationNoThrust: 38             // x rotation where ship have no thrust
        property real _rotationFullThrust: 23           // x rotation where ship have full thrust
        property real _rotationMaxBank: 50              // y rotation when ship rotate the most
        property real _directionAtMaxBank: Math.PI/9    // orientation of ship at _rotationMaxBank
        property real _speedX: 0                        // current speed along x-axis
        property real _speedY: 0                        // current speed along y-axis
        property real _speedMaxX: 7                     // abs(_speedX) <=_speedMaxX
        property real _speedMaxY: 7                     // abs(_speedY) <=_speedMaxY
        property int _collisionTime: 0;
        property Item _root: root

        source: "qrc:/space/img/spaceship1.gif"
        rotation: (180 * _directionInRadians / Math.PI)

        Behavior on _directionInRadians {
            enabled: ship._collisionTime > 0;
            SequentialAnimation {
                PropertyAnimation {}
            }
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
            source: "qrc:/space/img/fire" + imgNr + ".png"
        }

        ShipRotation {
            id: shipRotation
            enabled: localRoot.mouseControlled == false;

            onRotationXChanged: {
                if (ship._collisionTime || _root.introMode)
                    return;
                var thrustRange = ship._rotationFullThrust - ship._rotationNoThrust;
                var t = ((rotationX - ship._rotationNoThrust) / thrustRange);
                if (t < 0) t = 0;
                if (t > 1) t = 1;
                localRoot.thrust = t;
            }

            onRotationYChanged: {
                if (ship._collisionTime || _root.introMode)
                    return;
                var r = rotationY / ship._rotationMaxBank;
                if (r < -1) r = -1;
                if (r >  1) r =  1;
                ship._directionInRadians += r * ship._directionAtMaxBank;
            }
        }

        function moveShip()
        {
            var sx = _speedX + (localRoot.thrust * localRoot.engineSize * Math.sin(_directionInRadians));
            var sy = _speedY - (localRoot.thrust * localRoot.engineSize * Math.cos(_directionInRadians));
            if (sx > _speedMaxX) sx = _speedMaxX;
            else if (sx < -_speedMaxX) sx = -_speedMaxX;
            if (sy > _speedMaxY) sy = _speedMaxY;
            else if (sy < -_speedMaxY) sy = -_speedMaxY;
            _speedX = sx
            _speedY = sy

            universeX += _speedX;
            universeY += _speedY;
        }

        function animateShip() {
            var nr = fire.imgNr + 1;
            if (nr > fire.imgCount) nr = 1;
            fire.imgNr = nr;
            fire.opacity = 0.4 + (0.6 * Math.random());
            fire.flipImage = Math.random() > 0.5 ? 1 : -1;
        }

        function resetCollision()
        {
            if (ship._collisionTime + 25 < _root.gameTime)
                ship._collisionTime = 0;
        }
    }

    function setUniverseDirection(x, y) {
        if (!localRoot.mouseControlled || ship._collisionTime || _root.introMode)
            return;

        var halfShipHeight = ship.height / 2;
        var halfShipWidth = ship.width / 2;
        var relX = localRoot.pos.x + halfShipWidth - x;
        var relY = localRoot.pos.y + halfShipHeight - y;
        ship._directionInRadians = -Math.atan2(relX, relY);

        var thrustStart = 120;
        var thrustEnd = 150;
        var thrustUnomalized = Math.sqrt((relX * relX) + (relY * relY)) - thrustStart;
        thrustUnomalized = thrustUnomalized / (thrustEnd - thrustStart);
        if (thrustUnomalized < 0) thrustUnomalized = 0;
        if (thrustUnomalized > 1) thrustUnomalized = 1;
        localRoot.thrust = thrustUnomalized;
    }

    function collideWithDebris()
    {
        if (ship._collisionTime || _root.introMode)
            return;

        ship._collisionTime = _root.gameTime;
        ship._directionInRadians += Math.PI;
        var driftSpeed = Math.abs(ship._speedX) + Math.abs(ship._speedY);
        ship._speedX = driftSpeed * Math.sin(-ship._directionInRadians);
        ship._speedY = driftSpeed * Math.cos(ship._directionInRadians);
        thrust = 0;
    }

    function gameStep() {
        ship.animateShip();
        ship.moveShip();
        if (ship._collisionTime)
            ship.resetCollision();
    }

    function reset()
    {
        universeX = 0;
        universeY = 0;
        thrust = 0;
        ship._directionInRadians = Math.PI / 2;
        ship._speedX = 0;
        ship._speedY = 0;
        ship._collisionTime = 0;
    }
}
