import android.view.MotionEvent;
import ketai.ui.*;
import ketai.sensors.*;

Game game;
Display display;
KetaiGesture gesture;
KetaiSensor sensor;
float avg=0;
float [] accelero = new float[10];
int i;

void setup() {
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

void onAccelerometerEvent(float x, float y, float z, long time, int accuracy) {
  if((x+y+z)/time>Average()){
    for(int i=0;i<=9;i++) accelero[i]=0;
    i=0;
    game.reset();
  }
  else{
    accelero[i]=(x+y+z)/time;
    i++;
    if(i>9) i=0;
  }
}

float Average(){
  float sum=0;
  for(int j=0; j<10; j++) sum+=accelero[j];
  return sum/10;
}