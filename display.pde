final int MAX_CELL_SIZE = 100;
final int MIN_CELL_SIZE = 30;

class Display {

  private ArrayList<int[]> visited;
  private int cellSize;
  private Game game;


  public Display (int cellSize, Game game) {
    this.game=game;
    this.cellSize=cellSize;
    game.changeBoardSize(width / cellSize, height / cellSize);
    visited = new ArrayList<int[]>();
  }

  //deprecated
  //public void setCellSize(int value) {
  //  cellSize=value;
  //}
  
  public void increaseCellSize() {
    cellSize +=5;
    if(cellSize > MAX_CELL_SIZE) cellSize = MAX_CELL_SIZE;
    game.changeBoardSize(width / cellSize, height / cellSize);
  }
  
  public void decreaseCellSize() {
    cellSize -=5;
    if(cellSize < MIN_CELL_SIZE) cellSize = MIN_CELL_SIZE;
    game.changeBoardSize(width / cellSize, height / cellSize);
  }
  
  public int[] convertPositionToCell(int x, int y){
    int[] p =  new int[]{(x-(width%cellSize)/2)/cellSize, (y-(height%cellSize)/2)/cellSize};
    if(p[0] < 0 || p[1] < 0 || p[0] >= game.getWidth() || p[1] >=game.getHeight()) return new int[] {-1, -1};
    return p;
  }
  
  public void dragStartEvent() {
    visited = new ArrayList<int[]>();
  }
  
  public void changeCellEvent(int x, int y) {
    int[] cellPosition = convertPositionToCell(x, y);
    if(cellPosition[0] == -1) return;
    boolean flag = false;
    for(int[] p: visited) {
      if(p[0] == cellPosition[0] && p[1] == cellPosition[1]) flag = true; 
    }
    visited.add(cellPosition);
    if(!flag)
      game.editCell(cellPosition[0], cellPosition[1], !game.getBoard()[cellPosition[0]][cellPosition[1]]);
  }
  
  public void draw() {
    game.refresh();
    boolean[][] board = game.getBoard();
    int offsetX = (width%cellSize)/2;
    int offsetY = (height%cellSize)/2;

    int boardWidth = game.getWidth();
    int boardHeight = game.getHeight();
    
    int savedCellSize = cellSize;

    background(0);
    stroke(255);
    strokeWeight(1);
    rectMode(CORNER);
    for (int i=0; i<boardWidth; i++) {
      for (int j=0; j<boardHeight; j++) {
        if (board[i][j])fill(255, 255, 0);
        else fill(0);
        rect(offsetX+savedCellSize*i, offsetY+savedCellSize*j, savedCellSize, savedCellSize);
      }
    }
    textSize(40);
    fill(255);
    if(game.getGameMode() == GameMode.PLAY){
      text("Day " + game.getDay(), 40, height - 80);
      text(game.getCellCounter() + " Alive Cells" , width-250, height - 80);
    }
    else if(game.getGameMode() == GameMode.PAUSE) {
      text("Day " + game.getDay() + " - Paused", 40, height - 80);
      text(game.getCellCounter() + " Alive Cells" , width-250, height - 80);
    }
    else
      text("Edit Mode", 40, height - 80);
  }
  
}