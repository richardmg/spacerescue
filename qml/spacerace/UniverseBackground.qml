import Qt 4.7

Item {
    id: universe
    property real cameraX: 0
    property real cameraY: 0

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
        var posX = (cameraX + universeX) * universeZ;
        var posY = (cameraY + universeY) * universeZ;
        var tileX = Math.round((posX / bg11.width) - 0.5);
        var tileY = Math.round((posY / bg11.height) - 0.5);

        var tmpx = (tileX * bg11.width)  + (_halfWidth - posX);
        var tmpy = (tileY * bg11.height) + (_halfHeight - posY);

        bg11.x = tmpx - universe._halfWidth;
        bg12.x = tmpx + universe._halfWidth;
        bg21.x = tmpx - universe._halfWidth;
        bg22.x = tmpx + universe._halfWidth;

        bg11.y = -(tmpy - universe._halfHeight);
        bg12.y = -(tmpy - universe._halfHeight);
        bg21.y = -(tmpy + universe._halfHeight);
        bg22.y = -(tmpy + universe._halfHeight);
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
