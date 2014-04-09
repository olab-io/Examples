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


float value = 0;

void setup() {
  size(800, 600);
}

void draw() {
  background(0);
  // value = map(mouseY, 0, height, 0, 1) is the same as
  // value = norm(mouseY, 0, height)
  
  value = norm(mouseY, 0, height);
  float invertedValue = 1 - value;  // inverting from our maximum value
  
  // could also replace the above with:
  /* 
    
    value = map(mouseY, 0, height, 0, 1);
    float invertedValue = map(mouseY, 0, height, 1, 0);
  
  */

  // grayscale lerping (a single color)
  //float c0 = lerp(0, 255, value);
  //float c1 = lerp(0, 255, invertedValue);


  // color mapping requires us to pic different colors to map from and to
  color from0 = color(255, 0, 0, 255);
  color to0 = color(255, 255, 0, 0);
  
  color from1 = color(255, 255, 0, 255);
  color to1 = color(0, 255, 0, 0);

  // this is our interpolated color
  color color0 = lerpColor(from0,to0,value);
  color color1 = lerpColor(from1,to1,invertedValue);

  // set our fill colors
  fill(color0);
  
  // draw the left rect
  rect(0, 0, width / 2, height * value);
  fill(color1);
  
  // draw the right rect
  rect(width/2, 0, width/2, height * invertedValue);
}

