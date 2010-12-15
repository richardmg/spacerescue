import Qt 4.7
import SpaceDebris 1.0
import "global.js" as SharedScript

Rectangle {
    id: root
    width: 10
    height: 10
    onWidthChanged: SharedScript.screenWidth = width;
    onHeightChanged: SharedScript.screenHeight = height;
    color: "black"

    SpaceAudio {
        id: music
        source: "spacerace/audio/ugress.mp3"
        play: true
        onVolumeChanged: if (volume == 0) position = 0;
    }

    Game {
        id: game
        root: root
        opacity: 0
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
        music.play = false;
        music.position = 0;
        SharedScript.introMode = false;
        intro.enabled = false
        game.newGame();
        menu.opacity = 0;
        intro.opacity = 0;
        game.opacity = 1;
        game.focus = true;
    }

    function endGame()
    {
        music.play = true;
        game.endGame();
        menu.opacity = 1;
        intro.opacity = 0;
        SharedScript.introMode = false;
        menu.rescueTimer.hours = game.rescueTimer.hours
        menu.rescueTimer.minutes = game.rescueTimer.minutes
        menu.rescueTimer.seconds = game.rescueTimer.seconds
        menu.rescueTimer.milliseconds = game.rescueTimer.milliseconds
    }

}
