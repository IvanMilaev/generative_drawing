import java.util.Collections;

float thr(float size, float c){
    return c/size;
}

class Edge implements Comparable<Edge> {
  Float w;
  int a, b;
  
  int compareTo(Edge edge) {
    return this.w.compareTo(edge.w);
  }
}


DisjointSet segment_graph(int num_vertices, int num_edges, ArrayList<Edge> edges, float c) {
  
  Collections.sort(edges);
  println(num_vertices,num_edges );
  println("we here 2");
  
  DisjointSet ds = new DisjointSet(num_vertices);
  println(ds);
  println(ds.find(edges.get(100).a));
  float threshold[] = new float[num_vertices];
  
  for (int i = 0; i < num_vertices; i++) {
    threshold[i] = thr(1,c);
  }
  
  for (int i = 0; i < num_edges; i++) {
    Edge pedge = edges.get(i);
    
    int a = ds.find(pedge.a);
    int b = ds.find(pedge.b);
    if( a != b) {
      if((pedge.w <= threshold[a]) && (pedge.w <= threshold[a])) {
        ds.join(a,b);
        a = ds.find(a);
        threshold[a] = pedge.w + thr(ds.size(a), c);
      }
    }
  }
  
  println("Ds create done");
  
  return ds;
  
}
