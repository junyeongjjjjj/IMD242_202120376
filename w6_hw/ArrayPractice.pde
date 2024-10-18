int[] fruitAmts = new int[6];
String[] fruitNames = {"Mango", "Strawberry", "Kiwi", "Plum", "Peach", "Orange"};
int maxAmt = 0;
int totalAmt = 0;
float averageAmt = 0;

float graphHeight = 40;
float graphBegin = 180;
float graphGap = 80;
float graphShift = 350;

void setup() {
  size(1260, 720);

  for (int n = 0; n < fruitAmts.length; n++) {
    fruitAmts[n] = int(random(20, 300));
    totalAmt += fruitAmts[n];
    if (fruitAmts[n] > fruitAmts[maxAmt]) {
      maxAmt = n;
    }
  }
  averageAmt = totalAmt / float(fruitAmts.length);
}

void draw () {
  background(244, 244, 244);
  strokeWeight(graphHeight);
  strokeCap(SQUARE);
  textAlign(CENTER);
  textSize(30);
  fill(0);

  text("Total: " + totalAmt + "   |   Average: " + nf(averageAmt, 1, 2), width / 2, 50);

  for (int n = 0; n < fruitAmts.length; n++) {
    float y = graphBegin + n * graphGap;
    if (n == maxAmt) {
      stroke(238, 56, 135);
    } else {
      stroke(192, 192, 192);
    }

    line(graphShift, y, graphShift + map(fruitAmts[n], 0, 300, 0, width * .5), y);
    textSize(24);
    fill(133, 133, 133);
    text(fruitNames[n], graphShift - 80, y + 8);
    textSize(22);
    fill(192, 192, 192);
    text(fruitAmts[n], graphShift + map(fruitAmts[n], 0, 300, 0, width * 0.5) + 25, y + 8);
  }
}
