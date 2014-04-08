class Subtitle
{
  public int index = 0;
  String times = ""; // convert this to milliseconds, not a string.
  ArrayList<String> lines = new ArrayList<String>();

  public String getLines()
  {
      String result = "";
      for (String line : lines)
      {
         result += line + " "; 
      }
      
      return result;
  }

  public String toString()
  {
      String result;
      result = index + " " + times + " " + getLines();
      
      return result;
  }
}

