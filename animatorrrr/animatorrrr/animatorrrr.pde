//import ddf.minim.*;
//import ddf.minim.spi.*;

//Minim minim;
//AudioPlayer waveSound;
PImage boatImage1; // Declare a PImage variable for the first boat's image
PImage boatImage2; // Declare a PImage variable for the second boat's image
float cloud1X, cloud2X, cloud3X, cloud4X, cloud5X;
float[] cloudX = new float[6];
float yoff1 = 0.005; // 2nd dimension of Perlin noise for the first boat
float yoff2 = 0.01; // 2nd dimension of Perlin noise for the second boat
float boatSize = 300; // Size of the floating boats
float boatSizeClose = 900;
float boat2Speed = 2; // Speed at which the second boat moves to the right
float boat2XOffset = 0; // Offset for the second boat's X position  
int startTime; // Variable to store the start time
boolean scene1Active = true; // Variable to keep track of the active scene

void setup() {
  frameRate(60); // Adjust frame rate for smooth animation
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
  //minim = new Minim(this);
  //waveSound = minim.loadFile("wavesound.mp3"); // Load your wave sound MP3 file
  //waveSound.setGain(5);

  boatImage1 = loadImage("boat1.png"); // Load your image file for the first boat (replace with your image path)
  boatImage2 = loadImage("boat1.png"); // Load your image file for the second boat (replace with your image path)

  
  
  //startTime = millis(); // Record the start time
}

