import android.view.MotionEvent;
import ketai.ui.*;

Game game;
Display display;
KetaiGesture gesture;

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

/*
 *  Gesture Control -->
 */

boolean surfaceTouchEvent(MotionEvent event) {
  super.surfaceTouchEvent(event);
  int action = event.getAction();
  switch(action & MotionEvent.ACTION_MASK)
  {
      case MotionEvent.ACTION_POINTER_DOWN:
          if(event.getPointerCount() >= 5) {
          	if(game.getGameMode() == GameMode.PLAY) {
          		game.pause();
          	} else if(game.getGameMode() == GameMode.PAUSE) {
          		game.resume();
          	} else {
	            game.start();
	        }
          }
          break;
  }
  return gesture.surfaceTouchEvent(event);
}

void onTap(float x, float y) {
}

void onPinch(float x, float y, float r) {
  if (r > 10) display.increaseCellSize();
  else if (r < -10) display.decreaseCellSize();
  print(x, y, r);
}

void mousePressed() {
  display.dragStartEvent();
} 

void mouseDragged() {
  display.changeCellEvent(mouseX, mouseY);
}