import Qt 4.7
import "global.js" as SharedScript

Item {
    property real universeX: Math.min(1000, Math.max(6000, (SharedScript.level * 500)));
    property real universeY: 0
    property real universeZ: 1

    property real speedX: 0
    property real speedY: 0

    property string bgimage: "qrc:/space/img/astronaut"
    property int imageCount: 2
    property int imageSpeed: 15
    property int _currentImageNr: SharedScript.random.next() * imageCount

    property Item ship
    property Item root

    width:  astronaut.width
    height: astronaut.height

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {}
        }
    }

    function gameStep()
    {
        universeX += speedX;
        universeY += speedY;

        if ((SharedScript.gameTime % imageSpeed) == 0) {
            var nr = _currentImageNr + 1;
            if (nr > imageCount -1 ) nr = 0;
            _currentImageNr = nr;
            astronaut.source = bgimage + _currentImageNr + ".png";
        }
        SharedScript.updateScreenPositionFor(this);

        if (SharedScript.collidesWithShip(this, width/2, 0, 0)) {
            opacity = 0
            root.endGame();
        }
    }

    function reset()
    {
        universeX = Math.max(1000, Math.min(6000, (SharedScript.level * 500)));
        universeY = 0;
        opacity = 1;
    }

    Image {
        id: astronaut
    }

}
