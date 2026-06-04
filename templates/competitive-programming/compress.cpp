struct Compress {
  vector<int> vals;

  Compress() {}
  Compress(const vector<int> &v) { add(v); build(); }

  void add(int x) { vals.push_back(x); }
  void add(const vector<int> &v) {
    vals.insert(vals.end(), v.begin(), v.end());
  }

  void build() {
    sort(vals.begin(), vals.end());
    vals.erase(unique(vals.begin(), vals.end()), vals.end());
  }

  int idx(int x) {
    return lower_bound(vals.begin(), vals.end(), x) - vals.begin();
  }

  int orig(int i) { return vals[i]; }

  int size() { return vals.size(); }
};
