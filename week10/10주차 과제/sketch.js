let colours = ['#257180', '#F2E5BF', '#FD8B51', '#CB6040'];
let gravity = [0, 0.1];
let friction = 0.99;
let cnt = 0;
let mousePos = [0, 0];

let confetties;

function setup() {
  createCanvas(800, 800);
  confetties = new Confetties();
}

function mousePressed() {
  cnt = 0;
  mousePos[0] = mouseX;
  mousePos[1] = mouseY;
}

function mouseReleased() {
  console.log('gen: ' + cnt);
  confetties.gen(mousePos[0], mousePos[1], cnt);
}

function keyPressed() {
  if (key === 'p' || key === 'P') {
    console.log('confetties: ' + confetties.getLength());
  }
}

function draw() {
  if (mouseIsPressed) {
    cnt++;
  }
  background(255);
  confetties.update(gravity, friction);
  confetties.display();
}

class Confetti {
  constructor(x, y, w, h, colour, force, angForce) {
    this.pos = [x, y];
    this.vel = [0, 0];
    this.size = [w, h];
    this.colour = colour;
    this.ang = random(TWO_PI);
    this.angVel = radians(angForce);
    this.init(x, y, w, h, colour, force, angForce);
  }

  init(x, y, w, h, colour, force, angForce) {
    let randomDir = random(TWO_PI);
    this.vel[0] = force * cos(randomDir);
    this.vel[1] = force * sin(randomDir);
  }

  update(force, friction) {
    for (let i = 0; i < 2; i++) {
      this.vel[i] += force[i];
      this.pos[i] += this.vel[i];
      this.vel[i] *= friction;
    }

    this.ang += this.angVel;
    this.angVel *= friction;
  }

  display() {
    push();
    rectMode(CENTER);
    translate(this.pos[0], this.pos[1]);
    rotate(this.ang);
    noStroke();
    fill(this.colour);
    rect(0, 0, this.size[0], this.size[1]);
    pop();
  }

  getDiagonal() {
    let sumSquare = pow(this.size[0] * 0.5, 2) + pow(this.size[1] * 0.5, 2);
    return sqrt(sumSquare);
  }

  isOutOfScreen() {
    return (
      this.pos[0] < -this.getDiagonal() ||
      this.pos[0] > width + this.getDiagonal() ||
      this.pos[1] < -this.getDiagonal() ||
      this.pos[1] > height + this.getDiagonal()
    );
  }
}

class Confetties {
  constructor() {
    this.confetties = [];
  }

  gen(x, y, n) {
    for (let i = 0; i < n; i++) {
      let randomW = random(4, 20);
      let randomH = random(4, 20);
      let randomForce = random(1, 10);
      let randomAngForce = random(-30, 30);
      let newConfetti = new Confetti(
        x,
        y,
        randomW,
        randomH,
        colours[int(random(colours.length))],
        randomForce,
        randomAngForce
      );
      this.confetties.push(newConfetti);
    }
  }

  update(force, friction) {
    for (let i = this.confetties.length - 1; i >= 0; i--) {
      let aConfetti = this.confetties[i];
      aConfetti.update(force, friction);
      if (aConfetti.isOutOfScreen()) {
        this.confetties.splice(i, 1);
      }
    }
  }

  display() {
    for (let i = 0; i < this.confetties.length; i++) {
      this.confetties[i].display();
    }
  }

  getLength() {
    return this.confetties.length;
  }
}
