class Point {
  int x, y;
  float R, G, B;
  int centroidIndex = 3;

  Point(int i, int j) {
    x = i;
    y = j;
    R = red(img.get(x, y));
    G = green(img.get(x, y));
    B = blue(img.get(x, y));
  }
  //REGULAR points:
  void pointFill() {
      set(x, y, color(centroids[centroidIndex].R, centroids[centroidIndex].G, centroids[centroidIndex].B));
  }
  //IF isCent is returned true then change the point to a triangle
  void trueCent() {
    fill(255);
    triangle(x, y, x + 10, y, x + 5, y + 10);
  }

  //FIND the centroid nearest to itself
  void foundCentor() {
    int minVal = 0;
    //TO change to color: How? Distance doesn't work for a single value
    minVal = min(round(dist(R, G, B, centroids[0].R, centroids[0].G, centroids[0].B)), 
      round(dist(R, G, B, centroids[1].R, centroids[1].G, centroids[1].B)), 
      round(dist(R, G, B, centroids[2].R, centroids[2].G, centroids[2].B)));
    //THIS may repeat a number but how can you actually set those
    //coordinates to line up with an actual centroid? Big if.
    if (minVal == round(dist(R, G, B, centroids[0].R, centroids[0].G, centroids[0].B))) {
      centroidIndex = 0;
    }
    if (minVal == round(dist(R, G, B, centroids[1].R, centroids[1].G, centroids[1].B))) {
      centroidIndex = 1;
    }
    if (minVal == round(dist(R, G, B, centroids[2].R, centroids[2].G, centroids[2].B))) {
      centroidIndex = 2;
    }
  }
}
