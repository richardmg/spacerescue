import Qt 4.7
import SpaceDebris 1.0
import "global.js" as SharedScript

Rectangle {
    id: root
    color: "black"
    width: 10
    height: 10

    // Global variables:
    property bool introMode: true;
    property real cameraX: game.ship.universeX
    property real cameraY: game.ship.universeY
    property int gameTime: 0
    property int level: 3
    /////////////////////////////////////////////

    SpaceAudio {
        id: music
        source: "spacerace/audio/ugress.mp3"
        play: true
        onVolumeChanged: if (volume == 0) position = 0;
    }

    Game {
        id: game
        opacity: 0
    }

    Menu {
        id: menu
        anchors.centerIn: root
        opacity: 0
    }

    MovieIntro {
        id: intro
        anchors.centerIn: root
    }

    function newGame()
    {
        SharedScript.reset(root.level);
        root.gameTime = 0;
        music.play = false;
        music.position = 0;
        root.introMode = false;
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
        root.introMode = false;
        menu.rescueTimer.hours = game.rescueTimer.hours
        menu.rescueTimer.minutes = game.rescueTimer.minutes
        menu.rescueTimer.seconds = game.rescueTimer.seconds
        menu.rescueTimer.milliseconds = game.rescueTimer.milliseconds
    }

}
