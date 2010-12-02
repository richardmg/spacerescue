import Qt 4.7
import "global.js" as SharedScript

Item {
    function gameStep()
    {
        for (var i=0; i<SharedScript.debrisArray.length; ++i) {
            var debris = SharedScript.debrisArray[i];
            debris.gameStep();
        }
    }

    Component.onCompleted: {
        // Create all debris:
        var debrisComponent = Qt.createComponent("SpaceDebris.qml");
        if (debrisComponent.status == Component.Ready) {
            for (var i=0; i<10; ++i) {
                var debris = debrisComponent.createObject(parent);
                debris.imageCount = 32
                debris.bgimage = "qrc:/space/img/rock1/rock100"
                SharedScript.debrisArray.push(debris);
            }
        }
    }
}
