float[][] xy;

PImage img;

void setup() {
  size(1024, 1564);
  img = loadImage("kiro_hot.png");
  image(img, 0, 0);
 
  for (int x_loc = 0; x_loc < img.width; x_loc++) {
    for (int y_loc = 0; y_loc < img.height; y_loc++) {
      //horizontal gradient
      float HxR = pow((red(img.get(x_loc-1, y_loc))-red(img.get(x_loc+1, y_loc))), 2);
      float HxG = pow((green(img.get(x_loc-1, y_loc))-green(img.get(x_loc+1, y_loc))), 2);
      float HxB = pow((blue(img.get(x_loc-1, y_loc))-blue(img.get(x_loc+1, y_loc))), 2);
      float Hx = (HxR + HxG + HxB);
      //vertical gradient
      float VxR = pow(red(img.get(x_loc, y_loc-1))-red(img.get(x_loc, y_loc+1)), 2);
      float VxG = pow(green(img.get(x_loc, y_loc-1))-green(img.get(x_loc, y_loc+1)), 2);
      float VxB = pow(blue(img.get(x_loc, y_loc-1))-blue(img.get(x_loc, y_loc+1)), 2);
      float Vx = (VxR + VxG + VxB);
     
      int end_final = round(map(Hx + Vx, 0, 10000, 0, 255));
      set(x_loc, y_loc, color(end_final));
    }
  }
}
