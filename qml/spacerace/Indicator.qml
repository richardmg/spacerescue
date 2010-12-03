import Qt 4.7
import "global.js" as SharedScript

Image {
    id: indicator
    source: "qrc:/space/img/arrow.png"
    opacity: 0

    property variant target
    property bool visibleOnlyWhenOutsideScreen: true

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {}
        }
    }

    function gameStep()
    {
        // update indicator:
        var relX = target.universeX - SharedScript.cameraX;
        var relY = target.universeY - SharedScript.cameraY;
        var hotspotX = -((width - target.width) /2 );
        var hotspotY = -((height - target.height) /2);

        var onTargetX = (SharedScript.screenWidth / 2) + relX + hotspotX;
        var onTargetY = (SharedScript.screenHeight / 2) + relY + hotspotY;
        var screenBorderRight = SharedScript.screenWidth - width;
        var screenBorderBottom = SharedScript.screenHeight - height;

        var newX = Math.max(0, Math.min(onTargetX, screenBorderRight));
        var newY = Math.max(0, Math.min(onTargetY, screenBorderBottom));
        x = newX;
        y = newY;

        var rad = Math.atan2(relX, -relY);
        rotation = (rad * 360) / (2 * Math.PI);

        if (visibleOnlyWhenOutsideScreen && newX == onTargetX && newY == onTargetY)
            opacity = 0;
        else
            opacity = 1;
    }
}
