import Qt 4.7

Item {
    property real cameraX: 0
    property real cameraY: 0

    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property string bgimage: "" // without number and extension
    property int imageCount: 1
    property int _currentImageNr: 1

    function gameStep()
    {
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
