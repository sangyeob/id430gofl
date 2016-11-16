import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class id430gofl extends PApplet {

/*
 * cs430gofl.pde
 * 
 *
 *
 *
 */

public void setup() {
	//fullScreen();   // Android
	 // Decktop
}

public void draw() {
	background(0);
}
class Display {
	public Display () {
		
	}
}
class Game {
	private int board_width;
	private int board_height;
	private boolean[][] board;

	public Game (int w, int h) {
		board = new boolean[w][h];
		board_width = w;
		board_height = h;
	}

	public void editCell(int x, int y, boolean value) {
		board[x][y] = value;
	}

	public boolean[][] getBoard() {
		return board;
	}

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
		boolean[][] new_board = new boolean[board_width][board_height];
		int i, j;
		for(i = 0; i < board_width; i ++)
			for(j = 0; j < board_height; j ++)
				new_board[i][j] = getDestiny(i, j);
		board = new_board;	
	}
}
class Gesture {
	public Gesture () {
		
	}
}
  public void settings() { 	size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "id430gofl" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
