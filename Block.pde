class Block {

  float Bx;
  float By;
  Block(float x, float y) {
    Bx=x;
    By=y;
  }


  void show() {

    fill(255);
    rect(Bx, By, scl, scl);
  }
}