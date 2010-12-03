.pragma library

var cameraX = 0;
var cameraY = 0;
var screenWidth = 0;
var screenHeight = 0;
var distanteToAstronaut = 100;//5000;

var shipCollisionCenterX = 0;
var shipCollisionCenterY = 0;
var _shipCollisionRadius = 20;

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

function collidesWithShip(targetItem, radius, shiftX, shiftY)
{
    var k1 = shipCollisionCenterX - (shiftX + targetItem.universeX + (targetItem.width / 2));
    var k2 = shipCollisionCenterY - (shiftY + targetItem.universeY + (targetItem.height / 2));
    if (Math.sqrt((k1 * k1) + (k2 * k2)) < (radius + _shipCollisionRadius))
        return true;
    return false;
}
