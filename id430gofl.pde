/*
 * cs430gofl.pde
 * 
 *
 *
 *
 */

Game game;
Display display;

void setup() {
  //fullScreen();   // Android
  size(800, 600); // Decktop
  game = new Game(80, 60);
  display = new Display(10, game);
  game.editCell(10, 10, true);
  game.editCell(10, 20, true);
  game.editCell(30, 50, true);
  gesture = new KetaiGesture(this);
}

void draw() {
  display.draw();
}