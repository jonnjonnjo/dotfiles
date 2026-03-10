struct SparseTable2D {
  vector<vector<vector<vector<int>>>> table;
  vector<int> log2;
  int n, m;

  int combine(int a, int b) { return min(a, b); }

  SparseTable2D(vector<vector<int>> &arr) {
    n = arr.size();
    m = arr[0].size();
    int maxLogR = __lg(n) + 1;
    int maxLogC = __lg(m) + 1;

    // Precompute logs
    int maxDim = max(n, m);
    log2.resize(maxDim + 1);
    log2[1] = 0;
    for (int i = 2; i <= maxDim; i++)
      log2[i] = log2[i / 2] + 1;

    table.assign(maxLogR, vector<vector<vector<int>>>(
                              maxLogC, vector<vector<int>>(n, vector<int>(m))));

    for (int r = 0; r < n; r++)
      for (int c = 0; c < m; c++)
        table[0][0][r][c] = arr[r][c];

    for (int kc = 1; kc < maxLogC; kc++)
      for (int r = 0; r < n; r++)
        for (int c = 0; c + (1 << kc) <= m; c++)
          table[0][kc][r][c] = combine(
              table[0][kc - 1][r][c], table[0][kc - 1][r][c + (1 << (kc - 1))]);

    for (int kr = 1; kr < maxLogR; kr++)
      for (int kc = 0; kc < maxLogC; kc++)
        for (int r = 0; r + (1 << kr) <= n; r++)
          for (int c = 0; c + (1 << kc) <= m; c++)
            table[kr][kc][r][c] =
                combine(table[kr - 1][kc][r][c],
                        table[kr - 1][kc][r + (1 << (kr - 1))][c]);
  }

  int query(int r1, int r2, int c1, int c2) {
    int kr = log2[r2 - r1 + 1];
    int kc = log2[c2 - c1 + 1];
    int rr = r2 - (1 << kr) + 1;
    int cc = c2 - (1 << kc) + 1;
    return combine(combine(table[kr][kc][r1][c1], table[kr][kc][r1][cc]),
                   combine(table[kr][kc][rr][c1], table[kr][kc][rr][cc]));
  }
};
