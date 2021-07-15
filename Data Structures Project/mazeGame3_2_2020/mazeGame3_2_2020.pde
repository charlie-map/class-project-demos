//Most likely not the best way to solve the maze (because of the if statements inside the class[coloring]) but it turned out fairly well.
import java.util.PriorityQueue;

PriorityQueue<Cell> pq = new PriorityQueue<Cell>();

Cell[][] the_cells;
Cell current, next;
int columns, rows;
int cell_size = 20, stroke_color = 255;
int x = 0, y = 0;
int counter, num_waller;

void setup() {
  stroke(stroke_color);
  frameRate(10);
  size(800, 600);
  strokeWeight(5);
  background(0);
  rectMode(CORNER);
  columns = round(width/cell_size);
  rows = round(height/cell_size);
  the_cells = new Cell[columns][rows];
  for (int x_loc=0; x_loc<columns; x_loc++) {
    for (int y_loc=0; y_loc<rows; y_loc++) {
      the_cells[x_loc][y_loc]=new Cell();
      the_cells[x_loc][y_loc].x = x_loc;
      the_cells[x_loc][y_loc].y = y_loc;
    }
  }
  mazeGen(x, y);
  for (int i = 0; i < 100; i++) {
    num_waller = round(random(0, 4));
    int num_x = round(random(1, columns-1)), num_y = round(random(1, rows-1));
    if (num_waller == 0) { //north side
      the_cells[num_x][num_y].hasNorthwall = false;
    }
    if (num_waller == 1) { //east side
      the_cells[num_x][num_y].hasEastwall = false;
    }
    if (num_waller == 2) { //west side
      the_cells[num_x][num_y].hasWestwall = false;
    }
    if (num_waller == 3) { //south side
      the_cells[num_x][num_y].hasSouthwall = false;
    }
  }
  pq.add(the_cells[x][y]);
  mazeSolve(x, y);
}

void draw() {
  for (int x_loc=0; x_loc<columns; x_loc++) {
    for (int y_loc=0; y_loc<rows; y_loc++) {
      the_cells[x_loc][y_loc].display(y_loc*cell_size, x_loc*cell_size);
    }
  }
}

void mazeGen(int x, int y) {
  the_cells[x][y].beenVisited = true;
  while ((x>0 && the_cells[x-1][y].beenVisited == false) || (y>0 && the_cells[x][y-1].beenVisited == false) ||
    (x<columns-1 && the_cells[x+1][y].beenVisited == false) || (y<rows-1 && the_cells[x][y+1].beenVisited == false)) {  //Everything else
    counter = round(random(0, 3));
    if (x>0 && the_cells[x-1][y].beenVisited == false && counter == 0) {
      the_cells[x][y].hasWestwall = false;
      the_cells[x-1][y].hasEastwall = false;
      mazeGen(x-1, y);
    }
    if (y>0 && the_cells[x][y-1].beenVisited == false && counter == 1) {
      the_cells[x][y].hasNorthwall = false;
      the_cells[x][y-1].hasSouthwall = false;
      mazeGen(x, y-1);
    }
    if (x<columns-1 && the_cells[x+1][y].beenVisited == false && counter == 2) {
      the_cells[x][y].hasEastwall = false;
      the_cells[x+1][y].hasWestwall = false;
      mazeGen(x+1, y);
    }
    if (y<rows-1 && the_cells[x][y+1].beenVisited == false && counter == 3) {
      the_cells[x][y].hasSouthwall = false;
      the_cells[x][y+1].hasNorthwall = false;
      mazeGen(x, y+1);
    }
  }
}

void mazeSolve(int start_posX, int start_posY) {
  current = the_cells[start_posX][start_posY];
  //to check if the walls are there. If not then run through, set the parent and then add them to the frontier
  while (the_cells[columns - 1][rows - 1].reached == false) {
    current.reached = true;
    if (current.hasNorthwall == false && the_cells[current.x][current.y - 1].reached == false) {
      next = the_cells[current.x][current.y - 1];
      next.parent = the_cells[current.x][current.y];
      next.priority = (h(current.x, current.y - 1) + next.g(current.x, current.y - 1));
      pq.add(next);
    }
    if (current.hasEastwall == false && the_cells[current.x + 1][current.y].reached == false) {
      next = the_cells[current.x + 1][current.y];
      next.parent = the_cells[current.x][current.y];
      next.priority = (h(current.x + 1, current.y) + next.g(current.x + 1, current.y));
      pq.add(next);
    }
    if (current.hasSouthwall == false && the_cells[current.x][current.y + 1].reached == false) {
      next = the_cells[current.x][current.y + 1];
      next.parent = the_cells[current.x][current.y];
      next.priority = (h(current.x, current.y + 1) + next.g(current.x, current.y + 1));
      pq.add(next);
    }
    if (current.hasWestwall == false && the_cells[current.x - 1][current.y].reached == false) {
      next = the_cells[current.x - 1][current.y];
      next.parent = the_cells[current.x][current.y]; // s a weebcharlie i
      next.priority = (h(current.x - 1, current.y) + next.g(current.x - 1, current.y));
      pq.add(next);
    }
    current = pq.poll();
  }
  if (the_cells[columns - 1][rows - 1].reached == true) {
    current = the_cells[columns - 1][rows - 1];
    while (the_cells[0][0].correct_path == false) {
      current.reached = false;
      current.correct_path = true;
      current = current.parent;
    }
  }
}

int h(int x, int y) {
  x = columns - x;
  y = rows - y;
  return(x+y);
}
