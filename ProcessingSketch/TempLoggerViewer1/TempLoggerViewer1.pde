String[] lines;

int index = 0;

float linesWidth = 600;
int sWidth = 600;
float xScale = 0.3;
boolean loading = false;
boolean fileLoaded = false;
boolean plotted = false;
String plotterFilepath;

void setup() {
  size(600,400);
  background(0);
  stroke(255);
  //frameRate(12);
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    plotterFilepath = selection.getAbsolutePath();
    println("User selected " + plotterFilepath);
    fileLoaded = true;
    loading = false;
  }
}

void printInfo(int input) {
  index = input;
  String[] pieces = split(lines[index],',');
  
  float temp = -1.0;
  float humidity = -1.0;
  
  if(pieces.length > 1) {
    for(int i = 0; i < pieces.length; i++) {
     // int i = input;
      println("index " + i + " is " + pieces[i] + " ");
      String[] pieces2 = split(pieces[i],'°');
      if(pieces2.length == 2) {
        println("temp is " + pieces2[0]);
        temp = float(pieces2[0]);
      }
      
      String[] humidityString = split(pieces[i],"y: ");
      if(humidityString.length == 2) {
        println("humidity is " + humidityString[1]);
        humidity = float(humidityString[1]);
      } 
    }

  print('\n');

  }
}

void plotGraph() {
  while(index < lines.length) {
    String[] pieces = split(lines[index],',');
    
    float temp = -1.0;
    float humidity = -1.0;
    
    if(pieces.length > 1) {
      for(int i = 0; i < pieces.length; i++) {
      //  print("index " + i + " is " + pieces[i] + " ");
        
        String[] pieces2 = split(pieces[i],'°');
        if(pieces2.length == 2) {
       //   println("temp is " + pieces2[0]);
          temp = float(pieces2[0]);
        }
        
        String[] humidityString = split(pieces[i],"y: ");
        if(humidityString.length == 2) {
        //  println("humidity is " + humidityString[1]);
          humidity = float(humidityString[1]);
        } 
      }
      //float xScale = 0.3;
      float yScale = 2.0;
      if(temp != -1.0 || humidity != -1.0) {
        stroke(255, 0, 0);
        point(xScale*(index+100),height-(yScale*temp));
        stroke(0,255,0);
        point(xScale*(index+100),height-(yScale*humidity));
      }
     // print('\n');
    }
  // go to the next line for next loop
  index += 1;

  }
  plotted = true;
}

void mousePressed() {
  int pointX = int(mouseX/xScale);
  printInfo(pointX);
}

void draw() {
  // plot the file's contents if it is loaded but not yet plotted
  if(fileLoaded) {
    if(!plotted) {
      lines = loadStrings(plotterFilepath);
      linesWidth = lines.length;
      xScale = sWidth/linesWidth;
      print(xScale);
      plotGraph();
    }
  } else {
    // then load a file
    if (!loading) {
      loading = true;
      selectInput("Select a file to process:", "fileSelected");
    }
  }
}
