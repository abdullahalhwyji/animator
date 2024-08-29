void setup(){
  size(600,400);
}

void draw(){
  char1merem();
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

  // Draw hand
  rect(230, 250, 60, 35, 0, 30, 30, 0); // Right hand
  
  // Draw the "feet" that merge into the body
  ellipse(145, 340, 50, 50); // Left foot
  ellipse(215, 340, 50, 50); // Right foot

  // Draw closed eyes
  fill(0); // White color for eyes
  ellipse(175, 175, 60, 1); // Left eye
  ellipse(240, 175, 60, 1); // Right eye

  // Draw the mouth
  fill(255); // Black color for mouth
  stroke(0);
  strokeWeight(2);
  arc(210, 200, 40, 20, 0, PI, CHORD);
}
