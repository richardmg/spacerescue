import Qt 4.7
import "global.js" as SharedScript

Item {
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real speedX: 0
    property real speedY: 0
    property real rotationSpeed: 0

    // assign bgimage without number and extension when imageCount > 0
    property string bgimage: ""
    property int imageCount: 0
    property int imageSpeed: 1
    property int _currentImageNr: SharedScript.random.next() * imageCount

    width: image.width
    height: image.height

    function spaceDebris_gameStep()
    {
        universeX += speedX;
        universeY += speedY;
        rotation += rotationSpeed;

        if (imageCount > 0 && (SharedScript.gameTime % imageSpeed) == 0) {
            var nr = _currentImageNr + 1;
            if (nr > imageCount -1 ) nr = 0;
            _currentImageNr = nr;
            image.source = bgimage + _currentImageNr + ".png";
        }

        SharedScript.updateScreenPositionFor(this);
//        console.debug(bgimage, universeX, universeY)
    }
    function gameStep() {spaceDebris_gameStep();}

    Image {
        id: image
        source: (imageCount > 0 && bgimage.length > 0) ? (bgimage + "0.png") : bgimage
    }
}
