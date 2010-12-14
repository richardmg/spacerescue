import Qt 4.7
import "global.js" as SharedScript

Item {
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real speedX: 0
    property real speedY: 0
    property real rotationSpeed: 0

    property string bgimage: "" // without number and extension when animation
    property int imageCount: 0
    property int imageSpeed: 1
    property int _currentImageNr: SharedScript.random.next() * imageCount

    width: image.width
    height: image.height

    function gameStep()
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
    }

    Image {
        id: image
        source: (imageCount > 0) ? (bgimage + "0.png") : bgimage
    }
}
