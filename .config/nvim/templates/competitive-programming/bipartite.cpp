
struct BipartiteChecker {
  // 0-index graph
  int n;
  vector<vector<int>> adj;
  vector<int> color_;

  struct ComponentResult {
    bool isBipartite;
    int countA;
    int countB;
  };

  vector<ComponentResult> results;

  BipartiteChecker(vector<vector<int>> &g)
      : n(g.size()), adj(g), color_(g.size(), -1) {
    for (int i = 0; i < n; i++)
      if (color_[i] == -1)
        results.push_back(checkComponent(i));
  }

  ComponentResult checkComponent(int start) {
    ComponentResult res = {true, 0, 0};
    queue<int> q;
    color_[start] = 0;
    q.push(start);
    while (!q.empty()) {
      int u = q.front();
      q.pop();
      (color_[u] == 0 ? res.countA : res.countB)++;
      for (int v : adj[u]) {
        if (color_[v] == -1) {
          color_[v] = 1 - color_[u];
          q.push(v);
        } else if (color_[v] == color_[u]) {
          res.isBipartite = false;
        }
      }
    }
    return res;
  }

  int componentCount() const { return results.size(); }
  bool isBipartite(int comp) const { return results[comp].isBipartite; }
  bool allBipartite() const {
    for (auto &r : results)
      if (!r.isBipartite)
        return false;
    return true;
  }
  pair<int, int> colorCounts(int comp) const {
    if (!results[comp].isBipartite)
      return {-1, -1};
    return {results[comp].countA, results[comp].countB};
  }
  int getColor(int v) const { return color_[v]; }
};
