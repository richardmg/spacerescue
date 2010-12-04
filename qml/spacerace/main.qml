import Qt 4.7
import "global.js" as SharedScript

Rectangle {
    width: 480
    height: 800
    onWidthChanged: SharedScript.screenWidth = width;
    onHeightChanged: SharedScript.screenHeight = height;

    Game {

    }
}
