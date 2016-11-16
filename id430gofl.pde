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
  fullScreen();   // Android
  //size(800, 600); // Decktop
  game = new Game();
  display = new Display(30, game);
  gesture = new KetaiGesture(this);
}

void draw() {
  display.draw();
}