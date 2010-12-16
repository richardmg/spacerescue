import Qt 4.7
import "global.js" as SharedScript

SpaceDebris {
    property Item ship

    bgimage: "qrc:/space/img/astronaut"
    imageCount: 2
    imageSpeed: 15
    rotationSpeed: -0.2
    boundingRadius: width / 2

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {}
        }
    }

    function gameStep()
    {
        if (ship && _root.introMode == false && collidesWithGameObject(ship)) {
            opacity = 0
            _root.endGame();
        }
        spaceDebris_gameStep();
    }

    function reset()
    {
        universeX = 5000;
        universeY = 0;
        opacity = 1;
        rotationSpeed = 0;
        rotation = 0;
    }
}
