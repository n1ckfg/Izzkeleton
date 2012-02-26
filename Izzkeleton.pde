//import processing.opengl.*;
import oscP5.*;
import netP5.*;
import SimpleOpenNI.*;

//~~~~~~~~~~~~~~~~~~

SimpleOpenNI  context;

int sW = 640;
int sH = 480;
int sD = 2000;
int fps = 30;

String[] osceletonNames = {
  //~~~   complete list of working joints, check updates at https://github.com/Sensebloom/OSCeleton  ~~~
  "head", "neck", "torso", "r_shoulder", "r_elbow", "r_hand", "l_shoulder", "l_elbow", "l_hand", "r_hip", "r_knee", "r_foot", "l_hip", "l_knee", "l_foot"
    //"r_hand","r_wrist","r_elbow","r_shoulder", "l_hand","l_wrist","l_elbow","l_shoulder","head","torso"
};

float[] x = new float[osceletonNames.length];
float[] y = new float[osceletonNames.length];
float[] z = new float[osceletonNames.length];
float depth = 200; //range of depth...
int circleSize = 50;

boolean modeDebug = true;

//~~~~~~~~~~~~~~~~~~

void setup() {
  size(sW, sH, P2D);
  frameRate(fps);

  for (int i=0;i<osceletonNames.length;i++) {
    simpleOpenNiPos[i] = new PVector(0, 0, 0);
    simpleOpenNiPos_proj[i] = new PVector(0, 0, 0);
  }


  ellipseMode(CENTER);
  oscSetup();
  setupUser();
}

//~~~


void draw() {
  if(modeDebug){
    background(0);
  }
  drawUser(); //looking for one user; may upgrade later
  oscSend();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void keyPressed() {
  if (key==' ') {
  modeDebug = !modeDebug;
  background(0);
  }
}

void stop() {
  super.stop();
  exit();
}

