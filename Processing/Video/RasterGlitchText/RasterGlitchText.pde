import processing.video.*;
import java.io.UnsupportedEncodingException;

int numVideoPixels;
Capture video;

PFont font;

PGraphics pg;

ArrayList<Subtitle> subtitles = new ArrayList<Subtitle>();

int currentSubtitle = 0;

void setup() {
  size(640, 480); 

  video = new Capture(this, width, height);

  // Start capturing the images from the camera
  video.start();  

  font = createFont("Serif", 60);

  pg = createGraphics(width, 80);

  // Clear it out so we have some pixel.
  pg.beginDraw();
  background(0);
  pg.endDraw();

  String[] lines = loadStrings("got.srt");

  int subtitleLine = 0;

  Subtitle subtitle = null;

  for (int i = 0; i < lines.length; i++)
  {
    if (int(lines[i]) > 0)
    {
      if (subtitle != null) {
        subtitles.add(subtitle);
        println(subtitle);
      }

      subtitle = new Subtitle();
      subtitle.index = int(lines[i]);
      subtitle.times = lines[++i];
    }
    else if (lines[i].length() < 1)
    {
    }
    else if (subtitle != null)
    {
      subtitle.lines.add(lines[i]);
    }
  }
}

void draw() {
  background(0);  

  if (video.available()) 
  {
    video.read(); // Read a new video frame
    video.loadPixels(); // Make the pixels of video available

    int totalVideoPixels = video.width * video.height;
    int currentVideoPixelIndex = 0;


    // Render the "mask" text pixels to be filled.
    pg.beginDraw();
    pg.background(0);
    pg.fill(255); 
    pg.textFont(font);
    pg.text(subtitles.get(currentSubtitle).getLines(), 40, 60);
    pg.endDraw();

    pg.loadPixels();

    currentSubtitle = (currentSubtitle + 1) % subtitles.size();

    for (int i = 0; i < pg.width * pg.height; ++i) 
    {
      color pgColor = pg.pixels[i]; // The current color in the pg.      
      float b = brightness(pgColor); // 0 - 255

      if (b > 0)
      {
        color currentVideoPixel = video.pixels[currentVideoPixelIndex];

        int currR = (currentVideoPixel >> 16) & 0xFF;
        int currG = (currentVideoPixel >> 8) & 0xFF;
        int currB = currentVideoPixel & 0xFF;

        pg.pixels[i] = color(currR, currG, currB, b);

        currentVideoPixelIndex = (int)map(i, 0, pg.width * pg.height, 0, totalVideoPixels);

        //        currentVideoPixelIndex = (currentVideoPixelIndex + 1) % totalVideoPixels;
      }
      else 
      {
        pg.pixels[i] = color(255, 0);
      }
    }
    pg.updatePixels();
  }

  image(video, 0, 0);

  image(pg, 0, height - pg.height);
}

// When a key is pressed, capture the background image into the backgroundPixels
// buffer, by copying each of the current frame's pixels into it.
void keyPressed() {
  //  video.loadPixels();
  //  arraycopy(video.pixels, backgroundPixels);
}

