import Qt 4.7

Item {
    id: universe
    property real cameraX: 0
    property real cameraY: 0

    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real universeWidth: screenWidth * 2
    property real universeHeight: screenHeight * 2
    property real screenWidth: 800
    property real screenHeight: 400

    property string bgimage: "" // without number and extension
    property int imageCount: 1
    property int _currentImageNr: 1

    property real _halfUniverseWidth:  universeWidth / 2;
    property real _halfUniverseHeight: universeHeight / 2;

    property real _speedX: 0
    property real _speedY: 0
    property real _speedMaxX: 1
    property real _speedMaxY: 1

    Component.onCompleted: {
        placeDebrisOnRandomUniverseBorder();
    }

    function placeDebrisOnRandomUniverseBorder()
    {
        var leftSide = Math.random() > 0.5;
        universeX = cameraX + (leftSide ? -universeWidth / 2 : universeWidth / 2);
        universeY = (cameraY - (universeHeight / 2)) + (Math.random() * universeHeight);

        _speedX = (0.4 + (Math.random() * 0.6)) * _speedMaxX * (leftSide ? 1 : -1);
        _speedY = (0.4 + (Math.random() * 0.6)) * _speedMaxY * ((Math.random() > 0.5) ? 1 : -1);
    }

    function gameStep()
    {
        universeX += _speedX;
        universeY += _speedY;

        var distX = cameraX - universeX;
        if (Math.abs(distX) > _halfUniverseWidth)
            universeX = cameraX + (_halfUniverseWidth * ((distX > 0) ? 1 : -1));

        var distY = cameraY - universeY;
        if (Math.abs(distY) > _halfUniverseHeight)
            universeY = cameraY + (_halfUniverseHeight * ((distY > 0) ? 1 : -1));

        var nr = _currentImageNr + 1;
        if (nr > imageCount -1 ) nr = 0;
        _currentImageNr = nr;
        debris.source = bgimage + _currentImageNr + ".png";

        // Calculate from universe position to screen position:
        var posX = cameraX * universeZ;
        var posY = cameraY * universeZ;
        debris.x = universeX - posX + (screenWidth / 2);
        debris.y = -universeY + posY + (screenHeight / 2);
    }

    Image {
        id: debris
    }
}
