void setup() {
  size(800, 800);
}

void draw() {
  background(0);
  stroke(0, 255, 100);
  pushMatrix();
  translate(width * .5, height * .5);

  float hr = hour();
  float mn = minute();
  float sc = second();

  for (int i = 0; i < 60; i++) {
    float angle = map(i, 0, 60, 0, 360);
    angle = radians(angle);
    float x1 = cos(angle) * 200;
    float y1 = sin(angle) * 200;
    float x2, y2;

    if (i % 5 == 0) {
      strokeWeight(2);
      x2 = cos(angle) * 260;
      y2 = sin(angle) * 260;
    } else {
      strokeWeight(1);
      x2 = cos(angle) * 320;
      y2 = sin(angle) * 320;
    }
    line(x1, y1, x2, y2);
  }

  strokeWeight(5);
  float hour = map(hr % 12, 0, 12, 0, 360);
  hour = radians(hour);
  line(0, 0, cos(hour) * 70, sin(hour) * 70);

  stroke(0, 255, 100);
  strokeWeight(3);
  float minute = map(mn, 0, 60, 0, 360);
  minute = radians(minute);
  line(0, 0, cos(minute) * 120, sin(minute) * 120);

  stroke(0, 255, 100);
  strokeWeight(1);
  float second = map(sc, 0, 60, 0, 360);
  second = radians(second);
  line(0, 0, cos(second) * 180, sin(second) * 180);

  fill(0, 255, 100);
  circle(0, 0, 5);
  popMatrix();
}