void draw() {
  float timeOfDay = (millis() % 24000) / 24000.0; // Full cycle every 48 seconds
  scene9(timeOfDay);
   //Display the scene with the sun and sky color changing based on the time of day
  int elapsedTime = millis() - startTime; // Calculate elapsed time in milliseconds

  if (elapsedTime < 10000) {
    scene1(); // Display scene1 for the first 7 seconds
  } else if (elapsedTime < 10000) {
    scene2(); // Display scene2 for the next 3 seconds
  } else if (elapsedTime < 13000) {
    scene3(); // Display scene3 for the next 3 seconds
  } else if (elapsedTime < 28000) {
    scene2(); // Display scene2 for the next 15 seconds
  } else if (elapsedTime < 43000) {
    scene3(); // Display scene3 for the next 15 seconds
  } else if (elapsedTime < 58000) {
    scene4(); // Display scene4 for the next 15 seconds
  } else if (elapsedTime < 73000) {
    scene5(); // Display scene5 for the next 15 seconds
  } else if (elapsedTime < 86000) {
    scene6(); // Display scene6 for the next 13 seconds
  } else if (elapsedTime < 113000) {
    scenepergi(); // Display scenepergi until the boat is out of frame
    if (boat2XOffset > width) { // Check if the second boat is out of frame
      startTime = millis(); // Reset start time
      scene7(); // Transition to scene7
    }
  } else if (elapsedTime < 128000) {
    scene7(); // Display scene7 for 15 seconds
  } else if (elapsedTime < 138000) {
    scene8(); // Display scene8 for 10 seconds
  } else if (elapsedTime < 162000) {
    scene9(timeOfDay); // Display scene9(timeOfDay) for the day-night-day cycle
  } else if (elapsedTime < 169000) {
    scene10(); // Display scene10 for 7 seconds
  } else if (elapsedTime < 172000) {
    scene11(); // Display scene11 for 3 seconds
  } else if (elapsedTime < 178000) {
    scene12(); // Display scene12 for 6 seconds
  } else {
    startTime = millis(); // Reset start time if elapsed time exceeds the total duration
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
  yoff1 += 0.005;
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
 float cloudSpeed = 1; // Base speed for smoother cloud movement

  cloud1X -= cloudSpeed * 5; // Adjust speed for each cloud
  cloud2X -= cloudSpeed * 7;
  cloud3X -= cloudSpeed * 4.2;
  cloud4X -= cloudSpeed * 5.8;
  cloud5X -= cloudSpeed * 5;
  
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

void celestialBody(float timeOfDay, color centerColor, color edgeColor, float sizeFactor, boolean isSun) {
  // Calculate position based on time of day
  float bodyX = map(timeOfDay, 0, 1, 0, width);
  float bodyY = height / 2 - sin(PI * timeOfDay) * height / 3;

  // Draw the celestial body
  float bodySize = 100 * sizeFactor; // Adjust size as needed

  int steps = 100; // Number of steps in the gradient
  for (int i = steps; i > 0; i--) {
    float inter = map(i, 0, steps, 0, 1);
    color c = lerpColor(edgeColor, centerColor, inter);
    fill(c);
    noStroke();
    ellipse(bodyX, bodyY, bodySize * (float)i / steps, bodySize * (float)i / steps);
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
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X - 180, boat2Y - boatSize / 15); // Move to the middle of the canvas
  scale(0.1); // Scale down bucketfish
  bucketfish();
  popMatrix(); // Restore the previous transformation matrix
  
  image(boatImage2, boat2X, boat2Y, boatSize, boatSize); // Draw the second boat

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;
  yoff2 += 0.01;

  //// Play wave sound when the boats move up and down
  //if (frameCount % 60 == 0) { // Adjust frequency of sound play
  //  if (!waveSound.isPlaying()) {
  //    waveSound.rewind();
  //    waveSound.play();
  //  }
  //}
}

void boatsendiri() {
  int skyHeight = height * 2 / 3;
  imageMode(CENTER); // Set image mode to center

  // Draw the first floating boat (flipped horizontally)
  float boat1X = width / 3; // Adjust the first boat's starting X position
  float boat1Y = map(noise(yoff1), 0, 1, skyHeight, height - 30); // Adjust Y position (lowered by 30 pixels)
  float boat1Size = boatSize * 2; // Increase the size of the first boat
  // Draw the fishing rod (pancing)
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 102, boat1Y - 15); // Move to the boat's position and adjust for fishing rod placement
  scale(0.2);
  pancing(); // Draw the fishing rod
  popMatrix(); // Restore the previous transformation matrix
  // Draw char1 on top of the boat
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 70, boat1Y - boat1Size / 35); // Move to the boat's position, adjusted for size
  scale(0.2); 
  char1tidur();
  popMatrix(); // Restore the previous transformation matrix

  pushMatrix(); // Start a new transformation matrix
  translate(boat1X, boat1Y); // Move to the boat's position
  scale(-1, 1); // Flip horizontally
  image(boatImage1, 0, 0, boatSize, boatSize); // Draw the flipped boat
  popMatrix(); // Restore the previous transformation matrix
  
  yoff1 += 0.01;
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

  //// Play wave sound when the boats move up and down
  //if (frameCount % 60 == 0) { // Adjust frequency of sound play
  //  if (!waveSound.isPlaying()) {
  //    waveSound.rewind();
  //    waveSound.play();
  //  }
  //}
  
}
void boatcloseupturu() {
  int skyHeight = height * 2 / 3;
  imageMode(CENTER); // Set image mode to center

  // Draw the first floating boat (flipped horizontally, larger, and positioned on the left side)
  float boat1X = width / 4; // Adjust the first boat's starting X position to the left side
  float boat1Y = map(noise(yoff1), 0, 1, skyHeight, height - 50); // Adjust Y position (lowered by 30 pixels)
  float boat1Size = boatSize * 4; // Increase the size of the first boat
  // Draw the fishing rod (`pancing`)
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 375, boat1Y - 90); // Move to the boat's position and adjust for fishing rod placement
  pancing(); // Draw the fishing rod
  popMatrix(); // Restore the previous transformation matrix
  // Draw char1 on top of the boat
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 200, boat1Y - boat1Size / 12); // Move to the boat's position, adjusted for size
  char1tidur();
  popMatrix(); // Restore the previous transformation matrix
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X, boat1Y); // Move to the boat's position
  scale(-1, 1); // Flip horizontally
  image(boatImage1, 0, 0, boat1Size, boat1Size); // Draw the flipped and larger boat
  popMatrix(); // Restore the previous transformation matrix

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;

  //// Play wave sound when the boats move up and down
  //if (frameCount % 60 == 0) { // Adjust frequency of sound play
  //  if (!waveSound.isPlaying()) {
  //    waveSound.rewind();
  //    waveSound.play();
  //  }
  //}
}

