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


const int ledPin0 = 9;    // PWM
const int ledPin1 = 10;   // PDM
const int potPin = A0;

float filteredPotInput = 0; // filtered value
float alpha = 0.01; 

int pot = 0; // the potentiometer (or target value)

void setup()  { 
  // nothing happens in setup
}

void loop()  { 
  pot = analogRead(potPin); // read analog input 0-1023
  
  // do the filtering
  filteredPotInput = alpha * pot  + (1 - alpha) * filteredPotInput;
  
  // mape the filtered data to to values
  int ledMap0 = map(filteredPotInput,0,512,0,255);
  int ledMap1 = map(filteredPotInput,0,512,255,0);
  
  // write those inverted values to LEDs
  analogWrite(ledPin0,ledMap0);
  analogWrite(ledPin1,ledMap1);
  
  delay(5);
}


