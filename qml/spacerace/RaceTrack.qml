import Qt 4.7

Rectangle {
    id: trackRoot
    property real centerX
    property real centerY

    width: trackImage.width
    height: trackImage.height
    color: "#ff0000"
    clip: true

    Image {
        id: trackImage
        x: -trackRoot.centerX + (trackRoot.width / 2)
        y: trackRoot.centerY + (trackRoot.height / 2)
        source: "qrc:/space/img/trackmask.png"
    }
}
