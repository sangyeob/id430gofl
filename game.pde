enum GameMode { EDIT, PLAY }

class Game {
	private int day;
	private int board_width;
	private int board_height;
	private GameMode gameMode;
	private boolean[][] board;

	public Game () {
		//board = new boolean[w][h];
		board_width = 0;
		board_height = 0;
		day = 1;
    gameMode = GameMode.EDIT;
	}

	public void resetDay() { day = 1; }
	public int getDay() { return day; }

	public void editCell(int x, int y, boolean value) {
		board[x][y] = value;
	}

	public void changeBoardSize(int w, int h) { 
		board = new boolean[w][h];
		board_width = w;
		board_height = h;
    gameMode = GameMode.EDIT;
	}
	public boolean[][] getBoard() { return board; }
  
  public int getWidth() { return board_width; }
  public int getHeight() { return board_height; }

	private boolean getDestiny(int x, int y)  {
		int[][] dirs = new int[][] {
			{-1, -1}, {-1, 0}, {-1, 1},
			{0, -1}, {0, 1},
			{1, -1}, {1, 0}, {1, 1}
		};
		int cnt = 0;
		for(int i = 0; i < 8; i ++) {
			if(x + dirs[i][0] < 0 || x + dirs[i][0] >= board_width ||
				y + dirs[i][1] < 0 || y + dirs[i][1] >= board_height) continue;
			if(board[x + dirs[i][0]][y + dirs[i][1]]) cnt ++;
		}

		if(board[x][y] && cnt < 2) return false;
		if(board[x][y] && cnt > 3) return false;
		if(board[x][y]) return true;
		if(cnt == 3) return true;
		return false;
	}

	public void nextDay() {
    if(gameMode != GameMode.PLAY) return;
		boolean[][] new_board = new boolean[board_width][board_height];
		int i, j;
		for(i = 0; i < board_width; i ++)
			for(j = 0; j < board_height; j ++)
				new_board[i][j] = getDestiny(i, j);
		board = new_board;	
		day ++;
	}
}