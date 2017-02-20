PImage img;
int r = 30;
float beginX = 20.0;  // Initial x-coordinate
float beginY = 10.0;  // Initial y-coordinate
float endX[] = {100, 200, 300, 400, 500};   // Final x-coordinate
float endY[] = {200, 400, 600, 800, 1000};   // Final y-coordinate
float distX;          // X-axis distance to move
float distY;          // Y-axis distance to move
float exponent = 8;   // Determines the curve
float x = 0.0;        // Current x-coordinate
float y = 0.0;        // Current y-coordinate
float step = 0.01;    // Size of each step along the path
float pct = 0.0;      // Percentage traveled (0.0 to 1.0)
int index = 0;
void setup() {
  size(755, 1080);
  img = loadImage("final.jpg");
  image(img, 0, 0);
  distX = endX[index] - beginX;
  distY = endY[index] - beginY;
}

void draw() {
  background(img);
  noStroke();
  index = round(constrain(map(mouseX, 0, width, 0, 4), 0, 4));
  pct += step;
  distX = endX[index] - beginX;
  distY = endY[index] - beginY;
  if (pct < 1.0) {
    x = beginX + (pct * distX);
    y = beginY + (pow(pct, exponent) * distY);
  } else {
    //index++;
    pct = 0;
    beginX = x;
    beginY = y;
    if (index>4){
      index = 0;
      
    }
    distX = endX[index] - beginX;
    distY = endY[index] - beginY;
  }
  fill(255);
  ellipse(x, y, r, r);
}

//void mousePressed() {
//  pct = 0.0;
//  beginX = x;
//  beginY = y;
//  endX = mouseX;
//  endY = mouseY;
//  distX = endX - beginX;
//  distY = endY - beginY;
//}