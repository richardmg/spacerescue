import Qt 4.7
import "global.js" as SharedScript

Image {
    id: indicator
    source: "qrc:/space/img/arrow.png"
    opacity: 0

    property Item _root: root
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
        var relX = target.universeX - _root.cameraX;
        var relY = target.universeY - _root.cameraY;
        var hotspotX = -((width - target.width) /2 );
        var hotspotY = -((height - target.height) /2);

        var onTargetX = (_root.width / 2) + relX + hotspotX;
        var onTargetY = (_root.height / 2) + relY + hotspotY;
        var screenBorderRight = _root.width - width;
        var screenBorderBottom = _root.height - height;

        var newX = Math.max(0, Math.min(onTargetX, screenBorderRight));
        var newY = Math.max(0, Math.min(onTargetY, screenBorderBottom));
        x = newX;
        y = newY;

        var rad = Math.atan2(relX, -relY);
        rotation = (rad * 360) / (2 * Math.PI);

        if (visibleOnlyWhenOutsideScreen && newX == onTargetX && newY == onTargetY)
            opacity = 0;
        else if (target.opacity != 0)
            opacity = 1;
        else
            opacity = 0;
    }
}
