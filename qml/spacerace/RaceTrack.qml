import Qt 4.7
import "global.js" as SharedScript

Item {
    property real universeX: 0
    property real universeY: 0
    property real universeZ: 1

    function gameStep()
    {
        for (var i=0; i<SharedScript.gateArray.length; ++i) {
            var gate = SharedScript.gateArray[i];
            gate.gameStep();
        }
    }

    Component.onCompleted: {
        // Create all gates:
        var gx = [0,    0,    0,  150]
        var gy = [0, -300, -600, -900]

        var gateComponent = Qt.createComponent("PlanetBackground.qml");
        if (gateComponent.status == Component.Ready) {
            for (var i=0; i<0; ++i) {
                var gate = gateComponent.createObject(parent);
                gate.bgimage = "qrc:/space/img/moon.png";
                gate.universeX = universeX + gx[i];
                gate.universeY = universeY + gy[i];
                SharedScript.gateArray.push(gate);
                console.debug(gate.x, gate.y)
            }
        }
    }
}
