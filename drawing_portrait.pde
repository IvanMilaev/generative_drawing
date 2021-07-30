PImage img;
PImage r;
String imgFileName = "portrait";
String fileType = "jpg";
PImage seg;


int blackValue = -16000000;
int brightnessValue = 60;
int whiteValue = -13000000;


void setup() {
  img = loadImage(imgFileName + "." +fileType);
  size(1,1);
  surface.setResizable(true);
  surface.setSize(img.width, img.height);
  image(img, 0, 0, width, height);
  
 
  seg = segment_image(img, 3, 1.8, 50);
  
}

void draw() {
  
  image(seg, 0,0);
}
