import Qt 4.7

Rectangle {
    id: top
    width: 800
    height: 600
    color: "#000000"

    UniverseBackground {
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
        bgimage: "qrc:/space/img/frontstars.gif"
        distance: 0.1
    }

    PlanetBackground {
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
        planetPositionX: 500
        planetPositionY: 100
        bgimage: "qrc:/space/img/sun.png"
        distance: 0.11
    }

    PlanetBackground {
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
        planetPositionX: -100
        planetPositionY: 280
        bgimage: "qrc:/space/img/earth.png"
        distance: 0.2
    }

    PlanetBackground {
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
        planetPositionX: 1200
        planetPositionY: 600
        bgimage: "qrc:/space/img/moon.png"
        distance: 0.3
    }

    UniverseBackground {
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
        windx: 1
        windy: 1
        bgimage: "qrc:/space/img/universe.png"
        distance: 2
    }

    Spaceship {
        id: ship
        x: top.width / 2
        y: top.height / 2
        mouseControlled: mousearea.pressed
    }

    UniverseBackground {
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
        windx: 2
        windy: 2
        bgimage: "qrc:/space/img/universetop2.png"
        distance: 6
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: ship.setGlobalDirection(mouse.x, mouse.y)
    }

    Timer {
        id: gameTimer
        interval: 50;
        running: true;
        repeat: true

        onTriggered: {
            ship.gameStep();
        }
    }

}
