import Qt 4.7

Rectangle {
    id: top
    width: 800
    height: 600
    color: "#000000"

    PlanetBackground {
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
        bgimage: "qrc:/space/img/sun.gif"
        distance: 0.2
    }

    UniverseBackground {
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
        bgimage: "qrc:/space/img/frontstars.gif"
        distance: 0.3
    }

    UniverseBackground {
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
        bgimage: "qrc:/space/img/universe2.png"
        distance: 3
    }

    Spaceship {
        id: ship
        x: top.width / 2
        y: top.height / 2
        mouseControlled: mousearea.pressed
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
