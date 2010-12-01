import Qt 4.7

Item {
    id: universe
    property real positionX
    property real positionY
    property real planetPositionX
    property real planetPositionY
    property real distance: 1
    property string bgimage: ""

    onPositionXChanged: updatePlanet();
    Component.onCompleted: updatePlanet();

    function updatePlanet()
    {
        var posX = positionX * distance;
        var posY = positionY * distance;
        planet.x = -(-planetPositionX + posX + (width / 2));
        planet.y = planetPositionY + posY + (height / 2);
    }

    Image {
        id: planet
        source: bgimage
    }
}
