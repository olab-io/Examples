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


// History-based smoothing using a moving average

float currentValue = 0;
float lastValue    = 0;

float currentAveragedValue = 0;
float lastAveragedValue = 0;

int xPosition = 0;

int[] history = new int[500]; // keep our history values

void setup() {
  size(800, 600);
  background(0);
  frameRate(30);

  // initialize the history array to all zeros
  for (int i = 0; i < history.length; i++) {
    history[i] = 0;
  }
}

void draw() {

  lastValue = currentValue; // set the last value current value;
  currentValue = mouseY; // current value to mouseY;  

  // draw a white line between current value and last value
  stroke(255);   
  line(xPosition, currentValue, xPosition-1, lastValue);


  // keep track of the last average
  lastAveragedValue = currentAveragedValue;
  // calculate a new average
  currentAveragedValue = historyAveragingFilter(mouseY);


  // draw a line connecting the current and last filtered positions
  stroke(0, 255, 0);   
  line(xPosition, currentAveragedValue, xPosition-1, lastAveragedValue);

  // move along the x axis
  xPosition++;

  // if the xPoistion goes off the screen, reset it and clear the screen
  if (xPosition > width) {
    xPosition = 0; 
    background(0);
  }
}

float historyAveragingFilter(int input) {
  // delete the oldest value from the history
  // add one value to the history (the input)
  // take the average of the history and return it;

  // shift the values to the left in the array
  for (int i = 0; i < history.length - 1; i++) {
    history[i] = history[i+1];
  } 

  history[history.length - 1] = input; // set last value to input

    // take the average of the entire array
  float sum = 0;
  for (int i = 0; i < history.length; i++) {
    sum += history[i];
  }
  float average = sum / history.length; // divide by the number of items

  return average;
}

