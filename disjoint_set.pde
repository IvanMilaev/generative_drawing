class UniElement {
  
  UniElement(int rank_, int p_, int size_){
    rank = rank_;
    p = p_;
    size = size_;
  }
  int rank;
  int p;
  int size;
}

class DisjointSet {
  UniElement[] elements;
  int num;
  
  DisjointSet(int elements_) {
    num = elements_;
    elements = new UniElement[elements_];
    
    for (int i = 0; i < elements_; i++ ) {
      elements[i] = new UniElement(0,i,1);
    }
    
  }
  
  int find(int x) {
    int y = x;
    while (y != elements[y].p)
      y = elements[y].p;
    elements[x].p = y;
    return y;
  }
  
  
  void join(int x, int y) {
    if(elements[x].rank > elements[y].rank) {
      elements[y].p = x;
      elements[x].size += elements[y].size;
    } else {
      elements[x].p = y;
      elements[y].size += elements[x].size;
      if(elements[x].rank == elements[y].rank) {
        elements[y].rank++;
      }
    }
    num--;
  }
  
  int num_sets() {return num;}
  int size(int x) {return elements[x].size;}
}
