import android.view.MotionEvent;
import ketai.ui.*;

KetaiGesture gesture;

boolean surfaceTouchEvent(MotionEvent event) {
  super.surfaceTouchEvent(event);
  int action = event.getAction();
  switch(action & MotionEvent.ACTION_MASK)
  {
      case MotionEvent.ACTION_POINTER_DOWN:
          if(event.getPointerCount() >= 5) {
            game.start();
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