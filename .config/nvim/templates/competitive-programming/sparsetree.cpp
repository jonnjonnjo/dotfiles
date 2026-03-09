struct SparseTable {
  vector<vector<int>> table;
  vector<int> log2;
  int n;

  int combine(int a, int b) { return min(a, b); }

  SparseTable(vector<int> &arr) {
    n = arr.size();
    int maxLog = __lg(n) + 1;

    table.assign(maxLog, vector<int>(n));
    log2.resize(n + 1);

    log2[1] = 0;
    for (int i = 2; i <= n; i++)
      log2[i] = log2[i / 2] + 1;

    table[0] = arr;
    for (int j = 1; j < maxLog; j++)
      for (int i = 0; i + (1 << j) <= n; i++)
        table[j][i] =
            combine(table[j - 1][i], table[j - 1][i + (1 << (j - 1))]);
  }

  int queryResult(int l, int r) {
    int k = log2[r - l + 1];
    return combine(table[k][l], table[k][r - (1 << k) + 1]);
  }
};
