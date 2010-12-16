import Qt 4.7

Item {
    id: localRoot
    property Item _root: root

    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    property real boundingRadius: 0
    property real _collisionCenterX: universeX + (width / 2)
    property real _collisionCenterY: universeY + (height / 2)

    property bool showBoundingBox: false

    function updateScreenPosition()
    {
        // Calculate from universe position to screen position:
        var posX = _root.cameraX * universeZ;
        var posY = _root.cameraY * universeZ;
        x = universeX - posX + (_root.width / 2);
        y = universeY - posY + (_root.height / 2);
    }

    function collidesWithGameObject(target)
    {
        var distanceX = _collisionCenterX - target._collisionCenterX
        var distanceY = _collisionCenterY - target._collisionCenterY
        var minimumDistance = boundingRadius + target.boundingRadius;

        if (distanceX > minimumDistance)
            return false;
        if (distanceY > minimumDistance)
            return false;
        if (Math.sqrt((distanceX * distanceX) + (distanceY * distanceY)) < minimumDistance)
            return true;

        return false;
    }

    Rectangle {
        id: boundingBoxDebug
        color: "red"
        opacity:  0.5
        visible: localRoot.showBoundingBox
        z: 100
        x: (localRoot.width / 2) - localRoot.boundingRadius
        y: (localRoot.width / 2) - localRoot.boundingRadius
        width: localRoot.boundingRadius * 2;
        height: localRoot.boundingRadius * 2;
    }
}
