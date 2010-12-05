.pragma library

var gameTime = 0;
var clockTime;
var cameraX = 0;
var cameraY = 0;
var screenWidth = 0;
var screenHeight = 0;
var level = 5
var seed = 0;
var shipCollisionCenterX = 0;
var shipCollisionCenterY = 0;
var _shipCollisionRadius = 20;

var random = RandomNumberGenerator(1);
var gateArray = [];
var debrisArray = [];

function reset()
{
    gameTime = 0;
    clockTime = new Date();
    var seedKey = level;
    seed = 2345678901 + (seedKey * 0xFFFFFF) + (seedKey * 0xFFFF);
}

function eraseDebrisArray()
{
    // It is important to create arrays inside a .js file
    // to ensure normal javascript array behaviour:
    for (var i=0; i<debrisArray.length; ++i)
        debrisArray[i].destroy();
    debrisArray = [];
}

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

function nextRandomNumber(){
    var hi = seed / this.Q;
    var lo = seed % this.Q;
    var test = this.A * lo - this.R * hi;
    if (test > 0)
        seed = test;
    else
        seed = test + this.M;
    return (seed * this.oneOverM);
}

function RandomNumberGenerator(seed){
    this.A = 48271;
    this.M = 2147483647;
    this.Q = this.M / this.A;
    this.R = this.M % this.A;
    this.oneOverM = 1.0 / this.M;
    this.next = nextRandomNumber;
    return this;
}
