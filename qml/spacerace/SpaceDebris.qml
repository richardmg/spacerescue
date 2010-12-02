import Qt 4.7
import "global.js" as SharedScript

Item {
    id: universe
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real warpAreaMultiplier: 2
    property string bgimage: "" // without number and extension
    property int imageCount: 1
    property int _currentImageNr: 1

    property real _speedX: 0
    property real _speedY: 0
    property real _speedMaxX: 1
    property real _speedMaxY: 1

    Component.onCompleted: {
        placeDebrisOnRandomUniverseBorder();
    }

    function placeDebrisOnRandomUniverseBorder()
    {
        var ww = SharedScript.screenWidth * warpAreaMultiplier
        var wh = SharedScript.screenHeight * warpAreaMultiplier
        var leftSide = Math.random() > 0.5;

        universeX = SharedScript.cameraX + (leftSide ? -ww / 2 : wh / 2);
        universeY = (SharedScript.cameraY - (wh / 2)) + (Math.random() * wh);

        _speedX = (0.4 + (Math.random() * 0.6)) * _speedMaxX * (leftSide ? 1 : -1);
        _speedY = (0.4 + (Math.random() * 0.6)) * _speedMaxY * ((Math.random() > 0.5) ? 1 : -1);
    }

    function gameStep()
    {
        universeX += _speedX;
        universeY += _speedY;

        var half_ww = (SharedScript.screenWidth * warpAreaMultiplier) / 2;
        var half_wh = (SharedScript.screenHeight * warpAreaMultiplier) / 2;

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
    }

    Image {
        id: debris
    }
}
