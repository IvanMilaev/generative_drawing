import java.util.Collections;
import java.util.Map;
import java.util.Set;

PImage img;
PImage r;
String imgFileName = "portrait";
String fileType = "jpg";
PImage seg;

PImage output;


int blackValue = -16000000;
int brightnessValue = 60;
int whiteValue = -13000000;

color colors[];
HashMap<Integer,ArrayList<Integer>> pixel_sets;
ArrayList<Integer> pixel_sets_keys;
Particle particles[]; 
Particle[][] particle_sets;

void setup() {
  img = loadImage(imgFileName + "." +fileType);
  size(1,1);
  surface.setResizable(true);
  surface.setSize(img.width, img.height);
  image(img, 0, 0, width, height);
  
 
  //seg = segment_image(img, 0.6, 3, 200);
  DisjointSet ds = segment_pixel_graph(img,0.7, 2, 120);
  
  
  
   pixel_sets = new HashMap<Integer,ArrayList<Integer>>();
  
  for (int i = 0; i < img.width*img.height; i++) {
    int setKey = ds.find(i);
    if(!pixel_sets.containsKey(setKey)) {
      pixel_sets.put(setKey, new ArrayList<Integer>());
    } 
    pixel_sets.get(setKey).add(i);
  }
  
  Set<Integer> keys = pixel_sets.keySet();
  Integer[] array_keys = keys.toArray(new Integer[keys.size()]);
  pixel_sets_keys = new ArrayList<Integer>();
  
  for (int i = 0; i< array_keys.length; i++) {
    pixel_sets_keys.add(array_keys[i]);
  }
  
  int num_sets = ds.num_sets();
  
  colors = new color[num_sets];
  
  for(int i = 0; i < num_sets; i ++) {
    colors[i] = img.pixels[pixel_sets.get(pixel_sets_keys.get(i)).get(0)];
  }
  
  output = createImage(width, height, RGB);
  
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int comp = ds.find(y * img.width + x);
      output.pixels[y * img.width + x] = colors[pixel_sets_keys.indexOf(comp)];
    }
  } 
  
  
  
  particle_sets = new Particle[num_sets][];
  
  for (int i=0; i < num_sets; i++) {
     ArrayList<Integer> pxl_set = pixel_sets.get(pixel_sets_keys.get(i));
     int count_pixels = pxl_set.size();
     int num_particles = int(count_pixels/2);
     particle_sets[i] = new Particle[num_particles];
     for (int j = 0; j < num_particles; j++) {
       int rand_pixel = pxl_set.get(int(random(count_pixels)));
       int y = rand_pixel/img.width;
       int x = rand_pixel%img.width;
       particle_sets[i][j] = new Particle(x,y,PI/4);
     }
     
  }
 
  
  
  for(int i =0; i < num_particles; i++) {
     int rand_pixel = pxl_set.get(int(random(pxl_set.size())));
     int y = rand_pixel/img.width;
     int x = rand_pixel%img.width;
     particles[i] = new Particle(x,y,PI/4);
  }
 
   
  
  //for (int y = 0; y < height; y++) {
  //  for (int x = 0; x < width; x++) {
  //    if(pxl_set.contains(y * width + x)) {
        
  //    }
  //  }
  //} 
  noStroke();
  noLoop();
}

void draw() {
  
  
  for (int i=0; i< 10; i++) {
    for(int j=0; j < particles.length; j++) {
      particles[j].update();
      particles[j].display();
    }
    
   }
  
  //image(output, 0,0);
}
