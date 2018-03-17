

//=========================================================================

//HOW TO ==================================================================
//space bar = refresh script
//r = record image frams
//s = save one image
//d = export dxf

//CHANGE HERE==============================================================
int extentX = 40;
int extentY = 40;
int extentZ = 50;
int maxCount= 200;
//=========================================================================

//=========================================================================
//Last modified by Soomeen Hahm on 8th July 2017
//=========================================================================









/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/23301*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
// Basic cell division / CA-like model in a body centered lattice
// Created by David Andreen



//Import libraries
import peasy.*;
import java.util.Calendar;

import processing.dxf.*;

//import processing.opengl.*;

// Create a camera from PeasyCam library
PeasyCam cam;

// Set distance Centre to Centre
float cc = 12;
float scaleFactor = cc/4 *0.9;

//set variables for counting number of times a cell has been turned on
int totCount = 1; 
int count;
int finalCount=0;
boolean counted = false;

PrintWriter output;
boolean isRecord = false;
boolean isRecordDXF = false;

//Initiate point lattice (as a 3D array)
Point  [][][] lattice = new Point  [extentX][extentY][extentZ];

void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, extentX*cc/2, extentY*cc/2, 0, 500);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
  smooth();

  //Create points in lattice (populate 3D array)
  for (int i=0; i<extentX; i++) {
    for (int j=0; j<extentY; j++) {
      for (int k=0; k<extentZ; k++) {
        lattice[i][j][k] = new Point (i, j, k);
      }
    }
  }
}

void draw() {
  if (isRecordDXF == true) {
    beginRaw(DXF, "output/" + timestamp() + "_output.dxf"); // Start recording to the file
  }

  background(255);

  //draw ground plane
  noStroke();
  noFill();
  strokeWeight(1);
  stroke(200);
  pushMatrix();
  rect(0, 0, extentX*cc, extentY*cc);
  popMatrix();

  //draw origo
  //stroke(255, 0, 0);
  //line (0, 0, 0, 20, 0, 0);
  //stroke(0, 255, 0);
  //line (0, 0, 0, 0, 20, 0);
  //stroke(0, 0, 255);
  //line (0, 0, 0, 0, 0, 20);

  //Cycle through all lattice points. If ON, count neighbours and potentially run grow function. 

  for (int i=1; i<extentX-1; i++) {
    for (int j=1; j<extentY-1; j++) {
      for (int k=2; k<extentZ-2; k++) {
        if (lattice[i][j][k].on == true && totCount<maxCount) 
        {
          neighbours(i, j, k);
          if (count < 3 && random(1)<0.5) {
            grow(i, j, k);
            totCount=totCount+1;
          } else if (count<4 && random(1)<0.06) {
            grow(i, j, k);
            totCount=totCount+1;
          }
          //          else if (count<5 && random(1)<0.0025 && lattice[i][j][k].on == true) {
          //            grow(i,j,k);
          //          }
          //          else if (count<8 && random(1)<0.001 && lattice[i][j][k].on == true) {
          //            grow(i,j,k);
          //          }
        }
      }
    }
  }

  //Draw lattice and octahedrons
  fill(255);
  for (int i=0; i<extentX; i++) {
    for (int j=0; j<extentY; j++) {
      for (int k=0; k<extentZ; k++) {
        lattice[i][j][k].display();
      }
    }
  }

  //if (blnPrintTail) exportAgentTail();

  if (isRecordDXF == true) {
    endRaw();
    isRecordDXF = false; // Stop recording to the file
  }

  if (isRecord) saveFrame (folderName + "image" + frameCount + ".png");
}

String folderName;


//boolean blnPrintTail= false;
void keyPressed() {
  if (key == 'x') {
    //blnPrintTail = !blnPrintTail;

    exportAgentTail();
    //println("hello");
  }

  if (key == 'r' ) {
    folderName= "output" + timestamp() + "/";
    isRecord = !isRecord;
  }

  if (key == 'd' ) {
    isRecordDXF = !isRecordDXF;
  }
  
  if (key == 's'){
    saveFrame ("output/" + timestamp() +"_CentralPts.jpg");
  }

  if (key == ' ') {
    totCount=0;
    //Create points in lattice (populate 3D array)
    for (int i=0; i<extentX; i++) {
      for (int j=0; j<extentY; j++) {
        for (int k=0; k<extentZ; k++) {
          lattice[i][j][k] = new Point (i, j, k);
        }
      }
    }
  }
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}



void exportAgentTail() {
  //if (blnPrintTail == true) {
  output = createWriter("output/" + timestamp() +"_CentralPts.txt");

  for (int i=0; i<extentX; i++) {
    for (int j=0; j<extentY; j++) {
      for (int k=0; k<extentZ; k++) {
        Point p= lattice[i][j][k];

        if (p.on) {
          String st= p.locX + "," + p.locY + "," + p.locZ ;      
          output.println(st);
          //output.println("hello");
        }
      }
    }
  }

  output.flush();
  output.close();

  println("central points have been exported");

  //blnPrintTail= false;
  //}
}