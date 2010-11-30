import Qt 4.7

Rectangle {
    id: top
    width: 800
    height: 600

    UniverseBackground {
        id: universeBackground
        positionX: ship.logicalPosX
        positionY: ship.logicalPosY
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
