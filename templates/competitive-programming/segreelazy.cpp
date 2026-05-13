struct SegTreeLazy {
  vector<long long> tree, lazy;
  int n;
  long long combine(long long a, long long b) { return (a + b); }
  long long identity() { return 0; }
  SegTreeLazy(vector<long long> &arr) {
    n = arr.size();
    tree.assign(4 * n, identity());
    lazy.assign(4 * n, 0);
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
  void pushDown(int node, int l, int r) {
    if (lazy[node] == 0)
      return;
    int mid = (l + r) / 2;
    applyLazy(2 * node, l, mid, lazy[node]);
    applyLazy(2 * node + 1, mid + 1, r, lazy[node]);
    lazy[node] = 0;
  }
  void applyLazy(int node, int l, int r, long long val) {
    tree[node] += val * (r - l + 1); // range add; adjust for other ops
    lazy[node] += val;
  }
  void update(int node, int l, int r, int ql, int qr, long long val) {
    if (qr < l || r < ql)
      return;
    if (ql <= l && r <= qr) {
      applyLazy(node, l, r, val);
      return;
    }
    pushDown(node, l, r);
    int mid = (l + r) / 2;
    update(2 * node, l, mid, ql, qr, val);
    update(2 * node + 1, mid + 1, r, ql, qr, val);
    tree[node] = combine(tree[2 * node], tree[2 * node + 1]);
  }
  long long queryResult(int node, int l, int r, int ql, int qr) {
    if (qr < l || r < ql)
      return identity();
    if (ql <= l && r <= qr)
      return tree[node];
    pushDown(node, l, r);
    int mid = (l + r) / 2;
    return combine(queryResult(2 * node, l, mid, ql, qr),
                   queryResult(2 * node + 1, mid + 1, r, ql, qr));
  }
  void update(int l, int r, long long val) { update(1, 0, n - 1, l, r, val); }
  long long queryResult(int l, int r) { return queryResult(1, 0, n - 1, l, r); }
};
