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
    }

    Menu {
        id: menu
        anchors.centerIn: root
        root: root
        opacity: 1
    }

//    MovieIntro {
//        id: intro
//        anchors.centerIn: root
//        root: root
//    }

    function newGame()
    {
        state = "gameState";
        game.newGame();
        menu.opacity = 0;
        game.opacity = 1;
        game.focus = true;
    }

    function endGame()
    {
        state = "menuState";
        game.endGame();
        menu.opacity = 1;
        menu.rescueTimer.hours = game.rescueTimer.hours
        menu.rescueTimer.minutes = game.rescueTimer.minutes
        menu.rescueTimer.seconds = game.rescueTimer.seconds
        menu.rescueTimer.milliseconds = game.rescueTimer.milliseconds
        //        intro.opacity = 0;
    }

}
