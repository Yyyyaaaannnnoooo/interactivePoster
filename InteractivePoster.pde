import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

PImage img;
int r = 30;
// Initial y-coordinate
float endX[] = {-100, 60, 185, 281, 379, 459, 538, 378, 222, 60, };   // Final x-coordinate
float endY[] = {-50, 108, 238, 328, 434, 529, 713, 865, 916, 1100, };   // Final y-coordinate
float beginX = endX[0];  // Initial x-coordinate
float beginY = endY[0];
float distX;          // X-axis distance to move
float distY;          // Y-axis distance to move
float exponent = 4;   // Determines the curve
float x = 0.0;        // Current x-coordinate
float y = 0.0;        // Current y-coordinate
float step = .02;    // Size of each step along the path
float pct = 0;      // Percentage traveled (0.0 to 1.0)
int index = 0;
int num = 200;
PVector prev[];
void setup() {
  size(915, 1080);
  img = loadImage("final.jpg");
  image(img, 0, 0);
  distX = endX[index] - beginX;
  distY = endY[index] - beginY;
  prev = new PVector[num];
  for (int i = 0; i < prev.length; i++) {
    prev[i] = new PVector(-100, -100);
  }
  video = new Capture(this, 160, 120);
  opencv = new OpenCV(this, 160, 120);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  background(0);
  image(img, 0, 0);
  noStroke();
  distX = endX[index] - beginX;
  distY = endY[index] - beginY;
  if (pct < 1) {
    x = beginX + (pct * distX);
    y = beginY + (pow(pct, exponent) * distY);
    int i = (int) constrain(map(pct, 0, 0.99, -1, 99), 0, 99);
    if (i%10==1) {
      println(i%num);
      prev[i%num].x = x;
      prev[i%num].y = y;
    }
  } else {
    index++;
    pct = 0;
    beginX = x;
    beginY = y;
    if (index>9) {
      index=0;
      //noLoop();
    }
    distX = endX[index] - beginX;
    distY = endY[index] - beginY;
  }
    video.read();
    image(video, 755, 0);
    opencv.loadImage(video);
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    Rectangle[] faces = opencv.detect();
    for (int i = 0; i < faces.length; i++) {
      rect(img.width+faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
    if (faces.length > 0) {
      pct += step;
    }else{
    //step = 0;
    //index = 0;
    }
  noStroke();
  fill(255);
  ellipse(x, y, r, r);
  noFill();
  strokeWeight(10);
  stroke(255);
  beginShape(POINTS);
  for (int i = 0; i < prev.length; i++) {
    vertex(prev[i].x, prev[i].y);
  }
  endShape();
}