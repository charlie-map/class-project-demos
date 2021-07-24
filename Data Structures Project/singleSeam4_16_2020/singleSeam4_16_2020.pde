//Working Seam Carver: Partner Alex
//Repl did not work for this for some reason so I
//hope it doesn't just work on mine

PImage img;
float minVal, minLeft, minRight, r_time = 0;

void setup() {
  size(626, 352);
  img = loadImage("pointy_guy.jpg");
  image(img, 0, 0);
  // CALCULATE GRADIENT ENERGY

  // Create table to store energy values for each pixel
}

void draw() {
  int[][] table = new int[img.width][img.height];  
  int[][] parent = new int[img.width][img.height];

  if (r_time < 550) {
    for (int x = 0; x < img.width; x++) {
      for (int y = 0; y < img.height; y++) {
        float Rx, Gx, Bx, Ry, Gy, By;
        Rx = red(get(x-1, y)) - red(get(x+1, y));
        Gx = green(get(x-1, y)) - green(get(x+1, y));
        Bx = blue(get(x-1, y)) - blue(get(x+1, y));
        Ry = red(get(x, y-1)) - red(get(x, y+1));
        Gy = green(get(x, y-1)) - green(get(x, y+1));
        By = blue(get(x, y-1)) - blue(get(x, y+1));

        int energy = round(Rx * Rx + Ry * Ry + Gx * Gx + Gy * Gy + Bx * Bx + By * By);
        table[x][y] = energy;
      }
    }


    // Fill DP table

    // Loop over y, then x to go row by row
    for (int y = 1; y < img.height; y++) {
      for (int x = 0; x < img.width - r_time; x++) {
        minLeft = 10000000;
        minRight = 10000000;
        // Check each pixel's 2-3 parents, 
        if (x - 1 >= 0) { // ok to move diagonal left
          minLeft = table[x-1][y-1];
        }
        if (x + 1 < img.width - r_time - 1) { // ok to move diagonal right
          minRight = table[x+1][y-1];
        }
        // Take the minimum of the 2-3 parents, 
        minVal = min(table[x][y-1], minLeft, minRight);
        // Add that to the pixel's current energy value
        table[x][y] += minVal;

        // Setting parent based on lowest value
        if (table[x][y-1] < minLeft) {
          if (table[x][y-1] < minRight) {
            parent[x][y] = 1;
          }
          parent[x][y] = 2;
        } else {
          if (minLeft < minRight) {
            parent[x][y] = 0;
          } else {
            parent[x][y] = 2;
          }
        }
      }
    }

    // Backtrack to color single seam
    // 1: Start at the bottom row & find the x position lowest energy endpoint
    int curr = 0;
    // Loop over all the x values in the bottom row; remember the x value of 
    //where you find the lowest energy
    for (int x = 0; x < img.width - r_time; x++) {
      if (table[x][img.height - 1] < table[curr][img.height - 1]) {
        curr = x;
      }
    }

    for (int y_loc = img.height - 1; y_loc > -1; y_loc--) {
      for (int cur_pos = curr; cur_pos < img.width - r_time; cur_pos++) {
        //set(cur_pos, y_loc, color(255, 0, 0));
        set(cur_pos, y_loc, get(cur_pos + 1, y_loc));
        if (cur_pos == img.width - r_time - 1) {
          set(cur_pos, y_loc, color(0, 0, 0));
        }
      }
      if (parent[curr][y_loc] == 0) {
        curr -= 1;
      }
      if (parent[curr][y_loc] == 2) {
        curr += 1;
      }
    }
    r_time += 1;
  }
}
