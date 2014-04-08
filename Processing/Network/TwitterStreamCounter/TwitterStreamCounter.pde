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


import java.util.concurrent.*;
import java.util.*;

ConcurrentHashMap<String, Integer> counts = new ConcurrentHashMap<String, Integer>();

TwitterSimpleStream simpleStream;

PFont font;

String[] terms = new String[] { 
  ":)", ":("
};

void setup() {
  size(400, 300);
  frameRate(30);
  background(0);

  ArrayList<String> queryTerms = new ArrayList<String>(); 

  for (String term : terms) 
  {
    queryTerms.add(term);
    counts.put(term, 0);
  }

  // To use, go to https://dev.twitter.com/ and register a new application.
  // Call it whatever you like.  Normally people might make an application 
  // for others to use, but this one is just for you.
  //
  // Make sure the application has read AND write settings.  Make sure your
  // tokens and keys also have read AND write settings.  If they don't,
  // regenerate them.

  String oAuthConsumerKey = "";
  String oAuthConsumerSecret = "";
  String oAuthAccessToken = "";
  String oAuthTokenSecret = "";

  simpleStream = new TwitterSimpleStream(this, queryTerms, oAuthConsumerKey, oAuthConsumerSecret, oAuthAccessToken, oAuthTokenSecret);

  font = createFont("Sans-Serif", 80);
  textFont(font);
}  

void draw() {
  background(0);
  fill(255);

  int x = 30;
  int y = 100;
  
  int totalCount = 0;
  for (Map.Entry count : counts.entrySet()) {
    totalCount += (Integer)count.getValue();
  }

  
  // Using an enhanced loop to interate over each entry
  for (Map.Entry count : counts.entrySet()) {
    int i =  (Integer)count.getValue();
    
    float level = (float) i / totalCount;
    
    text(count.getKey() + " = " + count.getValue(), x, y);
    
    fill(255,127);
    noStroke();
    rect(0, y, level * width, 80);
    
    y += 110;
  }
}

// Collections of new tweets arrive here and are added to the "tweets" vector
// The TwitterSearchApi delivers tweets here.
void newTweets(Vector<Status> newTweets) {
  for (Status tweet : newTweets)
  {
    ArrayList<String> queryTerms = new ArrayList<String>(); 
    
    for (String term : terms)
    {
        int termCount = countInstancesOf(term, tweet.getText());
        Integer count = counts.get(term);
        count += termCount;
        counts.put(term, count);
    }
  }
}


int countInstancesOf(String needle, String haystack)
{
  int lastIndex = 0;
  int count =0;

  while (lastIndex != -1) {

    lastIndex = haystack.indexOf(needle, lastIndex);

    if ( lastIndex != -1) {
      count ++;
      lastIndex+=needle.length();
    }
  }
  return count;
}

