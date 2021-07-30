DisjointSet segment_pixel_graph(PImage img, float sigma, float c, int min_size) {
  
   int width = img.width;
  int height = img.height;
  
  PImage blurred = img.copy();
  blurred.filter(BLUR, sigma);
  
  ArrayList<Edge> edges = new ArrayList<Edge>(); 
  int num = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if( x < width-1 ) {
        edges.add(
        new Edge(
          y * width + x,
          y * width + (x +1),
          diff(blurred,x,y,x+1,y)
         )
        );
        
        
        num++;
      }
      
      if(y < height - 1) {
        edges.add(
        new Edge(
          y * width + x,
          (y+1) * width + x,
          diff(blurred,x,y,x,y+1)
         )
        );
        num++;
      }
      
      if ((x < width-1) && (y < height-1)) {
        edges.add(
         new Edge(
          y * width + x,
          (y+1) * width + (x+1),
          diff(blurred, x, y, x+1, y+1)
         )
        );
        num++;
      }
      
      if ((x < width-1) && (y > 0)) {
        edges.add(
        new Edge(
          y * width + x,
          (y-1) * width + (x+1),
           diff(blurred, x, y, x+1, y-1)
         )
        );
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
  print("got  components: ", num_ccs);
  
  return ds;
}
