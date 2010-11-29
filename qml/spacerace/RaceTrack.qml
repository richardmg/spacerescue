import Qt 4.7

Rectangle {
    id: trackRoot
    property real centerX
    property real centerY

    width: 400
    height: 400
    color: "#ff0000"
    clip: true

    Image {
        x: trackRoot.centerX - (width / 2)
        y: trackRoot.centerY - (height / 2)
        source: "qrc:/space/img/trackmask.png"
    }
}
