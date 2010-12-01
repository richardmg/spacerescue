import Qt 4.7

Item {
    id: universe
    property real cameraX: 0
    property real cameraY: 0

    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real universeWidth: 1000
    property real universeHeight: 1000
    property real screenWidth: 800
    property real screenHeight: 600

    property string bgimage: "" // without number and extension
    property int imageCount: 1
    property int _currentImageNr: 1

    property real _halfUniverseWidth:  universeWidth / 2;
    property real _halfUniverseHeight: universeHeight / 2;

    property real _speedX: 0
    property real _speedY: 0
    property real _speedMaxX: 0.5
    property real _speedMaxY: 0.5

    Component.onCompleted: {
        placeDebrisOnRandomUniverseBorder();
    }

    function placeDebrisOnRandomUniverseBorder()
    {
        universeX = cameraX + (0.1 > 0.5 ? -universeWidth / 2 : universeWidth / 2);
        universeY = (cameraY - (universeHeight / 2)) + (Math.random() * universeHeight);
        _speedX = (0.3 + (Math.random() * 0.7)) * _speedMaxX;
        _speedY = (0.3 + (Math.random() * 0.7)) * _speedMaxY;
    }

    function gameStep()
    {
        universeX += _speedX;
        universeY += _speedY;

        console.debug(universeX + ", " + universeY);
//        if (universeX < cameraX + _halfUniverseWidth) universeX = cameraX + _halfUniverseWidth;
//        else if (universeX > cameraX + _halfUniverseWidth) universeX = cameraX - _halfUniverseWidth;
//        if (universeY < cameraY + _halfUniverseHeight) universeY = cameraY + _halfUniverseHeight;
//        else if (universeY > cameraY + _halfUniverseHeight) universeY = cameraY - _halfUniverseHeight;

        var nr = _currentImageNr + 1;
        if (nr > imageCount -1 ) nr = 0;
        _currentImageNr = nr;
        debris.source = bgimage + _currentImageNr + ".png";

        // Calculate from universe position to screen position:
        var posX = cameraX * universeZ;
        var posY = cameraY * universeZ;
        debris.x = -universeX + posX + (screenWidth / 2);
        debris.y = -universeY + posY + (screenHeight / 2);
    }

    Image {
        id: debris
    }
}
