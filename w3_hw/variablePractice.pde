float[] x = new float[20];
float[] y = new float[20];

void setup() {
  size(800, 800);
  background(0);

  for (int i = 0; i < 20; i++) {
    x[i] = random(width);
    y[i] = random(height);
  }
}

void draw() {
  stroke(random(0), random(255), random(255), 80);

  for (int i = 0; i < 20; i++) {
    float newX = x[i] + random(-20, 20);
    float newY = y[i] + random(-20, 20);
    line(x[i], y[i], newX, newY);
    x[i] = newX;
    y[i] = newY;
  }
}
