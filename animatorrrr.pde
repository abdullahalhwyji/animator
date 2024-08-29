import ddf.minim.*;
import ddf.minim.spi.*;

Minim minim;
AudioPlayer waveSound;
PImage boatImage1; // Declare a PImage variable for the first boat's image
PImage boatImage2; // Declare a PImage variable for the second boat's image
float cloud1X, cloud2X, cloud3X, cloud4X, cloud5X;
float[] cloudX = new float[6];
float yoff1 = 0.005; // 2nd dimension of Perlin noise for the first boat
float yoff2 = 0.01; // 2nd dimension of Perlin noise for the second boat
float boatSize = 300; // Size of the floating boats
float boatSizeClose = 900;
int startTime; // Variable to store the start time
boolean scene1Active = true; // Variable to keep track of the active scene

void setup() {
  size(1280, 720);
  cloud1X = 300;
  cloud2X = 900;
  cloud3X = 600;
  cloud4X = 1400;
  cloud5X = 200;
  cloudX[0] = 300;
  cloudX[1] = 900;
  cloudX[2] = 600;
  cloudX[3] = 1400;
  cloudX[4] = 200;
  cloudX[5] = 1600;
  minim = new Minim(this);
  waveSound = minim.loadFile("wavesound.mp3"); // Load your wave sound MP3 file
  waveSound.setGain(5);

  boatImage1 = loadImage("boat1.png"); // Load your image file for the first boat (replace with your image path)
  boatImage2 = loadImage("boat1.png"); // Load your image file for the second boat (replace with your image path)

  frameRate(20); // Adjust frame rate for smooth animation
  
  startTime = millis(); // Record the start time
}

void draw() {
  int elapsedTime = millis() - startTime; // Calculate elapsed time in milliseconds

  if (elapsedTime < 7000) {
    scene1(); // Display scene1 for the first 7 seconds
  } else if (elapsedTime < 10000) {
    scene2(); // Display scene2 for the next 3 seconds
  } else if (elapsedTime < 13000) {
    scene3(); // Display scene3 for the next 3 seconds
  } else if (elapsedTime < 28000) {
    scene2(); // Display scene2 for the next 15 seconds
  } else {
    scene3(); // Display scene3 after 15 seconds
  }
}

void sea() {
  int skyHeight = height * 2 / 3; // Adjusted sea level height
  float xoff = 0;
  fill(60, 110, 160); // Darker shade of blue
  beginShape();

  for (float x = 0; x <= width; x += 10) {
    float y = map(noise(xoff, yoff1), 0, 1, skyHeight, height);
    vertex(x, y);
    xoff += 0.005;
  }
  yoff1 += 0.001;
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}

void sun(){
  // Draw the sun at the center
  int skyHeight = height * 2 / 3;
  float sunSize = 100; // Adjust sun size as needed
  float sunX = width / 2; // Center horizontally
  float sunY = skyHeight / 3; // Center vertically in the sky area

  color sunCenterColor = color(255, 204, 0); // Yellow center color
  color sunEdgeColor = color(255, 140, 0); // Orange edge color

  int steps = 100; // Number of steps in the gradient
  for (int i = steps; i > 0; i--) {
    float inter = map(i, 0, steps, 0, 1);
    color c = lerpColor(sunEdgeColor, sunCenterColor, inter);
    fill(c);
    noStroke();
    ellipse(sunX, sunY, sunSize * (float)i / steps, sunSize * (float)i / steps);
  }
}

void updateCloudPositions() {
  cloud1X -= 1;
  cloud2X -= 1.5;
  cloud3X -= 0.8;
  cloud4X -= 1.2;
  cloud5X -= 1;

  if (cloud1X < -150) cloud1X = width;
  if (cloud2X < -150) cloud2X = width;
  if (cloud3X < -150) cloud3X = width;
  if (cloud4X < -150) cloud4X = width;
  if (cloud5X < -150) cloud5X = width;
}

void drawClouds() {
  noStroke();
  drawGradientCloud(cloud1X, 100);
  drawGradientCloud(cloud2X, 100);
  drawGradientCloud(cloud3X, 250);
  drawGradientCloud(cloud4X, 300);
  drawGradientCloud(cloud5X, 300);
}