void boatcloseupkaget() {
  int skyHeight = height * 2 / 3;
  imageMode(CENTER); // Set image mode to center

  // Draw the first floating boat (flipped horizontally, larger, and positioned on the left side)
  float boat1X = width / 4; // Adjust the first boat's starting X position to the left side
  float boat1Y = map(noise(yoff1), 0, 1, skyHeight, height - 50); // Adjust Y position (lowered by 30 pixels)
  float boat1Size = boatSize * 4; // Increase the size of the first boat
  // Draw the fishing rod (`pancing`)
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 375, boat1Y - 90); // Move to the boat's position and adjust for fishing rod placement
  pancing(); // Draw the fishing rod
  popMatrix(); // Restore the previous transformation matrix
  // Draw char1 on top of the boat
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X + 200, boat1Y - boat1Size / 12); // Move to the boat's position, adjusted for size
  charkaget();
  popMatrix(); // Restore the previous transformation matrix
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X, boat1Y); // Move to the boat's position
  scale(-1, 1); // Flip horizontally
  image(boatImage1, 0, 0, boat1Size, boat1Size); // Draw the flipped and larger boat
  popMatrix(); // Restore the previous transformation matrix

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;

  //// Play wave sound when the boats move up and down
  //if (frameCount % 60 == 0) { // Adjust frequency of sound play
  //  if (!waveSound.isPlaying()) {
  //    waveSound.rewind();
  //    waveSound.play();
  //  }
  //}
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

  //// Draw the bucketfish in the middle of the canvas
  //float bucketfishX = width / 2; // Middle of the canvas
  //float bucketfishY = map(noise(yoff1), 0, 1, skyHeight, height - 50) - boat2Size / 8; // Move up and down with the boat

  pushMatrix(); // Start a new transformation matrix
  translate(boat2X - 650, boat2Y - boat2Size / 15); // Move to the middle of the canvas
  scale(0.4); // Scale down bucketfish
  bucketfish();
  popMatrix(); // Restore the previous transformation matrix

  // Draw the second boat
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X, boat2Y); // Move to the boat's position
  // Optionally flip horizontally
  image(boatImage2, 0, 0, boat2Size, boat2Size); // Draw the boat
  popMatrix(); // Restore the previous transformation matrix

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;

  //// Play wave sound when the boats move up and down
  //if (frameCount % 60 == 0) { // Adjust frequency of sound play
  //  if (!waveSound.isPlaying()) {
  //    waveSound.rewind();
  //    waveSound.play();
  //  }
  //}
}

void boatcloseupbaru() {
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
  char1merem();
  popMatrix(); // Restore the previous transformation matrix
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X, boat1Y); // Move to the boat's position
  scale(-1, 1); // Flip horizontally
  image(boatImage1, 0, 0, boat1Size, boat1Size); // Draw the flipped and larger boat
  popMatrix(); // Restore the previous transformation matrix

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;

  //// Play wave sound when the boats move up and down
  //if (frameCount % 60 == 0) { // Adjust frequency of sound play
  //  if (!waveSound.isPlaying()) {
  //    waveSound.rewind();
  //    waveSound.play();
  //  }
  //}
}

void boatcloseup2baru() {
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
  char2baru();
  popMatrix(); // Restore the previous transformation matrix

  //// Draw the bucketfish in the middle of the canvas
  //float bucketfishX = width / 2; // Middle of the canvas
  //float bucketfishY = map(noise(yoff1), 0, 1, skyHeight, height - 50) - boat2Size / 8; // Move up and down with the boat

  pushMatrix(); // Start a new transformation matrix
  translate(boat2X - 650, boat2Y - boat2Size / 15); // Move to the middle of the canvas
  scale(0.4); // Scale down bucketfish
  bucketfish();
  popMatrix(); // Restore the previous transformation matrix

  // Draw the second boat
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X, boat2Y); // Move to the boat's position
  // Optionally flip horizontally
  image(boatImage2, 0, 0, boat2Size, boat2Size); // Draw the boat
  popMatrix(); // Restore the previous transformation matrix

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;

  //// Play wave sound when the boats move up and down
  //if (frameCount % 60 == 0) { // Adjust frequency of sound play
  //  if (!waveSound.isPlaying()) {
  //    waveSound.rewind();
  //    waveSound.play();
  //  }
  //}
}

