import Qt 4.7
import "global.js" as SharedScript

Item {
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real windX: 0
    property real windY: 0

    property string bgimage: ""

    property real _halfWidth:  bg11.width / 2;
    property real _halfHeight: bg11.height / 2;

    function gameStep()
    {
        universeX += windX;
        universeY += windY;

        // Calculate from universe position to screen position:
        var posX = (SharedScript.cameraX + universeX) * universeZ;
        var posY = (SharedScript.cameraY + universeY) * universeZ;
        var tileX = Math.round((posX / bg11.width) - 0.5);
        var tileY = Math.round((posY / bg11.height) - 0.5);

        var tmpx = (tileX * bg11.width)  + (_halfWidth - posX);
        var tmpy = -((tileY * bg11.height) + (_halfHeight - posY));

        bg11.x = tmpx - _halfWidth;
        bg12.x = tmpx + _halfWidth;
        bg21.x = tmpx - _halfWidth;
        bg22.x = tmpx + _halfWidth;

        bg11.y = -(tmpy - _halfHeight);
        bg12.y = -(tmpy - _halfHeight);
        bg21.y = -(tmpy + _halfHeight);
        bg22.y = -(tmpy + _halfHeight);
    }

    Image {
        id: bg11
        source: bgimage
    }
    Image {
        id: bg12
        source: bgimage
    }
    Image {
        id: bg21
        source: bgimage
    }
    Image {
        id: bg22
        source: bgimage
    }
}
