.pragma library

var clockTime;
var seed = 10;

var random = RandomNumberGenerator(1);
var debrisArray = [];

function eraseDebrisArray()
{
    // It is important to create arrays inside a .js file
    // to ensure normal javascript array behaviour:
    for (var i=0; i<debrisArray.length; ++i)
        debrisArray[i].destroy();
    debrisArray = [];
}

// My own random number generator that is deterministic (takes a seed)
function reset(seedKey)
{
    clockTime = new Date();
    seed = 2345678901 + (seedKey * 0xFFFFFF) + (seedKey * 0xFFFF);
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
///////////////////////////////////////////////////////////////////////