void boatcloseupsad() {
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
  char1sad();
  popMatrix(); // Restore the previous transformation matrix
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X, boat1Y); // Move to the boat's position
  scale(-1, 1); // Flip horizontally
  image(boatImage1, 0, 0, boat1Size, boat1Size); // Draw the flipped and larger boat
  popMatrix(); // Restore the previous transformation matrix

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;

  //// Play wave sound when the boats move up and down
  //if (frameCount % 60 == 0) { // Adjust frequency of sound play
  //  if (!waveSound.isPlaying()) {
  //    waveSound.rewind();
  //    waveSound.play();
  //  }
  //}
}

void boatcloseupdetermine() {
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
  char1determine();
  popMatrix(); // Restore the previous transformation matrix
  pushMatrix(); // Start a new transformation matrix
  translate(boat1X, boat1Y); // Move to the boat's position
  scale(-1, 1); // Flip horizontally
  image(boatImage1, 0, 0, boat1Size, boat1Size); // Draw the flipped and larger boat
  popMatrix(); // Restore the previous transformation matrix

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;

  //// Play wave sound when the boats move up and down
  //if (frameCount % 60 == 0) { // Adjust frequency of sound play
  //  if (!waveSound.isPlaying()) {
  //    waveSound.rewind();
  //    waveSound.play();
  //  }
  //}
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

void charkaget() {
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

  // Draw the eyes widened for a shocked expression
  fill(255); // White color for eyes
  ellipse(175, 165, 60, 40); // Left eye (widened)
  ellipse(240, 165, 60, 40); // Right eye (widened)

  // Draw the pupils moved to the right and smaller for a shocked expression
  fill(64, 32, 0); // Brown color for pupils
  ellipse(195, 165, 15, 15); // Left pupil (moved to the right and smaller)
  ellipse(260, 165, 15, 15); // Right pupil (moved to the right and smaller)

  // Draw the mouth open for a shocked expression
  fill(0); // Black color for mouth
  ellipse(200, 200, 30, 30); // Open mouth
}

void char1tidur() {
  scale(0.8); // Reduce the size of char1 to 80%
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

  // Draw the eyes as closed
  stroke(0); // Black color for closed eyes
  strokeWeight(3);
  line(150, 165, 200, 165); // Left closed eye
  line(215, 165, 265, 165); // Right closed eye

  // Draw the mouth
  fill(0); // Black color for mouth
  rect(190, 195, 20, 2); // A small straight line to indicate closed mouth

  // Optional: Draw Zzz to indicate sleeping
  textSize(32);
  fill(0);
  text("Zzz", 270, 130);
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

//void stop() {
//  waveSound.close();
//  minim.stop();
//  super.stop();
//}

void scene9(float timeOfDay) {
  color skyColor;

  // Normalize timeOfDay to range [0, 2] and map to appropriate sky colors
  if (timeOfDay < 0.25) { // Night to early morning
    skyColor = lerpColor(color(0, 0, 102), color(135, 206, 235), timeOfDay * 4);
  } else if (timeOfDay < 0.5) { // Early morning to noon
    skyColor = lerpColor(color(135, 206, 235), color(255, 204, 204), (timeOfDay - 0.25) * 4);
  } else if (timeOfDay < 0.75) { // Noon to evening
    skyColor = lerpColor(color(255, 204, 204), color(0, 0, 102), (timeOfDay - 0.5) * 4);
  } else { // Evening to night
    skyColor = lerpColor(color(0, 0, 102), color(0, 0, 0), (timeOfDay - 0.75) * 4);
  }

  background(skyColor);

  // Determine the current phase for sun and moon
  float celestialTime = (millis() % 24000) / 12000.0; // Full sun-moon cycle every 24 seconds
  if (celestialTime < 1) { // Sun is visible from 0 to 1
    celestialBody(celestialTime, color(255, 204, 0), color(255, 140, 0), 1.0, true); // Draw the sun
  } else { // Moon is visible from 1 to 2
    float moonTime = celestialTime - 1; // Normalize to [0, 1]
    celestialBody(moonTime, color(255), color(200), 0.6, false); // Draw the moon
  }

  sea();
  boatsendiri();
  drawClouds();
  updateCloudPositions();
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
void scene4(){
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
  boatcloseupbaru();
}

void scene5(){
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
  boatcloseup2baru();
}

void scene6(){
// Create a gradient background for the sea
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(color(60, 110, 160), color(30, 80, 130), inter);
    stroke(c);
    line(0, y, width, y);
  }
  sea();
  boatbg();
  bucketfish();
}

void scene7(){
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
  boatcloseupsad();
}

void scene8(){
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
  boatcloseupdetermine();
}

void scene10(){
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
  boatcloseupturu();
}

void scene11(){
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
  boatcloseupkaget();
}

void scenepergi(){
   // Create a gradient background
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(color(173, 216, 230), color(135, 206, 250), inter);
    stroke(c);
    line(0, y, width, y);
  }
  sea();
  sun();
  boatpergi();
  drawClouds();
  updateCloudPositions();
}

void scene12(){
  // Create a gradient background for the sea
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(color(60, 110, 160), color(30, 80, 130), inter);
    stroke(c);
    line(0, y, width, y);
  }
  hiu();
  boatatas();
  fishrod();
  fishingman();
}

