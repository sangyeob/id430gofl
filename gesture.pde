import android.view.MotionEvent;
import ketai.ui.*;

KetaiGesture gesture;

public boolean surfaceTouchEvent(MotionEvent event) {
  super.surfaceTouchEvent(event);
  return gesture.surfaceTouchEvent(event);
}

void onTap(float x, float y) {
}

void onPinch(float x, float y, float r) {
  if (r > 10) display.increaseCellSize();
  else if (r < -10) display.decreaseCellSize();
  print(x, y, r);
}

Boolean Start() {
  int a=0;
  if (MotionEvent.ACTION_POINTER_DOWN) {
    a++;
    println ("d");
  }
  else if (MotionEvent.ACTION_POINTER_UP) {
    a--;
    println ("u");
  }
  if (a==5) return true;
  return false;
}


void mousePressed() {
  display.dragStartEvent();
} 

void mouseDragged() {
  display.changeCellEvent(mouseX, mouseY);
}