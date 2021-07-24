PImage img, reimg;

color fullPow;

void setup() {
  size(556, 382);
  img = loadImage("lake_test.jpg");
  reimg = createImage(floor(img.width / 3), floor(img.height / 3), RGB);

  //Nested forloops that go by two pixels at a time and take those three
  //and get the weighted average of those pixels
  int x_gain = 0, y_gain = 0; // using this to keep track of position insde of the table array
  for (int x = 1; x < img.width - 1; x += 3) {
    for (int y = 1; y < img.height - 1; y += 3) {
      float pow_red = 0, pow_blue = 0, pow_green = 0;
      for (int x_check = -1; x_check < 2; x_check++) {
        for (int y_check = -1; y_check < 2; y_check++) {
          fullPow = img.get(x + x_check, y + y_check);
          pow_red += red(fullPow);
          pow_green += green(fullPow);
          pow_blue += blue(fullPow);
        }
      }
      reimg.set(x_gain, y_gain, color((pow_red / 9), (pow_green / 9), (pow_blue / 9)));
      y_gain++;
    }
    x_gain++;
    y_gain = 0;
  }
  
  image(reimg, 0, 0);
}
