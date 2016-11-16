final int MAX_CELL_SIZE = 30;
final int MIN_CELL_SIZE = 10;

class Display {

  private int cellSize;
  private Game game;


  public Display (int cellSize, Game game) {
    this.game=game;
    this.cellSize=cellSize;
  }

  //deprecated
  //public void setCellSize(int value) {
  //  cellSize=value;
  //}
  
  public void increaseCellSize() {
    cellSize ++;
    if(cellSize > MAX_CELL_SIZE) cellSize = MAX_CELL_SIZE;
  }
  
  public void decreaseCellSize() {
    cellSize --;
    if(cellSize < MIN_CELL_SIZE) cellSize = MIN_CELL_SIZE;
  }
  public void draw() {
    boolean[][] board = game.getBoard();
    int offsetX = (width%cellSize)/2;
    int offsetY = (height%cellSize)/2;

    int boardWidth = game.getWidth();
    int boardHeight = game.getHeight();

    background(0);
    stroke(255);
    strokeWeight(1);
    rectMode(CORNER);
    for (int i=0; i<boardWidth; i++) {
      for (int j=0; j<boardHeight; j++) {
        if (board[i][j])fill(0, 0, 255);
        else fill(0);
        rect(offsetX+cellSize*i, offsetY+cellSize*j, cellSize, cellSize);
      }
    }
  }
}