Point[][] points;
Point[] centroids;
PImage img;

void setup() {
  img = loadImage("1060750.jpg");
  frameRate(1);
  noStroke();
  background(255);
  size(800, 600);
  img.resize(800, 600);
  image(img, 0, 0);
  int columns = width, rows = height;
  points = new Point[width][height];
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      points[i][j] = new Point(i, j);
    }
  }

  centroids = new Point[3];
  //CREATE 3 new points that are the centroids
  for (int numCent = 0; numCent < 3; numCent++) {
    centroids[numCent] = new Point(round(random(0, width)), round(random(0, height)));
    //SET these characters to have either 0, 1, or 2
    //then when running through later you can set the different ones
    centroids[numCent].centroidIndex = numCent;
  }
}

void draw() {
  clear();
  image(img, 0, 0);
  //CHECK to see which points were chosen and call a function
  //to make them into a different looking image.
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
    points[i][j].foundCentor();
    points[i][j].pointFill();
    }
  }
  for (int i = 0; i < centroids.length; i++) {
    centroids[i].trueCent();
  }

  //MEAN-FINDING:
  float currRAR, currRAG, currRAB;
  int foundPoints;
  for (int run3 = 0; run3 < 3; run3++) {
    currRAG = 1;
    currRAB = 1;
    currRAR = 1;
    foundPoints = 0;
    for (int pointRunH = 0; pointRunH < height; pointRunH++) {
      for (int pointRunW = 0; pointRunW < width; pointRunW++) {
        if (points[pointRunW][pointRunH].centroidIndex == run3) {
          //TWO different averages for both x and y(3 averages for color)
          currRAR = (currRAR * foundPoints + points[pointRunW][pointRunH].R)/(foundPoints + 1);
          currRAG = (currRAG * foundPoints + points[pointRunW][pointRunH].G)/(foundPoints + 1);
          currRAB = (currRAB * foundPoints + points[pointRunW][pointRunH].B)/(foundPoints + 1);
          foundPoints += 1;
        }
      }
    }
    centroids[run3].R = currRAR;
    centroids[run3].G = currRAG;
    centroids[run3].B = currRAB;
  }
}
