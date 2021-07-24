int col = 255;

void setup() {
  background(255);
  size(500, 500);
  rectMode(CENTER);
  translate(255, 400);
  displayTree(100, col);
}

void displayTree(float len, int colo) {
  fill(0, colo, 100);
  rect(0, 0, len, len);
  if (len > 10) {
    pushMatrix(); //right side
    translate(len/2, -len);
    rotate(PI/4);
    displayTree(len * 0.67, colo - 20);
    popMatrix();

    pushMatrix(); //left side
    translate(-len/2, -len);
    rotate(-PI/4);
    displayTree(len * 0.67, colo - 20);
    popMatrix();
  }
}
