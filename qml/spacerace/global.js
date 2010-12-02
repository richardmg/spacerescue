.pragma library

var cameraX = 0;
var cameraY = 0;
var screenWidth = 0;
var screenHeight = 0;

var gateArray = [];
var debrisArray = [];

function updateScreenPositionFor(targetItem)
{
    // Calculate from universe position to screen position:
    var posX = cameraX * targetItem.universeZ;
    var posY = cameraY * targetItem.universeZ;
    targetItem.x = targetItem.universeX - posX + (screenWidth / 2);
    targetItem.y = targetItem.universeY - posY + (screenHeight / 2);
}