void boatpergi() {
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

  // Update the position of the second boat
  boat2XOffset += boat2Speed;

  // Draw the second floating boat
  float boat2X = 2 * width / 3 + boat2XOffset; // Adjust the second boat's starting X position with offset
  float boat2Y = map(noise(yoff2), 0, 1, skyHeight, height - 30); // Adjust Y position (lowered by 30 pixels)

  // Draw the fishing rod (pancing)
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X + -105.5, boat2Y -22); // Move to the boat's position and adjust for fishing rod placement
  scale(0.2);
  scale(-1, 1);
  pancing(); // Draw the fishing rod
  popMatrix(); // Restore the previous transformation matrix

  // Draw char2 on top of the boat
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X + -92, boat2Y - boatSize / 10); // Move to the boat's position, adjusted for size
  scale(0.159);
  char2();
  popMatrix(); // Restore the previous transformation matrix

  // Draw the bucketfish
  pushMatrix(); // Start a new transformation matrix
  translate(boat2X - 180, boat2Y - boatSize / 15); // Move to the middle of the canvas
  scale(0.1); // Scale down bucketfish
  bucketfish();
  popMatrix(); // Restore the previous transformation matrix

  image(boatImage2, boat2X, boat2Y, boatSize, boatSize); // Draw the second boat

  // Update yoff for the floating boats' motion
  yoff1 += 0.01;
  yoff2 += 0.01;
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

void bucketfish(){
  noStroke();
  beginShape();
  fill(153, 153, 153); 
  vertex(920,303);
  vertex(1176,303);
  vertex(1127,525);
  vertex(960,523);
  endShape();
  beginShape();
  fill(153, 153, 153); 
  ellipse(1043,522,167,45);
  endShape();
  beginShape();
  fill(0, 128, 128); 
  vertex(933,303);
  vertex(948,222);
  vertex(990,276);
  vertex(992,303);
  endShape();
  beginShape();
  fill(255, 230, 158); 
  vertex(992,303);
  vertex(1014,217);
  vertex(1047,273);
  vertex(1046,303);
  vertex(920,303);
  endShape();
  beginShape();
  fill(255, 179, 128); 
  vertex(1046,303);
  vertex(1047,274);
  vertex(1067,230);
  vertex(1088,202);
  vertex(1098,204);
  vertex(1103,223);
  vertex(1104,261);
  vertex(1091,303);
  endShape();
  beginShape();
  fill(233, 175, 175); 
  vertex(1081,303);
  vertex(1105,260);
  vertex(1129,232);
  vertex(1144,223);
  vertex(1149,227);
  vertex(1146,270);
  vertex(1128,303);
  endShape();
  beginShape();
  fill(0, 128, 0); 
  vertex(1121,303);
  vertex(1147,262);
  vertex(1169,243);
  vertex(1172,242);
  vertex(1177,247);
  vertex(1172,277);
  vertex(1161,303);
  endShape();
  beginShape();
  fill(255,255,255);
  ellipse(974,274,10,9);
  ellipse(1031,264,10,9);
  ellipse(1094,252,10,9);
  ellipse(1139,257,8,8);
  ellipse(1165,272,7,7);
  endShape();
  beginShape();
  fill(0,0,0);
  ellipse(974,274,5,5);
  ellipse(1031,264,5,5);
  ellipse(1094,252,5,5);
  ellipse(1139,257,4,4);
  ellipse(1165,272,3,3);
  endShape();
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

  stroke(0); // Black color for closed eyes
  strokeWeight(3); // Set the thickness for the closed eyes
  line(145, 165, 200, 165); // Left closed eye
  line(210, 165, 265, 165);
  
  // Draw the eyebrows
  stroke(0); // Black color for eyebrows
  strokeWeight(3); // Set the thickness for the eyebrows
  line(140, 150, 185, 145); // Left eyebrow
  line(265, 150, 220, 145); // Right eyebrow

  // Draw the mouth
  fill(255); // Black color for mouth
  stroke(0);
  strokeWeight(2);
  arc(195, 200, 40, 20, 0, PI, CHORD); // Smiling mouth
  //line(195, 205, 200, 210); // Left laugh line
  //line(225, 205, 220, 210); // Right laugh line
}

