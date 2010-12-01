import Qt 4.7

Rectangle {
    id: top
    width: 800
    height: 600
    color: "#000000"

    UniverseBackground {
        id: bgStars
        cameraX: ship.universeX
        cameraY: ship.universeY
        bgimage: "qrc:/space/img/frontstars.gif"
        distance: 0.1
    }

    PlanetBackground {
        id: bgSun
        cameraX: ship.universeX
        cameraY: ship.universeY
        universeX: 500
        universeY: 100
        bgimage: "qrc:/space/img/sun.png"
        distance: 0.11
    }

    PlanetBackground {
        id: bgEarth
        cameraX: ship.universeX
        cameraY: ship.universeY
        universeX: -100
        universeY: 280
        bgimage: "qrc:/space/img/earth.png"
        distance: 0.2
    }

    PlanetBackground {
        id: bgMoon
        cameraX: ship.universeX
        cameraY: ship.universeY
        universeX: 1200
        universeY: 600
        bgimage: "qrc:/space/img/moon.png"
        distance: 0.3
    }

    UniverseBackground {
        id: bgBlueFog
        cameraX: ship.universeX
        cameraY: ship.universeY
        windX: 0.1
        windY: 0.1
        bgimage: "qrc:/space/img/universe.png"
        distance: 3
    }

    Spaceship {
        id: ship
        x: top.width / 2
        y: top.height / 2
        mouseControlled: mousearea.pressed
    }

    UniverseBackground {
        id: bgGrayFog
        cameraX: ship.universeX
        cameraY: ship.universeY
        windX: 0.2
        windY: 0.2
        bgimage: "qrc:/space/img/universetop2.png"
        distance: 8
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: ship.setUniverseDirection(mouse.x, mouse.y)
    }

    Timer {
        id: gameTimer
        interval: 50;
        running: true;
        repeat: true

        onTriggered: {
            ship.gameStep();
            bgStars.gameStep();
            bgSun.gameStep();
            bgEarth.gameStep();
            bgMoon.gameStep();
            bgBlueFog.gameStep();
            bgGrayFog.gameStep();
        }
    }

}
