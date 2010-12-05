import Qt 4.7
import "global.js" as SharedScript

Rectangle {
    id: root
    width: 480
    height: 800
    onWidthChanged: SharedScript.screenWidth = width;
    onHeightChanged: SharedScript.screenHeight = height;
    color: "black"

    Game {
        id: game
        root: root
        opacity: 0
        Component.onCompleted: game.newGame()
    }

    Menu {
        id: menu
        anchors.centerIn: root
        root: root
        opacity: 0
    }

    MovieIntro {
        id: intro
        anchors.centerIn: root
        root: root
    }

    function newGame()
    {
        state = "gameState";
        game.newGame();
        menu.opacity = 0;
        game.opacity = 1
    }

    function endGame()
    {
        state = "menuState";
        game.endGame();
        intro.opacity = 0;
        menu.opacity = 1;
    }

}
