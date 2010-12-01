import Qt 4.7

Item {
    id: universe
    property real cameraX
    property real cameraY
    property real planetX
    property real planetY
    property real distance: 1
    property string bgimage: ""

    onCameraXChanged: updatePlanet();
    Component.onCompleted: updatePlanet();

    function updatePlanet()
    {
        var posX = cameraX * distance;
        var posY = cameraY * distance;
        planet.x = -(-planetX + posX + (width / 2));
        planet.y = planetY + posY + (height / 2);
    }

    Image {
        id: planet
        source: bgimage
    }
}
