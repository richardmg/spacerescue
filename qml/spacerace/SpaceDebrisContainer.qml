import Qt 4.7
import "global.js" as SharedScript

Item {
    id: top
    property variant ship

    function gameStep()
    {
        for (var i=0; i<SharedScript.debrisArray.length; ++i) {
            var debris = SharedScript.debrisArray[i];
            debris.gameStep();
        }
    }

    function reset()
    {
        SharedScript.eraseDebrisArray();

        var debrisComponent = Qt.createComponent("SpaceDebris.qml");
        if (debrisComponent.status == Component.Ready) {
            for (var i=0; i<20; ++i) {
                var debris = debrisComponent.createObject(top);
                debris.imageCount = 32
                debris.bgimage = "qrc:/space/img/rock1/rock100"
                debris.ship = ship;
                SharedScript.debrisArray.push(debris);
            }
        }
    }
}
