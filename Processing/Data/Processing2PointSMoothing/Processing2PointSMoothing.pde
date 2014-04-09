// =============================================================================
//
// Copyright (c) 2009-2014 Christopher Baker <http://christopherbaker.net>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// =============================================================================


float targetX = 0; // the destination x
float targetY = 0; // the destination y

float filteredX = 0; // filtered (smoothed) x
float filteredY = 0; // filtered (smoothed) y

float alpha = 0.10; // the smoothing factor (between 1 and 0)

void setup() {
  size(600, 600);
  smooth();
  background(0);
}

void draw() {
  background(0);

  // draw filtered (smoothed) point
  stroke(255, 255, 0, 255);
  fill(255, 255, 0, 127);
  ellipse(filteredX, filteredY, 200, 200);


  // draw the destination point
  stroke(255, 0, 0, 255);
  fill(255, 0, 0, 127);
  ellipse(targetX, targetY, 100, 100);

  // do the smoothing calculations
  filteredX =  alpha * targetX + (1-alpha) * filteredX;
  filteredY =  alpha * targetY + (1-alpha) * filteredY;
}

// set a new target
void mousePressed() {
  targetX = mouseX;
  targetY = mouseY;
}

