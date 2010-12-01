import Qt 4.7

Item {
    id: universe
    property real cameraX: 0
    property real cameraY: 0

    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property string bgimage: ""

    function gameStep()
    {
        // Calculate from universe position to screen position:
        var posX = cameraX * universeZ;
        var posY = cameraY * universeZ;
        planet.x = -(-universeX + posX + (width / 2));
        planet.y = universeY + posY + (height / 2);
    }

    Image {
        id: planet
        source: bgimage
    }
}
