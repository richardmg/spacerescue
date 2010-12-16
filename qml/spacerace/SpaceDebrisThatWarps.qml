import Qt 4.7
import "global.js" as SharedScript

SpaceDebris {
    id: debris

    property real _warpWidth: -1
    property real _warpHeight: -1

    property Item ship

    boundingRadius: width/3
    onHeightChanged: (_root.introMode === true) ? intro() : reset();

    function reset() {
        _warpWidth = _root.width + 300;
        _warpHeight = _root.height + (height * 4)
        var startX = 250;

        universeX = startX + (SharedScript.random.next() * _warpWidth);
        universeY = -(_warpHeight / 2) + (SharedScript.random.next() * _warpHeight);

        var speedMaxX = -1
        var speedMaxY = 1

        if (_root.level > 18) {
            if (_root.level % 2)
                speedMaxX = -(_root.level/100) * 10
            else
                speedMaxY = (_root.level/100) * 10
        }

        speedX = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxX
        speedY = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxY * ((SharedScript.random.next() > 0.5) ? 1 : -1);
    }

    function intro() {
        _warpWidth = _root.width + 300;
        _warpHeight = _root.height + (height * 4)
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

        var distX = _root.cameraX - universeX;
        if (Math.abs(distX) > half_ww) {
            if (distX > 0) {
                universeX = _root.cameraX + half_ww;
            } else {
                var tmpX = _root.cameraX - half_ww;
                if (tmpX > 0)
                    universeX = tmpX;
            }
        }

        var distY = _root.cameraY - universeY;
        if (Math.abs(distY) > half_wh)
            universeY = _root.cameraY + (half_wh * ((distY > 0) ? 1 : -1));

        spaceDebris_gameStep();

        if (ship && !ship.inCollision && collidesWithGameObject(ship))
            ship.collideWithDebris();
    }

}
