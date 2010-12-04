import Qt 4.7
import "global.js" as SharedScript

Rectangle {
    id: root
    width: 480
    height: 800
    onWidthChanged: SharedScript.screenWidth = width;
    onHeightChanged: SharedScript.screenHeight = height;
    focus: true

    Game {
        id: game
        root: root
    }

    Menu {
        id: menu
        anchors.centerIn: root
        visible: true
        root: root
    }

    function newGame()
    {
        menu.opacity = 0;
        game.newGame();
    }

    function endGame()
    {
        menu.opacity = 1;
        game.endGame();
    }

}
