var Bud, Leaf, anRange, animatedBranch, bRange, budList, budListDone, budListForDraw, c, canvasClean, cxt, drawBranch, drawLeaf, drawMisc, getToday, h0, lColor, leafList, leafListDone, leafListForDraw, length0, makeBranch, maxLeaf, maxLength, numOfBud, numOfLoop, rLeaf, random, reduceH, reduceL, rootX, rootY, w0, weight0;

c = document.getElementById("myCanvas");

cxt = c.getContext("2d");

w0 = cxt.canvas.width = window.innerWidth;

h0 = cxt.canvas.height = window.innerHeight;

random = function(m, n) {
  return Math.random() * (n - m) + m;
};

getToday = function() {
  var dateDiff, diffDays, firstDay, msPerDay, now;
  now = new Date();
  firstDay = new Date(now.getFullYear(), 0, 1);
  dateDiff = now - firstDay;
  msPerDay = 1000 * 60 * 60 * 24;
  diffDays = Math.ceil(dateDiff / msPerDay);
  return diffDays;
};

rootX = 0.4 * w0;

rootY = 1.25 * h0;

length0 = 0.5 * h0;

weight0 = w0 / 75;

anRange = Math.PI / 3;

bRange = Math.PI / 3;

reduceL = 0.6;

reduceH = 0.8;

rLeaf = w0 / 150;

numOfLoop = 5;

numOfBud = 7;

maxLength = 200;

maxLeaf = 50;

lColor = {
  H: 155,
  S: 75,
  LA: random(20, 70),
  LR: 10
};

lColor.H = getToday() * 360 / 365;

Bud = function(X, Y, X0, Y0, w, i) {
  this.X = X;
  this.Y = Y;
  this.X0 = X0;
  this.Y0 = Y0;
  this.w = w;
  return this.i = i;
};

Leaf = function(X, Y, r, i) {
  this.X = X;
  this.Y = Y;
  this.r = r;
  return this.i = i;
};

budList = [];

budListDone = [];

budListForDraw = [];

leafList = [];

leafListDone = [];

leafListForDraw = [];

makeBranch = function(x1, y1, i, l, w, a0, b0) {
  var j, k, m, n, o, r, ref, ref1, results, tmp, x2, x3, y2, y3;
  x2 = x1 - l * Math.sin(a0) * Math.sin(b0);
  y2 = y1 - l * Math.cos(a0) * Math.sin(b0);
  budList.push(new Bud(x2, y2, x1, y1, w, i));
  if (i > 0) {
    for (tmp = k = 0, ref = Math.ceil((numOfLoop - i + 1) ^ 2); 0 <= ref ? k <= ref : k >= ref; tmp = 0 <= ref ? ++k : --k) {
      m = random(-5, 5 + l * Math.sin(b0));
      n = random(0, w0 / 30 - 3 * i);
      y3 = y1 - (m * Math.cos(a0) + n * Math.sin(a0));
      x3 = x1 - (m * Math.sin(a0) + n * Math.cos(a0));
      r = rLeaf;
      leafList.push(new Leaf(x3, y3, r, i));
    }
  }
  if (i < numOfLoop) {
    results = [];
    for (j = o = 1, ref1 = numOfBud; 1 <= ref1 ? o <= ref1 : o >= ref1; j = 1 <= ref1 ? ++o : --o) {
      results.push(makeBranch(x2, y2, i + 1, l * random(reduceL, reduceH), w * random(reduceL - 0.2, reduceH - 0.2), random(-anRange, anRange) + a0, random(-anRange, anRange) + b0));
    }
    return results;
  }
};

makeBranch(rootX, rootY, 0, length0, weight0, 0, Math.PI / 2);

budList.sort(function(a, b) {
  return a.i - b.i;
});

canvasClean = function() {
  cxt.clearRect(0, 0, w0, h0);
  w0 = cxt.canvas.width = window.innerWidth;
  h0 = cxt.canvas.height = window.innerHeight;
};

drawBranch = function() {
  var bud, j, k, ref, results;
  results = [];
  for (j = k = 0, ref = budList.length; 0 <= ref ? k < ref : k > ref; j = 0 <= ref ? ++k : --k) {
    bud = budList.shift();
    budListDone.push(bud);
    if (budListForDraw.length === 0 || (budListForDraw[budListForDraw.length - 1].i === bud.i && budListForDraw.length < maxLength)) {
      results.push(budListForDraw.push(bud));
    } else {
      animatedBranch(budListForDraw, 0);
      budListForDraw = [];
      budListForDraw.push(bud);
      break;
    }
  }
  return results;
};

animatedBranch = function(budList, t) {
  var bud, k, len;
  for (k = 0, len = budList.length; k < len; k++) {
    bud = budList[k];
    cxt.lineWidth = bud.w;
    cxt.strokeStyle = "rgba(0,0,0," + (1 - bud.i / numOfLoop / 1.1) + ")";
    cxt.beginPath();
    cxt.moveTo(bud.X0 + (bud.X - bud.X0) * t, bud.Y0 + (bud.Y - bud.Y0) * t);
    cxt.lineTo(bud.X0 + (bud.X - bud.X0) * (t + 0.1), bud.Y0 + (bud.Y - bud.Y0) * (t + 0.1));
    cxt.closePath();
    cxt.stroke();
  }
  if (t < 1 - 0.2) {
    return requestAnimationFrame(function() {
      return animatedBranch(budList, t + 0.1);
    });
  } else {
    return drawBranch();
  }
};

drawLeaf = function() {
  var j, k, leaf, ref;
  for (j = k = 1, ref = maxLeaf; 1 <= ref ? k <= ref : k >= ref; j = 1 <= ref ? ++k : --k) {
    leaf = leafList.shift();
    leafListDone.push(leaf);
    cxt.beginPath();
    cxt.arc(leaf.X, leaf.Y, leaf.r, 0, 2 * Math.PI);
    cxt.closePath();
    cxt.fillStyle = ("hsla(" + lColor.H + ",") + (lColor.S + "%,") + ((random(lColor.LA - lColor.LR, lColor.LA + lColor.LR)) + "%,0.05) ");
    cxt.fill();
  }
  return requestAnimationFrame(drawLeaf);
};

drawMisc = function() {
  cxt.globalCompositeOperation = "destination-over";
  cxt.fillStyle = "#444444";
  cxt.fillRect(0, h0 - 18, w0, 30);
  cxt.globalCompositeOperation = "source-over";
  cxt.textBaseline = "bottom";
  cxt.font = "10px italic Serif";
  cxt.fillStyle = "#000000";
  cxt.textAlign = "right";
  return cxt.fillText("mailto:yeshuanghe#gmail", w0 - 10, h0);
};

setTimeout(function() {
  canvasClean();
  drawBranch();
  drawLeaf();
  // drawMisc();
}, 100);

// document.getElementById("fuzzy").addEventListener("click", function() {
//   var fuzzy;
//   canvasClean();
//   drawBranch();
//   drawLeaf(leafList, lColor, fuzzy = true);
//   return drawMisc();
// });

// document.getElementById("orange").addEventListener("click", function() {
//   canvasClean();
//   drawBranch();
//   return drawMisc();
// });

// document.getElementById("restore").addEventListener("click", function() {
//   canvasClean();
//   drawBranch();
//   drawLeaf(leafList, lColor);
//   return drawMisc();
// });
