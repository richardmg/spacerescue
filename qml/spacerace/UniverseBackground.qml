import Qt 4.7

Item {
    id: universe
    property real positionX: 0
    property real positionY: 0
    property real windx: 0
    property real windy: 0

    property real distance: 1
    property string bgimage: ""

    property real halfWidth:  bg11.width / 2;
    property real halfHeight: bg11.height / 2;

    onPositionXChanged: updateUniverse();
    Component.onCompleted: updateUniverse();

    function updateUniverse()
    {
           var posX = positionX * distance;
           var posY = positionY * distance;
           var tileX = Math.round((posX / bg11.width) - 0.5);
           var tileY = Math.round((posY / bg11.height) - 0.5);

           var tmpx = (tileX * bg11.width)  + (halfWidth - posX);
           var tmpy = (tileY * bg11.height) + (halfHeight - posY);

           bg11.x = tmpx - universe.halfWidth;
           bg12.x = tmpx + universe.halfWidth;
           bg21.x = tmpx - universe.halfWidth;
           bg22.x = tmpx + universe.halfWidth;

           bg11.y = -(tmpy - universe.halfHeight);
           bg12.y = -(tmpy - universe.halfHeight);
           bg21.y = -(tmpy + universe.halfHeight);
           bg22.y = -(tmpy + universe.halfHeight);
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
