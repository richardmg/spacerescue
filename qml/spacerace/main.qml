import Qt 4.7

Rectangle {
    id: top
    width: 360
    height: 360

    RaceTrack {
        id: track
        visible: true
        centerX: mousearea.mouseX
        centerY: mousearea.mouseY
    }

    Spaceship {
        id: ship
        x: top.width / 2
        y: top.height / 2
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: ship.setGlobalDirection(mouse.x, mouse.y)
    }
}
