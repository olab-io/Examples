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


import java.util.Vector;


Vector<Status> tweets = new Vector<Status>(); // Vector is thread-safe.

TwitterSimpleStream simpleStream;

long lastChange = Long.MIN_VALUE;
long displayInterval = 250;
Status currentTweet;
PImage currentTweetAvatar;

PFont fontHeader;
PFont fontCopy;

void setup() {
  size(400, 300);
  frameRate(30);
  background(0);

  ArrayList<String> queryTerms = new ArrayList<String>(); 
  
  queryTerms.add("secret");
  queryTerms.add("love");
  
  
  int searchPollInterval = 10 * 1000; // Search every 30 seconds.

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

  fontHeader = createFont("Sans-Serif", 14);
  fontCopy = createFont("Serif", 28);
}  

void draw() {
  background(0);
  fill(255);

  // Make sure we have some tweets to play with.
  if (tweets.size() > 0) 
  {
    long now = millis();

    // Decide if we should move to the next tweet.
    if (now > lastChange + displayInterval)
    {
      currentTweet = tweets.remove(0);

      String url = currentTweet.getUser().getProfileImageURL();

      currentTweetAvatar = requestImage(url);

      lastChange = now;
    }

    textFont(fontCopy);
    text(currentTweet.getText(), 85, 50, width - 170, height - 100);
    image(currentTweetAvatar, 30, 50);
  }
  
  textFont(fontHeader);
  text("Total Tweets: " + tweets.size(), 30, 30);
}

// Collections of new tweets arrive here and are added to the "tweets" vector
// The TwitterSearchApi delivers tweets here.
void newTweets(Vector<Status> newTweets) {
  for (Status tweet : newTweets)
  {
    // More about getting info out of a status message here
    // http://twitter4j.org/javadoc/twitter4j/Status.html
    tweets.add(tweet);
  }
}

