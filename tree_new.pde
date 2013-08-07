<<<<<<< HEAD
final float rootX=500,rootY=800;
final float length0=200;
=======
/***********************************
@auther:HeYSH(yeshuanghe at gmail)
@lisence:GPLv3
***********************************/

final float rootX=300,rootY=900;
final float length0=300;
>>>>>>> origin/vanilla
final float weight0=20;
final float anRange=PI/3;
final float bRange=PI/3;
final int numOfLoop=5;
<<<<<<< HEAD
final int budsPerBranchL=5;
final int budsPerBranchH=8;
final float reduceL=0.6;
final float reduceH=0.8;
=======
final int budsPerBranchL=7;
final int budsPerBranchH=10;
final float reduceL=0.6;
final float reduceH=0.8;
final float rLeaf=35;
final float alphaLeaf=15;
>>>>>>> origin/vanilla
void setup() {
  size(1000, 1000);
  colorMode(RGB, 255);
  background(192);
  smooth();
  Tree tree = new Tree();
  tree.grow(rootX,rootY,0,length0,weight0,0,PI/2);
//  for(int q=0;q<99;q++)
//  {
//    tree.buildLeaf(rootX,rootY,0,length0,weight0,PI/6,PI/2);
//  }
}
<<<<<<< HEAD
 
void draw() {
  
=======

void draw() {

>>>>>>> origin/vanilla
}
class Tree{
  Tree(){
  }
  void grow(float X,float Y,int i,float l,float w,float a0,float b0){
     //float alpha=random(-anRange,anRange)+a0;
     int j=int(random(budsPerBranchL,budsPerBranchH));
     float X1=X-l*sin(a0)*sin(b0);
     float Y1=Y-l*cos(a0)*sin(b0);
     strokeWeight(w);
     stroke(0,0,0,255-50*i);
     strokeCap(PROJECT);
     line(X, Y, X1, Y1);
<<<<<<< HEAD
     buildLeaf(X,Y,i,l,w,a0,b0);
     if (i<numOfLoop){
       for(int k=0;k<j;k++){
        grow(X1,Y1,i+1,l*random(reduceL,reduceH),w*random(reduceL-0.2,reduceH-0.2),random(-anRange,anRange)+a0,random(-bRange,bRange)+b0);
=======
     if(i>0)
     {
       buildLeaf(X,Y,i,l,w,a0,b0);
       buildLeaf(X,Y,i,l,w,a0,b0);
       buildLeaf(X,Y,i,l,w,a0,b0);
     }
     if (i<numOfLoop){
       for(int k=0;k<j;k++){
        grow(X1,Y1,i+1,l*random(reduceL,reduceH),w*random(reduceL-0.2,reduceH-0.2),
            random(-anRange,anRange)+a0,random(-bRange,bRange)+b0);
>>>>>>> origin/vanilla
       }
     }
  }
  void buildLeaf(float X,float Y,int i,float l,float w,float a0,float b0){
<<<<<<< HEAD
  float m=random(0,l*sin(b0));
  float n=random(0,5*w);
  Y1=Y-(m*cos(a0)+n*sin(a0));
  X1=X-(m*sin(a0)-n*cos(a0));
  //ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
  noStroke();
  fill(255,255,255,100);  // Set fill to white
  ellipse(X1, Y1, 30, 30);  // Draw white ellipse using RADIUS mode
  }
}
=======
      float m=random(0,l*sin(b0));
      float n=random(0,30-3*i);
      float Y1=Y-(m*cos(a0)+n*sin(a0));
      float X1=X-(m*sin(a0)-n*cos(a0));
      //ellipseMode(RADIUS);
      noStroke();
      fill(150.1,0,1,alphaLeaf);
      ellipse(X1, Y1, rLeaf-3*i, rLeaf-3*i);
  }
}

>>>>>>> origin/vanilla
