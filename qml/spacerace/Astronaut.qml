import Qt 4.7
import "global.js" as SharedScript

Item {
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real speedX: 3
    property real speedY: 0

    property string bgimage: "qrc:/space/img/astronaut"
    property int imageCount: 2
    property int imageSpeed: 20
    property int _currentImageNr: Math.random() * imageCount

    property variant ship

    width:  astronaut.width
    height: astronaut.height

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {}
        }
    }

    function gameStep(time)
    {
        universeX += speedX;
        universeY += speedY;

        if ((time % imageSpeed) == 0) {
            var nr = _currentImageNr + 1;
            if (nr > imageCount -1 ) nr = 0;
            _currentImageNr = nr;
            astronaut.source = bgimage + _currentImageNr + ".png";
        }
        SharedScript.updateScreenPositionFor(this);

        if (SharedScript.collidesWithShip(this, width/2, 0, 0)) {
            opacity = 0
            ship.collideWithAstronaut();
        }
    }

    Image {
        id: astronaut
    }

}
