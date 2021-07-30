float diff(PImage img, int x1, int y1, int x2, int y2) {
  int width = r.width;
   return sqrt(
    pow(red(img.pixels[y1*width + x1]) - red(img.pixels[y2*width + x2]), 2.0) +
    pow(green(img.pixels[y1*width + x1]) - green(img.pixels[y2*width + x2]), 2.0) +
    pow(blue(img.pixels[y1*width + x1]) - blue(img.pixels[y2*width + x2]), 2.0)
  );
  
}

PImage segment_image(PImage img, float sigma, float c, int min_size) {
  int width = img.width;
  int height = img.height;
  
  PImage blurred = img.copy();
  
  blurred.filter(BLUR, sigma);
  
  
  
  ArrayList<Edge> edges = new ArrayList<Edge>(); 
  int num = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if( x < width-1 ) {
        Edge edge = new Edge();
        edge.a = y * width + x;
        edge.b = y * width + (x +1);
        edge.w = diff(blurred,x,y,x+1,y);
        edges.add(edge);
        num++;
      }
      
      if(y < height - 1) {
        Edge edge = new Edge();
        edge.a = y * width + x;
        edge.b = (y+1) * width + x;
        edge.w = diff(blurred,x,y,x,y+1);
        edges.add(edge);
        num++;
      }
      
      if ((x < width-1) && (y < height-1)) {
        Edge edge = new Edge();
        edge.a = y * width + x;
        edge.b = (y+1) * width + (x+1);
        edge.w = diff(blurred, x, y, x+1, y+1);
        edges.add(edge);
        num++;
      }
      
      if ((x < width-1) && (y > 0)) {
        Edge edge = new Edge();
        edge.a = y * width + x;
        edge.b = (y-1) * width + (x+1);
        edge.w = diff(blurred, x, y, x+1, y-1);
        edges.add(edge);
        num++;
      }
      
    }
  }
  
  
  
  DisjointSet ds = segment_graph(width*height, num, edges, c);
  
  
  for (int i = 0; i< num; i++) {
    int a = ds.find(edges.get(i).a);
    int b = ds.find(edges.get(i).b);
    if ((a != b) && ((ds.size(a) < min_size) || (ds.size(b) < min_size))) {
      ds.join(a, b);
    }
      
  }
  
  int num_ccs = ds.num_sets();
  print("got %d components\n", num_ccs);
  
  color colors[] = new color[width*height];
  for (int i = 0; i < width*height; i++) {
    float rand = random(255);
    colors[i] = color(rand,rand, rand);
  }
    
  
  PImage output = createImage(width, height, RGB);
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int comp = ds.find(y * width + x);
      output.pixels[y * width + x] = colors[comp];
    }
  }  

  
  
  return output;
}
