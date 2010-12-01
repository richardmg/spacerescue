import Qt 4.7

Item {
    id: universe
    property real cameraX
    property real cameraY
    property real universeX
    property real universeY
    property real distance: 1
    property string bgimage: ""

    function gameStep()
    {
        var posX = cameraX * distance;
        var posY = cameraY * distance;
        planet.x = -(-universeX + posX + (width / 2));
        planet.y = universeY + posY + (height / 2);
    }

    Image {
        id: planet
        source: bgimage
    }
}
