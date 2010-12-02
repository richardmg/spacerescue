import Qt 4.7

    var debris = [];

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
        universeZ: 0.1
    }

    PlanetBackground {
        id: bgSun
        cameraX: ship.universeX
        cameraY: ship.universeY
        universeX: 500
        universeY: 100
        bgimage: "qrc:/space/img/sun.png"
        universeZ: 0.11
    }

    PlanetBackground {
        id: bgEarth
        cameraX: ship.universeX
        cameraY: ship.universeY
        universeX: -100
        universeY: 280
        bgimage: "qrc:/space/img/earth.png"
        universeZ: 0.2
    }

    PlanetBackground {
        id: bgMoon
        cameraX: ship.universeX
        cameraY: ship.universeY
        universeX: 1200
        universeY: 600
        bgimage: "qrc:/space/img/moon.png"
        universeZ: 0.3
    }

    UniverseBackground {
        id: bgBlueFog
        cameraX: ship.universeX
        cameraY: ship.universeY
        windX: 0.1
        windY: 0.1
        bgimage: "qrc:/space/img/universe.png"
        universeZ: 3
    }

    Spaceship {
        id: ship
        x: p.width / 2
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
        universeZ: 6
    }

    Repeater {
        model: 10
        SpaceDebris {
            imageCount: 32
            bgimage: "qrc:/space/img/rock1/rock100"
            cameraX: ship.universeX
            cameraY: ship.universeY
            screenWidth: parent.width
            screenHeight: parent.height
            Component.onCompleted: debris.push(self);
        }
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
//            rock1.gameStep();
        }
    }

}
