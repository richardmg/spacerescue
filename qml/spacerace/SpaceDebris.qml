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
    property int _currentImageNr: Math.random() * imageCount

    property real _speedX: 0
    property real _speedY: 0
    property real _speedMaxX: -1
    property real _speedMaxY: 1

    property variant ship

    width:  debris.width
    height: debris.height

    function placeDebris() {
        _warpWidth = SharedScript.screenWidth + 300;
        _warpHeight = SharedScript.screenHeight + (debris.height * 4)
        var startX = 250;

        universeX = startX + (Math.random(1) * _warpWidth);
        universeY = -(_warpHeight / 2) + (Math.random(1) * _warpHeight);

        _speedX = (0.4 + (Math.random() * 0.6)) * _speedMaxX
        _speedY = (0.4 + (Math.random() * 0.6)) * _speedMaxY * ((Math.random(1) > 0.5) ? 1 : -1);
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
                var tmpX = SharedScript.cameraX + half_ww;
                if (tmpX < SharedScript.distanteToAstronaut - 200)
                    universeX = tmpX;
           } else {
                var tmpX = SharedScript.cameraX - half_ww;
                if (tmpX > 0)
                    universeX = tmpX;
            }
        }

        var distY = SharedScript.cameraY - universeY;
        if (Math.abs(distY) > half_wh)
            universeY = SharedScript.cameraY + (half_wh * ((distY > 0) ? 1 : -1));

        var nr = _currentImageNr + 1;
        if (nr > imageCount -1 ) nr = 0;
        _currentImageNr = nr;
        debris.source = bgimage + _currentImageNr + ".png";

        SharedScript.updateScreenPositionFor(this);

        if (!ship.inCollision && SharedScript.collidesWithShip(this, width/3, 0, 0))
            ship.collideWithDebris();
    }

    Image {
        id: debris
        onHeightChanged: parent.placeDebris();
    }
}