void drawGradientCloud(float x, float y) {
  int steps = 50;
  for (int i = 0; i < steps; i++) {
    float inter = map(i, 0, steps, 0, 1);
    color c = lerpColor(#D3D3D3, #FFFFFF, inter);
    fill(c);
    ellipse(x, y, 150 - i, 80 - i);
    ellipse(x + 50, y, 165 - i, 100 - i);
    ellipse(x + 100, y, 150 - i, 80 - i);
  }
}

void boat() {
  int skyHeight = height * 2 / 3;
  imageMode(CENTER); // Set image mode to center

  // Draw the first floating boat (flipped horizontally)
  float boat1X = width / 3; // Adjust the first boat's starting X position
  float boat1Y = map(noise(yoff1), 0, 1, skyHeight, height - 30); // Adjust Y position (lowered by 30 pixels)
  float boat1Size = boatSize * 2; // Increase the size of the first boat
  // Draw the fishing rod (pancing)
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 104, boat1Y - 24); // Move to the boat's position and adjust for fishing rod placement
  scale(0.2);
  pancing(); // Draw the fishing rod
  popMatrix(); // Restore the previous transformation matrix
  // Draw char1 on top of the boat
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 90, boat1Y - boat1Size / 20); // Move to the boat's position, adjusted for size
  scale(0.2); 
  char1();
  popMatrix(); // Restore the previous transformation matrix

  pushMatrix(); // Start a new transformation matrix
  translate(boat1X, boat1Y); // Move to the boat's position
  scale(-1, 1); // Flip horizontally
  image(boatImage1, 0, 0, boatSize, boatSize); // Draw the flipped boat
  popMatrix(); // Restore the previous transformation matrix

  // Draw the second floating boat
  float boat2X = 2 * width / 3; // Adjust the second boat's starting X position
  float boat2Y = map(noise(yoff2), 0, 1, skyHeight, height - 30); // Adjust Y position (lowered by 30 pixels)
  // Draw the fishing rod (pancing)
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X + -105.5, boat2Y -22); // Move to the boat's position and adjust for fishing rod placement
  scale(0.2);
  scale(-1,1);
  pancing(); // Draw the fishing rod
  popMatrix(); // Restore the previous transformation matrix
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X + -92, boat2Y - boatSize / 10); // Move to the boat's position, adjusted for size
  scale(0.159);
  char2();
  popMatrix(); // Restore the previous transformation matrix
  
  image(boatImage2, boat2X, boat2Y, boatSize, boatSize); // Draw the second boat

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;
  yoff2 += 0.01;

  // Play wave sound when the boats move up and down
  if (frameCount % 60 == 0) { // Adjust frequency of sound play
    if (!waveSound.isPlaying()) {
      waveSound.rewind();
      waveSound.play();
    }
  }
}

void boatcloseup() {
  int skyHeight = height * 2 / 3;
  imageMode(CENTER); // Set image mode to center

  // Draw the first floating boat (flipped horizontally, larger, and positioned on the left side)
  float boat1X = width / 4; // Adjust the first boat's starting X position to the left side
  float boat1Y = map(noise(yoff1), 0, 1, skyHeight, height - 50); // Adjust Y position (lowered by 30 pixels)
  float boat1Size = boatSize * 4; // Increase the size of the first boat
  // Draw the fishing rod (`pancing`)
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 390, boat1Y - 130); // Move to the boat's position and adjust for fishing rod placement
  pancing(); // Draw the fishing rod
  popMatrix(); // Restore the previous transformation matrix
  // Draw char1 on top of the boat
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 322, boat1Y - boat1Size / 7.5); // Move to the boat's position, adjusted for size
  char1();
  popMatrix(); // Restore the previous transformation matrix
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X, boat1Y); // Move to the boat's position
  scale(-1, 1); // Flip horizontally
  image(boatImage1, 0, 0, boat1Size, boat1Size); // Draw the flipped and larger boat
  popMatrix(); // Restore the previous transformation matrix

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;

  // Play wave sound when the boats move up and down
  if (frameCount % 60 == 0) { // Adjust frequency of sound play
    if (!waveSound.isPlaying()) {
      waveSound.rewind();
      waveSound.play();
    }
  }
}

void boatcloseup2() {
  int skyHeight = height * 2 / 3;
  imageMode(CENTER); // Set image mode to center

  // Draw the second floating boat (flipped horizontally, larger, and positioned on the right side)
  float boat2X = width / 1.2; // Adjust the second boat's starting X position to the right side
  float boat2Y = map(noise(yoff1), 0, 1, skyHeight, height - 50); // Adjust Y position (lowered by 50 pixels)
  float boat2Size = boatSize * 4; // Increase the size of the second boat
  // Draw the fishing rod (`pancing`)
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X - 392, boat2Y - 155); // Move to the boat's position and adjust for fishing rod placement
  scale(-1,1);
  pancing(); // Draw the fishing rod
  popMatrix(); // Restore the previous transformation matrix
  // Draw char2 on top of the boat
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X - 270, boat2Y - boat2Size / 4.9); // Move to the boat's position, adjusted for size
  char2();
  popMatrix(); // Restore the previous transformation matrix
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X, boat2Y); // Move to the boat's position
  //scale(-1, 1); // Optionally flip horizontally
  image(boatImage2, 0, 0, boat2Size, boat2Size); // Draw the boat
  popMatrix(); // Restore the previous transformation matrix

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;

  // Play wave sound when the boats move up and down
  if (frameCount % 60 == 0) { // Adjust frequency of sound play
    if (!waveSound.isPlaying()) {
      waveSound.rewind();
      waveSound.play();
    }
  }
}