void char2baru() {
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
  
  // Draw the eyebrows
  stroke(0); // Black color for eyebrows
  strokeWeight(3); // Set the thickness for the eyebrows
  line(140, 145, 190, 150); // Left eyebrow moved to the left
  line(210, 150, 260, 145); // Right eyebrow moved to the left
  
  // Draw the mouth
  fill(255); // Black color for mouth
  stroke(0);
  strokeWeight(2);
  arc(210, 200, 40, 20, 0, PI, CHORD); // Smiling mouth
  //line(195, 205, 200, 210); // Left laugh line
  //line(225, 205, 220, 210); // Right laugh line
}

void char1sad() {
  scale(0.8); // Reduce the size of char1 to 80%
  fill(255, 0, 0); // Red color

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

  // Draw the closed eyes
  stroke(0); // Black color for closed eyes
  strokeWeight(3); // Set the thickness for the closed eyes
  line(145, 165, 200, 165); // Left closed eye
  line(210, 165, 265, 165); // Right closed eye
  
  // Draw the eyebrows
  stroke(0); // Black color for eyebrows
  strokeWeight(3); // Set the thickness for the eyebrows
  line(140, 150, 185, 145); // Left eyebrow
  line(220, 145, 265, 150); // Right eyebrow

  // Draw the sad mouth
  fill(0); // Black color for mouth
  stroke(0);
  strokeWeight(2);
  arc(195, 210, 40, 20, PI, TWO_PI, CHORD); // Sad mouth
}

void char1determine() {
  scale(0.8); // Reduce the size of char1 to 50%
  fill(255, 0, 0); // Red color

  // Draw the body
  noStroke();
  rect(100, 180, 160, 160, 0, 0, 55, 55);

  // Draw the head
  noStroke();
  ellipse(200, 175, 200, 160);

  // Draw hand
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

  // Draw the eyebrows
  stroke(0); // Black color for eyebrows
  strokeWeight(3); // Set the thickness for the eyebrows
  line(145, 135, 190, 150); // Left eyebrow (moved higher and angled downwards to show anger)
  line(220, 150, 265, 135); // Right eyebrow (moved higher and angled downwards to show anger)

  // Draw the mouth
  fill(0); // Black color for mouth
  rect(195, 195, 15, 2);
}

void boatbg(){
// Draw the first curved line
  beginShape();
  fill(249, 156, 86);
  vertex(-342,768);
  vertex(1280,762);
  vertex(1288,76);
  bezierVertex(468, 154, -64, 390, -342, 768);
  endShape();
  beginShape();
  fill(66, 101, 123);
  vertex(-234, 720);
  vertex(1280,762);
  vertex(1278, 122);
  bezierVertex(522, 178, 30, 388, -234, 720);
  endShape();
  beginShape();
  fill(41, 63, 76);
  vertex(300, 722);
  vertex(1280, 762);
  vertex(1280, 428);
  bezierVertex(789, 458, 474, 560, 300, 722);
  endShape();
}

