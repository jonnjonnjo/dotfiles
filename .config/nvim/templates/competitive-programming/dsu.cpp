struct DSU {
  vector<int> parent, size;

  DSU(int n) {
    n = n + 1;
    parent.resize(n);
    size.resize(n, 1); // every node starts with size 1
    iota(parent.begin(), parent.end(), 0);
  }

  int find(int x) {
    if (parent[x] != x)
      parent[x] = find(parent[x]);
    return parent[x];
  }

  void unite(int x, int y) {
    int rx = find(x), ry = find(y);
    if (rx == ry)
      return;

    // attach smaller tree under larger
    if (size[rx] < size[ry])
      swap(rx, ry);
    parent[ry] = rx;
    size[rx] += size[ry]; // update size
  }

  bool connected(int x, int y) { return find(x) == find(y); }

  int getSize(int x) {
    return size[find(x)]; // bonus: size of x's component
  }
};
