import android.view.MotionEvent;
import ketai.ui.*;
import ketai.sensors.*;

Game game;
Display display;
KetaiGesture gesture;
KetaiSensor sensor;
int i;

void setup() {
  lastTime = -1;
  lastAcc = new PVector(0, 0, 0);
  fullScreen();   // Android
  //size(800, 600); // Decktop
  game = new Game();
  display = new Display(30, game);
  gesture = new KetaiGesture(this);
  sensor = new KetaiSensor(this);
  sensor.start();
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


long lastTime;
PVector lastAcc;
void onAccelerometerEvent(float x, float y, float z, long time, int accuracy) {
  if(lastTime == -1) {
    lastTime = millis();
    lastAcc = new PVector(x, y, z);
    return;
  }
  if(millis() - lastTime > 100) {
    if((abs(x - lastAcc.x) + abs(y - lastAcc.y) + abs(z - lastAcc.z)) * 1000 / (millis() - lastTime) > 300) {
      game.reset();
    }
    lastAcc = new PVector(x, y, z);
    lastTime = millis();
  }
}