import Qt 4.7
import "global.js" as SharedScript

SpaceDebris {
    property Item root

    bgimage: "qrc:/space/img/astronaut"
    imageCount: 2
    imageSpeed: 15
    rotationSpeed: -0.2

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {}
        }
    }

    function gameStep()
    {
        if (root && SharedScript.collidesWithShip(this, width/2, 0, 0)) {
            opacity = 0
            root.endGame();
        }
        spaceDebris_gameStep();
    }

    function reset()
    {
        universeX = 200;//5000;
        universeY = 0;
        opacity = 1;
        rotationSpeed = 0;
        rotation = 0;
    }
}
