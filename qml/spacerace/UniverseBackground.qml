import Qt 4.7

Item {
    id: universe
    property real positionX
    property real positionY

    property real halfWidth:  bg11.width / 2;
    property real halfHeight: bg11.height / 2;

    onPositionXChanged: {
        var tileX = Math.round((positionX / bg11.width) - 0.5);
        var tileY = Math.round((positionY / bg11.height) - 0.5);

        var tmpx = (tileX * bg11.width)  + (universe.halfWidth - universe.positionX);
        var tmpy = (tileY * bg11.height) + (universe.halfHeight - universe.positionY);

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
        source: "qrc:/space/img/trackmask.png"
    }
    Image {
        id: bg12
        source: "qrc:/space/img/trackmask.png"
    }
    Image {
        id: bg21
        source: "qrc:/space/img/trackmask.png"
    }
    Image {
        id: bg22
        source: "qrc:/space/img/trackmask.png"
    }
}
