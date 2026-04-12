struct SegTree {
  vector<long long> tree;
  int n;
  long long combine(long long a, long long b) { return (a + b); }
  long long identity() { return 0; }
  SegTree(vector<long long> &arr) {
    n = arr.size();
    tree.assign(4 * n, identity());
    build(arr, 1, 0, n - 1);
  }
  void build(vector<long long> &arr, int node, int l, int r) {
    if (l == r) {
      tree[node] = arr[l];
      return;
    }
    int mid = (l + r) / 2;
    build(arr, 2 * node, l, mid);
    build(arr, 2 * node + 1, mid + 1, r);
    tree[node] = combine(tree[2 * node], tree[2 * node + 1]);
  }
  void update(int node, int l, int r, int idx, long long val) {
    if (l == r) {
      tree[node] = val;
      return;
    }
    int mid = (l + r) / 2;
    if (idx <= mid)
      update(2 * node, l, mid, idx, val);
    else
      update(2 * node + 1, mid + 1, r, idx, val);
    tree[node] = combine(tree[2 * node], tree[2 * node + 1]);
  }
  long long queryResult(int node, int l, int r, int ql, int qr) {
    if (qr < l || r < ql)
      return identity();
    if (ql <= l && r <= qr)
      return tree[node];
    int mid = (l + r) / 2;
    return combine(queryResult(2 * node, l, mid, ql, qr),
                   queryResult(2 * node + 1, mid + 1, r, ql, qr));
  }

  void update(int idx, long long val) { update(1, 0, n - 1, idx, val); }
  long long queryResult(int l, int r) { return queryResult(1, 0, n - 1, l, r); }
};
