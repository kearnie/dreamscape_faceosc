//
// a template for receiving face tracking osc messages from
// Kyle McDonald's FaceOSC https://github.com/kylemcdonald/ofxFaceTracker
//
// 2012 Dan Wilcox danomatika.com
// for the IACD Spring 2012 class at the CMU School of Art
//
// adapted from from Greg Borenstein's 2011 example
// http://www.gregborenstein.com/
// https://gist.github.com/1603230
//

//modified 10.14.2016 for faceosc project 
//dreamscape by kearnie lin
import oscP5.*;
OscP5 oscP5;
import java.util.concurrent.ThreadLocalRandom;
import java.util.*;

import processing.sound.*; //for dreamscape audio
SoundFile file;

// num faces found
int found;

// pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();

// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;

// Constants
int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2;
int dim;

ParticleSystem ps;
ParticleSystem ps2;
Dust[] dustList = new Dust [60];
float gMove = map(.15,0,.3,0,30); //thank you ari!

void setup() {
  size(640, 640);
  frameRate(30);
  c1 = color(17,24,51);
  c2 = color(24,55,112);
  ps = new ParticleSystem(new PVector(eyeRight-25,-10));
  ps2 = new ParticleSystem(new PVector(eyeLeft+25, -10));
  for (int i = 0; i < dustList.length; i++) {
    dustList[i] = new Dust();
  }
  file = new SoundFile(this, "faceoscmusic.mp3");
  file.loop();
  file.amp(0); //play audio when avatar is awake

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseScale", "/pose/scale");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
}

float eyesClosedValue = 0;
void draw() {  
  background(255);
  stroke(0);
  boolean eyesClosed = false;
  
  if(found > 0) {
    pushMatrix();
    translate(posePosition.x, posePosition.y);
    scale(poseScale);
    noFill();
    if (eyeLeft < 3.0 || eyeRight < 3.0 || eyebrowLeft < 7.8 || eyebrowRight < 7.8) {
      eyesClosed = true;
    }
    print(eyeLeft); //debugging (finding threshold vals)
    print(eyeRight);
    if (eyesClosed == false) {
      ps.addParticle();
      ps.run();
      ps2.addParticle();
      ps2.run();
    }
    popMatrix();
  }

  if (eyesClosed) {
  file.amp(eyesClosedValue/255.0);
  c1 = color(17,24,51,eyesClosedValue);
  c2 = color(24,55,112,eyesClosedValue);
    eyesClosedValue += 3;
    if (eyesClosedValue > 255) eyesClosedValue = 255;
    //gradient
    setGradient(0, 0, width, height, c1, c2, Y_AXIS);
    Random ran = new Random(50);
    //implement stars

    for (int i = 0; i < 60; i++) {
      noStroke();
      int[] r = {230,235,242,250,255};
      int[] g = {228,234,242,250,255};
      int[] b = {147,175,208,240,255};
      int starA = (int)(min(ran.nextInt(100),eyesClosedValue) + sin((frameCount+ran.nextInt(100))/20.0)*40);
      fill(r[(ran.nextInt(5))],
           g[(ran.nextInt(5))],
           b[ran.nextInt(5)], starA);
      pushMatrix();
      
      translate(Float.valueOf(String.valueOf(width*ran.nextFloat())), Float.valueOf(String.valueOf(height*ran.nextFloat())));
      rotate(frameCount / -100.0);
      float r1 = 2 + (ran.nextFloat()*4);
      float r2 = 2.0 * r1;
      star(0, 0, r1, r2, 5); 
      popMatrix();
    }
   for (int j = 0; j < dustList.length; j++) {
     dustList[j].update();
     dustList[j].display();
   }
  } else {
       eyesClosedValue = 0; 
       file.amp(0);
    }

}

class Dust {
  PVector position;
  PVector velocity;
  float move = random(-7,1);
  
  Dust() {
    position = new PVector(width/2,height/2);
    velocity = new PVector(1 * random(-1,1), -1 * random(-1,1));
  }
  void update() {
    position.add(velocity);
    if (position.x > width) { position.x = 0; }
    if ((position.y > height) || (position.y < 0)) {
      velocity.y = velocity.y * -1;
    }
  }
  void display() {
    fill(255,255,212,100);
    ellipse(position.x,position.y,gMove+move, gMove+move);
    ellipse(position.x,position.y,(gMove+move)*0.5,(gMove+move)*0.5);
  }
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem(PVector location) {
    origin = location.copy();
    particles = new ArrayList<Particle>();
  }
  
  void addParticle() {
    particles.add(new Particle(origin));
  }
  
  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,0.05);
    velocity = new PVector(random(-1,1),random(-2,0));
    location = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // update location 
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 5.0;
  }

  // display particles
  void display() {
    noStroke();
    //fill(216,226,237,lifespan-15);
    //ellipse(location.x,location.y,3,3);
    fill(248,255,122,lifespan);
    ellipse(location.x,location.y,2,2);
    ellipse(location.x,location.y,2.5,2.5);
  }
  
  // "irrelevant" particle
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

//draw stars
void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

//draw gradient
void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
  noFill();
  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
}

// OSC CALLBACK FUNCTIONS

public void found(int i) {
  println("found: " + i);
  found = i;
}

public void poseScale(float s) {
  println("scale: " + s);
  poseScale = s;
}

public void posePosition(float x, float y) {
  println("pose position\tX: " + x + " Y: " + y );
  posePosition.set(x, y, 0);
}

public void poseOrientation(float x, float y, float z) {
  println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientation.set(x, y, z);
}

public void mouthWidthReceived(float w) {
  println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  println("mouth height: " + h);
  mouthHeight = h;
}

public void eyeLeftReceived(float f) {
  println("eye left: " + f);
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  println("eye right: " + f);
  eyeRight = f;
}

public void eyebrowLeftReceived(float f) {
  println("eyebrow left: " + f);
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  println("eyebrow right: " + f);
  eyebrowRight = f;
}

public void jawReceived(float f) {
  println("jaw: " + f);
  jaw = f;
}

public void nostrilsReceived(float f) {
  println("nostrils: " + f);
  nostrils = f;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if(m.isPlugged() == false) {
    println("UNPLUGGED: " + m);
  }
}