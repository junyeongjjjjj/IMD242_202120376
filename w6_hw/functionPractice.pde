int randomSeed = int(random(10000));

void setup() {
  size(800, 800);
}

void mousePressed() {
  randomSeed = int(random(10000));
}

void draw() {
  randomSeed(randomSeed);
  drawBackground();
  for (int n = 1; n < 6; n++) {
    float scaleFactor = random(.3, .6);
    drawHouse(random(0.1 * width, 0.9 * width), height * 0.8 - 350 * scaleFactor, scaleFactor);
  }

  float centerX = width * 0.5;
  float centerY = height * 0.8 - 350 * 0.8;
  float centerScale = 0.8;

  drawHouse(centerX, centerY, centerScale);
}

void drawBackground() {
  noStroke();
  fill(69, 128, 201);
  rect(0, 0, width, height * 0.8);
  fill(227, 233, 193);
  rect(0, height * 0.8, width, height * 0.2);

  beginShape();
  fill(56, 64, 107);
  vertex(350, 660);
  vertex(370, 645);
  vertex(430, 645);
  vertex(450, 660);
  endShape(CLOSE);

  beginShape();
  vertex(300, 700);
  vertex(335, 675);
  vertex(465, 675);
  vertex(500, 700);
  endShape(CLOSE);

  beginShape();
  vertex(200, 780);
  vertex(270, 730);
  vertex(530, 730);
  vertex(600, 780);
  endShape(CLOSE);
}

void drawHouse(float x, float y, float scaleFactor) {
  pushStyle();
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);

  float houseHue = random(0, 360);
  float eyeHue = random(180, 240);
  colorMode(HSB, 360, 180, 80);

  fill(houseHue, 60, 90);
  rect(20, 110, 80, 120);

  fill(houseHue, 60, 90);
  rect(-100, 110, 80, 120);

  fill(houseHue, 80, 70);
  beginShape();
  vertex(-100, 350);
  vertex(-60, 0);
  vertex(60, 0);
  vertex(100, 350);
  endShape(CLOSE);

  fill(houseHue, 60, 85);
  float extraTrapezoidScale = random(0.85, 1.15);
  beginShape();
  vertex(-30 * extraTrapezoidScale, 225 * extraTrapezoidScale);
  vertex(-10 * extraTrapezoidScale, 105 * extraTrapezoidScale);
  vertex(10 * extraTrapezoidScale, 105 * extraTrapezoidScale);
  vertex(30 * extraTrapezoidScale, 225 * extraTrapezoidScale);
  endShape(CLOSE);

  fill(houseHue, 120, 120);
  rect(-65, 85, 130, 20);

  float eyeScale = random(0.85, 1.15);
  fill(eyeHue, 40, 100);
  ellipse(-40, 130, 50 * eyeScale, 50 * eyeScale);
  ellipse(40, 130, 50 * eyeScale, 50 * eyeScale);

  fill(eyeHue, 60, 50);
  ellipse(-40, 130, 27 * eyeScale, 27 * eyeScale);
  ellipse(40, 130, 27 * eyeScale, 27 * eyeScale);

  fill(40, 104, 40);
  rect(-30, 275, 70, 75);

  fill(40, 104, 40);
  arc(5, 285, 70, 80, PI, TWO_PI);

  fill(40, 104, 59);
  rect(-33, 275, 65, 75);

  fill(40, 104, 59);
  arc(0, 285, 65, 75, PI, TWO_PI);

  fill(40, 80, 80);
  ellipse(20, 300, 10, 10);

  popMatrix();
  popStyle();
}
