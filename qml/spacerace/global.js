.pragma library

var gameTime = 0;
var clockTime;
var cameraX = 0;
var cameraY = 0;
var screenWidth = 0;
var screenHeight = 0;
var distancteToAstronaut = 400;

var shipCollisionCenterX = 0;
var shipCollisionCenterY = 0;
var _shipCollisionRadius = 20;

var random = RandomNumberGenerator(1);
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

function nextRandomNumber(){
    var hi = this.seed / this.Q;
    var lo = this.seed % this.Q;
    var test = this.A * lo - this.R * hi;
    if(test > 0){
        this.seed = test;
    } else {
        this.seed = test + this.M;
    }
    return (this.seed * this.oneOverM);
}

function RandomNumberGenerator(seed){
    this.seed = 2345678901 + (seed * 0xFFFFFF) + (seed * 0xFFFF);
    this.A = 48271;
    this.M = 2147483647;
    this.Q = this.M / this.A;
    this.R = this.M % this.A;
    this.oneOverM = 1.0 / this.M;
    this.next = nextRandomNumber;
    return this;
}
