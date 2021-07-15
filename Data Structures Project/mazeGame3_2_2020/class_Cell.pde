class Cell implements Comparable<Cell> {
  boolean hasNorthwall = true;
  boolean hasEastwall = true;
  boolean hasSouthwall = true;
  boolean hasWestwall = true;
  boolean beenVisited = false;
  boolean reached = false, correct_path = false;
  int rectSize = cell_size - 2, priority, cell_gRating;
  int x, y;
  Cell parent;

  Cell() {
  }

  int g(int x, int y) {
    cell_gRating = 0;
    Cell current;
    current = the_cells[x][y];
    if (the_cells[x][y].parent == null) {
      return(0);
    }
    while (current.parent != null) {
      current = current.parent;
      cell_gRating += 1;
    }
    return(cell_gRating);
  }

  void display(float y, float x) {
    if (correct_path == true) {
      noStroke();
      fill(50, 50, 250);
      rect(x+1, y+1, rectSize, rectSize);
      stroke(stroke_color);
    }
    if (priority > 0 && correct_path == false) {
      noStroke();
      fill(250, 50, 50);
      rect(x+1, y+1, rectSize, rectSize);
      stroke(stroke_color);
    }
    if (reached == true) {
      noStroke();
      fill(50, 250, 100);
      rect(x+1, y+1, rectSize, rectSize);
      stroke(stroke_color);
    }
    if (hasNorthwall == true) {
      line(x, y, x+cell_size, y);
    }
    if (hasEastwall == true) {
      line(x+cell_size, y, x+cell_size, y+cell_size);
    }
    if (hasSouthwall == true) {
      line(x+cell_size, y+cell_size, x, y+cell_size);
    }
    if (hasWestwall == true) {
      line(x, y+cell_size, x, y);
    }
  }

  int compareTo(Cell ce) {
    if (priority == ce.priority) {
      return(0);
    }
    if (priority > ce.priority) {
      return(1);
    } else {
      return(-1);
    }
  }

  String toString() {
    return "X:" + x + " Y: " + y;
  }
}
