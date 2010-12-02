import Qt 4.7
import "global.js" as SharedScript

Item {
    id: universe
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real warpWidth: 2000
    property real warpHeight: 2000

    property string bgimage: "" // without number and extension
    property int imageCount: 1
    property int _currentImageNr: 1

    property real _speedX: 0
    property real _speedY: 0
    property real _speedMaxX: 1
    property real _speedMaxY: 1

    property variant ship

    width:  debris.width
    height: debris.height

    Component.onCompleted: {
        universeX = SharedScript.cameraX - (warpWidth / 2) + (Math.random() * warpWidth);
        universeY = SharedScript.cameraY - (warpHeight / 2) + (Math.random() * warpHeight);

        _speedX = (0.4 + (Math.random() * 0.6)) * _speedMaxX
        _speedY = (0.4 + (Math.random() * 0.6)) * _speedMaxY * ((Math.random() > 0.5) ? 1 : -1);
    }

    function gameStep()
    {
        universeX += _speedX;
        universeY += _speedY;

        var half_ww = warpWidth / 2;
        var half_wh = warpHeight / 2;
        var distX = SharedScript.cameraX - universeX;
        if (Math.abs(distX) > half_ww)
            universeX = SharedScript.cameraX + (half_ww * ((distX > 0) ? 1 : -1));

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
    }
}
