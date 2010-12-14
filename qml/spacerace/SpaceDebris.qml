import Qt 4.7
import "global.js" as SharedScript

Item {
    id: universe
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real _warpWidth: -1
    property real _warpHeight: -1

    property string bgimage: "" // without number and extension
    property int imageCount: 1
    property int imageSpeed: 1
    property int _currentImageNr: SharedScript.random.next() * imageCount

    property real _speedX: 0
    property real _speedY: 0

    property variant ship
    property bool introMode: false;

    width:  debris.width
    height: debris.height

    function reset() {
        _warpWidth = SharedScript.screenWidth + 300;
        _warpHeight = SharedScript.screenHeight + (debris.height * 4)
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

        _speedX = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxX
        _speedY = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxY * ((SharedScript.random.next() > 0.5) ? 1 : -1);
    }

    function intro() {
        _warpWidth = SharedScript.screenWidth + 300;
        _warpHeight = SharedScript.screenHeight + (debris.height * 4)
        var startX = 2500;

        universeX = startX - (SharedScript.random.next() * _warpWidth);
        universeY = -(_warpHeight / 2) + (SharedScript.random.next() * _warpHeight);

        var speedMaxX = -5
        var speedMaxY = 1

        _speedX = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxX
        _speedY = (0.4 + (SharedScript.random.next() * 0.6)) * speedMaxY * ((SharedScript.random.next() > 0.5) ? 1 : -1);
    }

    function gameStep()
    {
        universeX += _speedX;
        universeY += _speedY;

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

        if ((SharedScript.gameTime % imageSpeed) == 0) {
            var nr = _currentImageNr + 1;
            if (nr > imageCount -1 ) nr = 0;
            _currentImageNr = nr;
            debris.source = bgimage + _currentImageNr + ".png";
        }
        SharedScript.updateScreenPositionFor(this);

        if (ship && !ship.inCollision && SharedScript.collidesWithShip(this, width/3, 0, 0))
            ship.collideWithDebris();
    }

    function setIntroMode(mode) {
        universe.introMode = mode;
        console.debug(universe.introMode)
    }

    Image {
        id: debris
        onHeightChanged: (SharedScript.introMode === true) ? universe.intro() : universe.reset();
    }
}