void char1() {
  scale(0.8); // Reduce the size of char1 to 50%
  fill(255, 0, 0); // Red color

  // Draw the body
  noStroke();
  rect(100, 180, 160, 160, 0, 0, 55, 55);

  // Draw the head
  noStroke();
  ellipse(200, 175, 200, 160);

  // draw hand
  rect(230, 250, 60, 35, 0, 30, 30, 0); // Right hand
  
  // Draw the "feet" that merge into the body
  ellipse(145, 340, 50, 50); // Left foot
  ellipse(215, 340, 50, 50); // Right foot

  // Draw the eyes
  fill(255); // White color for eyes
  ellipse(175, 165, 60, 28); // Left eye
  ellipse(240, 165, 60, 28); // Right eye

  // Draw the pupils
  fill(64, 32, 0); // Brown color for pupils
  ellipse(185, 165, 20, 20); // Left pupil
  ellipse(250, 165, 20, 20); // Right pupil

  // Draw the mouth
  fill(0); // Black color for mouth
  rect(195, 195, 15, 2);
}

void char2() {
  fill(8, 143, 143); //color
  scale(-1,1);

  // Draw the body
  noStroke();
  rect(100, 180, 160, 160, 0, 0, 55, 55);

  // Draw the head
  noStroke();
  ellipse(200, 175, 200, 160);

  // Draw the hand
  rect(230, 250, 60, 35, 0, 30, 30, 0); // Right hand
  
  // Draw the "feet" that merge into the body
  ellipse(145, 340, 50, 50); // Left foot
  ellipse(215, 340, 50, 50); // Right foot

  // Draw the eyes
  fill(255); // White color for eyes
  ellipse(175, 165, 60, 28); // Left eye
  ellipse(240, 165, 60, 28); // Right eye

  // Draw the pupils
  fill(64, 32, 0); // Brown color for pupils
  ellipse(185, 165, 25, 25); // Left pupil
  ellipse(250, 165, 25, 25); // Right pupil

  // Draw the mouth
  fill(255); // Black color for mouth
  stroke(0);
  strokeWeight(2);
  arc(210, 200, 40, 20, 0, PI, CHORD); // Smiling mouth
  //line(195, 205, 200, 210); // Left laugh line
  //line(225, 205, 220, 210); // Right laugh line
}

void stop() {
  waveSound.close();
  minim.stop();
  super.stop();
}

void scene1(){
  // Create a gradient background
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(color(173, 216, 230), color(135, 206, 250), inter);
    stroke(c);
    line(0, y, width, y);
  }
  sea();
  sun();
  boat();
  drawClouds();
  updateCloudPositions();
}

void scene2(){
  // Create a gradient background
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(color(173, 216, 230), color(135, 206, 250), inter);
    stroke(c);
    line(0, y, width, y);
  }
  sea();
  drawClouds();
  updateCloudPositions();
  boatcloseup();
}

void scene3(){
  // Create a gradient background
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(color(173, 216, 230), color(135, 206, 250), inter);
    stroke(c);
    line(0, y, width, y);
  }
  sea();
  drawClouds();
  updateCloudPositions();
  boatcloseup2();
}

void pancing() {
  float rodBaseX = 0; // Base x-coordinate of the rod
  float rodBaseY = 0; // Base y-coordinate of the rod
  float rodEndX = 220; // End x-coordinate of the rod
  float rodEndY = -100; // End y-coordinate of the rod

  pushMatrix(); // Start a new transformation matrix
  translate(rodBaseX + 158, rodBaseY + 174); // Move the origin to the new position on the right and down
  stroke(0);
  strokeWeight(5);
  line(0, 0, rodEndX, rodEndY); // Draw the fishing rod from the new origin
  popMatrix(); // Restore the previous transformation matrix

  // Draw the fishing string
  strokeWeight(2); // Set the weight for the string
  line(rodEndX + 158, rodEndY + 174, rodEndX + 158, height); // Draw the string from the rod's end to the bottom of the screen
}

void char1merem() {
  scale(0.8); // Reduce the size of char1 to 50%
  fill(255, 0, 0); // Red color

  // Draw the body
  noStroke();
  rect(100, 180, 160, 160, 0, 0, 55, 55);

  // Draw the head
  noStroke();
  ellipse(200, 175, 200, 160);

  // draw hand
  rect(230, 250, 60, 35, 0, 30, 30, 0); // Right hand
  
  // Draw the "feet" that merge into the body
  ellipse(145, 340, 50, 50); // Left foot
  ellipse(215, 340, 50, 50); // Right foot

  // Draw the eyes
  fill(255); // White color for eyes
  ellipse(175, 165, 60, 28); // Left eye
  ellipse(240, 165, 60, 28); // Right eye

  // Draw the pupils
  fill(64, 32, 0); // Brown color for pupils
  ellipse(185, 165, 20, 20); // Left pupil
  ellipse(250, 165, 20, 20); // Right pupil

  // Draw the mouth
  fill(0); // Black color for mouth
  rect(195, 195, 15, 2);
}
