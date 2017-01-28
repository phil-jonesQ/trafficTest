//Over head view of city traffic
//Traffic are simple rect objects


ArrayList<Traffic> t;
ArrayList<Block> b;
int scl=30;
int cols=width/scl;
int rows=height/scl;
int Tamount=1;
int myTrafficIndex;
boolean right;
boolean down;
boolean up;
boolean left;
float velocity;


void setup() {
  size(600, 600);
  smooth();
  t = new ArrayList<Traffic>();
  b = new ArrayList<Block>();
  populateTraffic();
  addBlock();
  right=false;
  down=false;
  up=false;
  left=false;
  velocity=0.4;
  myTrafficIndex=t.size()-1;
}

void mouseClicked() {
  right=true;
  down=false;
  up=false;
  left=false;
}

void draw() {
  background(0);
  drawGrid();
  drawBlocks();
  println (myTrafficIndex);
  if (key == '1') {
    myTrafficIndex=1;
  }
  if (key == '2') {
    myTrafficIndex=2; 
  }
 
    for (int i=myTrafficIndex; i >=0; i--)
    {
      //myTrafficIndex=2;
      drawTraffic(myTrafficIndex);
      if (right) {
        moveTrafficRight(myTrafficIndex);
        handleEdges(myTrafficIndex);
      }
      if (down) {
        moveTrafficDown(myTrafficIndex);
        handleEdges(myTrafficIndex);
      }
      if (left) {
        moveTrafficLeft(myTrafficIndex);
        handleEdges(myTrafficIndex);
      }
      if (up) {
        moveTrafficUp(myTrafficIndex);
        handleEdges(myTrafficIndex);
      }
      //myTrafficIndex--;
    }
  //}
}
//println("Right = " + right + "Left = " + left + "down " + down + "Up" + up);



void populateTraffic() {
  int rowsReq=rows/rows;
  boolean shouldIadd = false;
  for (int r=0; r < rowsReq; r=r+scl) {
    for (int c =0; c < width; c=c+scl) {
      if (shouldIadd) {
        t.add(new Traffic(c, r));
      }
      float fiftyfifty = random (0, 10);
      if (fiftyfifty > 5) {
        shouldIadd = true;
      } else {
        shouldIadd = false;
      }
    }
  }
}

void drawTraffic(int chosen) {

  if (down || up) {
    //rotate
    t.get(chosen).show(true);
  } else {
    t.get(chosen).show(false);
  }
}

void drawGrid() {
  for (int r=0; r < height; r=r+scl) {
    for (int c =0; c < width; c=c+scl) {
      noFill();
      stroke(255);
      rect (c, r, scl, scl);
    }
  }
}

void moveTrafficRight(int chosen) {

  t.get(chosen).move(velocity, 0);
}

void moveTrafficDown(int chosen) {


  t.get(chosen).move(0, velocity);
}

void moveTrafficLeft(int chosen) {

  t.get(chosen).move(-velocity, 0);
}

void moveTrafficUp(int chosen) {

  t.get(chosen).move(0, -velocity);
}

void addBlock() {

  b.add(new Block (scl*5, scl));
}

void drawBlocks() {
  for (int i = 0; i < b.size(); i++) {
    b.get(i).show();
  }
}

void handleEdges(int chosen) {

  float trafficX= t.get(chosen).trafficPosX();
  float trafficY= t.get(chosen).trafficPosY();
  //println (trafficX,trafficY);
  if (trafficX > width-scl/2 && right) {
    right=false;
    down=true;
    left=false;
    up=false;
  }
  if (trafficX < scl/2 && left) {
    right=false;
    down=false;
    left=false;
    up=true;
  }

  if (trafficY > height-scl/2 && down) {
    right=false;
    down=false;
    left=true;
    up=false;
  }

  if (trafficY < scl/2 && up) {
    right=true;
    down=false;
    left=false;
    up=false;
  }
}