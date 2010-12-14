import Qt 4.7
import "global.js" as SharedScript

Item {
    id: challenger
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real speedX: 0
    property real speedY: 0
    property real rotationSpeed: 0.1
    property real currentRotation: 0
    transform: Rotation { origin.x: 400; origin.y: 400; angle: currentRotation}
    smooth: true
    property string bgimage: ""

    function gameStep()
    {
        top.gameStep();
        bottom.gameStep();
        currentRotation += rotationSpeed;
    }

    width: top.width
    height: top.height + bottom.height

    function explode()
    {
        top.rotationSpeed = 2.5
        top.speedY = -2
        bottom.rotationSpeed = -1.5
        bottom.speedY = 1.5
    }

    PlanetBackground {
        id: top
        universeX: challenger.universeX
        universeY: challenger.universeY
        speedX: challenger.speedX
        speedY: challenger.speedY
        bgimage: "qrc:/space/img/challenger_top.png"
    }

    PlanetBackground {
        id: bottom
        universeX: challenger.universeX + 80
        universeY: challenger.universeY - 37
        speedX: challenger.speedX
        speedY: challenger.speedY
        bgimage: "qrc:/space/img/challenger_bottom.png"
    }

}
