import Qt 4.7
import "global.js" as SharedScript

Item {
    id: challenger
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real speedX: 0
    property real speedY: 0
    property real rotationSpeed: 0.07
    property real currentRotation: 0
    transform: Rotation { origin.x: 150; origin.y: 150; angle: currentRotation}
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
        top.speedY = -1.5
        bottom.rotationSpeed = -1.5
        bottom.speedY = 1.0
    }

    SpaceDebris {
        id: top
        universeX: challenger.universeX
        universeY: challenger.universeY
        speedX: challenger.speedX
        speedY: challenger.speedY
        bgimage: "qrc:/space/img/challenger_top.png"
    }

    SpaceDebris {
        id: bottom
        universeX: challenger.universeX + 80
        universeY: challenger.universeY - 37
        speedX: challenger.speedX
        speedY: challenger.speedY
        bgimage: "qrc:/space/img/challenger_bottom.png"
    }

}
