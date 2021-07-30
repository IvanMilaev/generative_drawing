

float thr(float size, float c){
    return c/size;
}

class Edge implements Comparable<Edge> {
  Float w;
  int a, b;
  
  Edge(int a_, int b_, Float w_){
    a = a_;
    b=b_;
    w=w_;
  }
  
  int compareTo(Edge edge) {
    return this.w.compareTo(edge.w);
  }
}

DisjointSet segment_graph(int num_vertices, int num_edges, ArrayList<Edge> edges, float c) {
  
  Collections.sort(edges);
  //for (int i= 0; i < num_edges; i++) {
  //  print(edges.get(i).w, " | ");
  //}
  
  
  DisjointSet ds = new DisjointSet(num_vertices);
  
  
  float threshold[] = new float[num_vertices];
  
  for (int i = 0; i < num_vertices; i++) {
    threshold[i] = thr(1,c);
  }
  
  for (int i = 0; i < num_edges; i++) {
    Edge pedge = edges.get(i);
    
    int a = ds.find(pedge.a);
    int b = ds.find(pedge.b);
    if( a != b) {
      if((pedge.w <= threshold[a]) && (pedge.w <= threshold[b])) {
        ds.join(a,b);
        a = ds.find(a);
        threshold[a] = pedge.w + thr(ds.size(a), c);
      }
    }
    
  }
  
  
  
  return ds;
  
}
