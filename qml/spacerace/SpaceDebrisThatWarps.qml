import Qt 4.7
import "global.js" as SharedScript

SpaceDebris {
    id: debris

    property real _warpWidth: -1
    property real _warpHeight: -1

    property variant ship
    property bool introMode: false;

    onHeightChanged: (SharedScript.introMode === true) ? intro() : reset();

    function reset() {
        _warpWidth = SharedScript.screenWidth + 300;
        _warpHeight = SharedScript.screenHeight + (height * 4)
        var startX = 250;

        universeX = startX + (SharedScript.random.next() * _warpWidth);
        universeY = -(_warpHeight / 2) + (SharedScript.random.next() * _warpHeight);

        var speedMaxX = -1
        var speedMaxY = 1

        if (SharedScript.level > 18) {
            if (SharedScript.level % 2)
                speedMaxX = -(SharedScript.level/100) * 5
            else
                speedMaxY = (SharedScript.level/100) * 5
        }

        speedX = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxX
        speedY = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxY * ((SharedScript.random.next() > 0.5) ? 1 : -1);
    }

    function intro() {
        _warpWidth = SharedScript.screenWidth + 300;
        _warpHeight = SharedScript.screenHeight + (height * 4)
        var startX = 2500;

        universeX = startX - (SharedScript.random.next() * _warpWidth);
        universeY = -(_warpHeight / 2) + (SharedScript.random.next() * _warpHeight);

        var speedMaxX = -5
        var speedMaxY = 1

        speedX = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxX
        speedY = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxY * ((SharedScript.random.next() > 0.5) ? 1 : -1);
    }

    function gameStep()
    {
        var half_ww = _warpWidth / 2;
        var half_wh = _warpHeight / 2;

        var distX = SharedScript.cameraX - universeX;
        if (Math.abs(distX) > half_ww) {
            if (distX > 0) {
                universeX = SharedScript.cameraX + half_ww;
            } else {
                var tmpX = SharedScript.cameraX - half_ww;
                if (tmpX > 0)
                    universeX = tmpX;
            }
        }

        var distY = SharedScript.cameraY - universeY;
        if (Math.abs(distY) > half_wh)
            universeY = SharedScript.cameraY + (half_wh * ((distY > 0) ? 1 : -1));

        spaceDebris_gameStep();

        if (ship && !ship.inCollision && SharedScript.collidesWithShip(this, width/3, 0, 0))
            ship.collideWithDebris();
    }

    function setIntroMode(mode) {
        debris.introMode = mode;
    }
}
