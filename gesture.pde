import android.view.MotionEvent;
import ketai.ui.*;

KetaiGesture gesture;

public boolean surfaceTouchEvent(MotionEvent event) {
  super.surfaceTouchEvent(event);
  return gesture.surfaceTouchEvent(event);
}

void onTap(float x, float y){
  mousePressed();
}

void onPinch(float x, float y, float r){
  if(r > 10) display.increaseCellSize();
  else if(r < -10) display.decreaseCellSize();
  print(x, y, r);
}

void mouseDragged(){
}