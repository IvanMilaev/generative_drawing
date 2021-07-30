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


void setup() {
  img = loadImage(imgFileName + "." +fileType);
  size(1,1);
  surface.setResizable(true);
  surface.setSize(img.width, img.height);
  image(img, 0, 0, width, height);
  
 
  //seg = segment_image(img, 0.6, 3, 200);
  DisjointSet ds = segment_pixel_graph(img, 0.6, 3, 200);
  
  
  
  HashMap<Integer,ArrayList<Integer>> sets = new HashMap<Integer,ArrayList<Integer>>();
  
  for (int i = 0; i < img.width*img.height; i++) {
    int setKey = ds.find(i);
    if(!sets.containsKey(setKey)) {
      sets.put(setKey, new ArrayList<Integer>());
    } 
    sets.get(setKey).add(i);
  }
  
  Set<Integer> keys = sets.keySet();
  Integer[] array_keys = keys.toArray(new Integer[keys.size()]);
  ArrayList<Integer> arr_keys = new ArrayList<Integer>();
  
  for (int i = 0; i< array_keys.length; i++) {
    arr_keys.add(array_keys[i]);
  }
  
  int num_sets = ds.num_sets();
  
  color colors[] = new color[num_sets];
  
  for(int i = 0; i < num_sets; i ++) {
    colors[i] = img.pixels[sets.get(arr_keys.get(i)).get(0)];
  }
  
  output = createImage(width, height, RGB);
  
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int comp = ds.find(y * width + x);
      output.pixels[y * width + x] = colors[arr_keys.indexOf(comp)];
    }
  } 
  
  
}

void draw() {
  
  image(output, 0,0);
}
