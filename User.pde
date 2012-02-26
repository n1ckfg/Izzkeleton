/* --------------------------------------------------------------------------
 * SimpleOpenNI User Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / zhdk / http://iad.zhdk.ch/
 * date:  02/16/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 */

//SKEL_HEAD, SKEL_NECK, SKEL_TORSO, SKEL_RIGHT_SHOULDER, SKEL_RIGHT_ELBOW, SKEL_RIGHT_HAND, SKEL_LEFT_SHOULDER, SKEL_LEFT_ELBOW, SKEL_LEFT_HAND, SKEL_RIGHT_HIP, SKEL_RIGHT_KNEE, SKEL_RIGHT_FOOT, SKEL_LEFT_HIP, SKEL_LEFT_KNEE, SKEL_LEFT_FOOT
PVector[] simpleOpenNiPos = new PVector[osceletonNames.length];
PVector[] simpleOpenNiPos_proj = new PVector[osceletonNames.length];

void setupUser(){
  context = new SimpleOpenNI(this);
  context.setMirror(true);
   
  // enable depthMap generation 
  context.enableDepth();
  
  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
 
  background(200,0,0);

  stroke(0,0,255);
  strokeWeight(3);
  //smooth();
  
  //size(context.depthWidth(), context.depthHeight()); 
}

void drawUser(){
  // update the cam
  context.update();
  
  // draw depthImageMap
  if(modeDebug){
    image(context.depthImage(),0,0);
  }
  
  // draw the skeleton if it's available
  if(context.isTrackingSkeleton(1)){
    if(modeDebug){
    drawSkeleton(1);
    }
    simpleOpenNiEvent(1);
  }
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId){
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
  println(jointPos);
  */
  
  stroke(0,0,255);
  strokeWeight(3);
  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
 
}

// -----------------------------------------------------------------
void simpleOpenNiEvent(int userId) {
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,simpleOpenNiPos[0]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,simpleOpenNiPos[1]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_TORSO,simpleOpenNiPos[2]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,simpleOpenNiPos[3]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_ELBOW,simpleOpenNiPos[4]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,simpleOpenNiPos[5]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,simpleOpenNiPos[6]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_ELBOW,simpleOpenNiPos[7]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,simpleOpenNiPos[8]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HIP,simpleOpenNiPos[9]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_KNEE,simpleOpenNiPos[10]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_FOOT,simpleOpenNiPos[11]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HIP,simpleOpenNiPos[12]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_KNEE,simpleOpenNiPos[13]);
      context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_FOOT,simpleOpenNiPos[14]);
      
    for (int i=0;i<osceletonNames.length;i++) {
        context.convertRealWorldToProjective(simpleOpenNiPos[i],simpleOpenNiPos_proj[i]);
        x[i] = simpleOpenNiPos_proj[i].x/sW;
        y[i] = simpleOpenNiPos_proj[i].y/sH;
        z[i] = simpleOpenNiPos_proj[i].z/sD; //approximate 'cause don't know real SimpleOpenNI depth max/min in pixels; will fix
    }
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(int userId){
  println("onNewUser - userId: " + userId);
  println("  start pose detection");
  
  context.startPoseDetection("Psi",userId);
}

void onLostUser(int userId){
  println("onLostUser - userId: " + userId);
}

void onStartCalibration(int userId){
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successful){
  println("onEndCalibration - userId: " + userId + ", successful: " + successful);
  
  if (successful){ 
    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId); 
  } else { 
    println("  Failed to calibrate user !!!");
    println("  Start pose detection");
    context.startPoseDetection("Psi",userId);
  }
}

void onStartPose(String pose,int userId){
  println("onStartPose - userId: " + userId + ", pose: " + pose);
  println(" stop pose detection");
  
  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
 
}

void onEndPose(String pose,int userId){
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