void hiu(){
  beginShape();
  fill(255, 102, 0);
  vertex(399, 91);
  bezierVertex(271, 100, -30, 337, 258, 586);
  bezierVertex(216, 648, 266, 684, 291, 706);
  bezierVertex(303, 686, 305, 658, 289, 613);
  bezierVertex(317, 641, 353, 631, 382,627);
  bezierVertex(364, 602, 353, 574, 281, 570);
  bezierVertex(205, 369, 442, 305, 399, 91);
  endShape();
  
  beginShape();
  fill(0, 0, 0);
  ellipse(358, 204, 17, 17);
  endShape();
  
  beginShape();
  fill(255, 127, 42);
  vertex(190, 222);
  bezierVertex(148, 239, 115, 266, 94, 310);
  bezierVertex(111, 302, 116, 294, 153, 286);
  endShape();
  beginShape();
  fill(255, 127, 42);
  vertex(365, 276);
  bezierVertex(376, 341, 384, 354, 363, 386);
  bezierVertex(357, 384, 359, 351, 327, 337);
  endShape();
}

void boatatas(){
  beginShape();
  fill(66, 101, 123);
  vertex(918, 308);
  bezierVertex(936, 440, 888, 534, 729, 546);
  bezierVertex(694, 465, 757, 343, 918, 308);
  endShape();
  beginShape();
  fill(41, 63, 76);
  vertex(909, 334);
  bezierVertex(947, 470, 842, 536, 742, 544);
  bezierVertex(710, 473, 795, 342, 909, 334);
  endShape();
  beginShape();
  fill(66, 101, 123);
  vertex(729, 546);
  bezierVertex(781, 561, 801, 551, 811, 550);
  bezierVertex(929, 500, 929, 449, 929, 368);
  bezierVertex(926, 348, 922, 328, 918, 308);
  bezierVertex(932, 400, 909, 457, 872, 492);
  bezierVertex(827, 534, 761, 545, 729, 546);
  endShape();
  
  beginShape();
  fill(255, 232, 204);
  vertex(798, 400);
  vertex(863, 453);
  vertex(857, 488);
  vertex(789, 432);
  endShape(CLOSE);
  beginShape();
  fill(66, 101, 123);
  vertex(798, 400);
  vertex(866, 345);
  vertex(904, 368);
  vertex(863, 453);
  endShape(CLOSE);
  beginShape();
  fill(255, 232, 204);
  vertex(863, 453);
  vertex(857, 488);
  vertex(906, 394);
  vertex(904, 368);
  endShape(CLOSE);
}

void fishrod(){
  noFill();
  bezier(399, 91, 836, -73, 563, 282, 668, 342);
  beginShape();
  vertex(670, 341);
  vertex(668, 342);
  bezierVertex(705, 353, 721, 392,745, 446);
  vertex(746, 445);
  bezierVertex(713, 377, 705, 354, 670, 341);
  endShape();
  fill(153, 153, 153);
  ellipse(738, 442, 11, 11);
}

void fishingman(){
  fill(255, 0, 0);
  ellipse(779, 417, 57, 52);
  fill(255, 255, 255);
  ellipse(762, 413, 18, 14);
  ellipse(781, 412, 18, 14);
  fill(0, 0, 0);
  ellipse(759, 410, 7.147, 7.753);
  ellipse(779, 410, 7.147, 7.753);
  fill(170, 0, 0);
  ellipse(778, 430, 19, 12);
  
  beginShape();
  fill(255, 0, 0);
  vertex(759, 440);
  bezierVertex(747, 431, 730, 450, 755, 454);
  endShape(CLOSE);
  beginShape();
  vertex(803, 442);
  bezierVertex(826, 439, 822, 465, 803, 455);
  endShape(CLOSE);
  
  beginShape();
  fill(255, 0, 0);
  vertex(761, 437);
  bezierVertex(750, 461, 755, 472, 760, 478);
  bezierVertex(774, 492, 787, 486, 798, 481);
  bezierVertex(804, 475, 803, 449, 802, 433);
  bezierVertex(792, 443, 777, 447, 761, 437);
  endShape();
  
  beginShape();
  fill(255, 0, 0);
  vertex(760, 478);
  bezierVertex(745, 501, 781, 497, 777, 487);
  bezierVertex(770, 486, 765, 482, 760, 478);
  endShape();
  
  beginShape();
  fill(255, 0, 0);
  vertex(783, 487);
  bezierVertex(783, 498, 810, 500, 798, 480);
  bezierVertex(794, 483, 789, 485, 783, 487);
  endShape();
}
