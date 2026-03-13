struct Dijkstra {
  int n, src;
  const int INF = 1e9;
  vector<vector<pair<int, int>>> adj;
  vector<int> dist_, prev_;

  Dijkstra(vector<vector<int>> &g, int src)
      : n(g.size() - 1), src(src), adj(g.size()) {
    for (int u = 0; u < (int)g.size(); u++)
      for (int v : g[u])
        adj[u].push_back({1, v});
    run();
  }

  Dijkstra(vector<vector<pair<int, int>>> &g, int src)
      : n(g.size() - 1), src(src), adj(g.size()) {
    for (int u = 0; u < (int)g.size(); u++)
      for (auto [v, w] : g[u])
        adj[u].push_back({w, v});
    run();
  }

  void run() {
    dist_.assign(n + 1, INF);
    prev_.assign(n + 1, -1);
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;

    dist_[src] = 0;
    pq.push({0, src});

    while (!pq.empty()) {
      auto [d, u] = pq.top();
      pq.pop();
      if (d > dist_[u])
        continue;

      for (auto [w, v] : adj[u]) {
        if (dist_[u] + w < dist_[v]) {
          dist_[v] = dist_[u] + w;
          prev_[v] = u;
          pq.push({dist_[v], v});
        }
      }
    }
  }

  int getDist(int t) { return dist_[t]; }
  bool reachable(int t) { return dist_[t] != INF; }
  vector<int> getDists() { return dist_; }

  vector<int> getPath(int t) {
    if (dist_[t] == INF)
      return {};
    vector<int> path;
    for (int cur = t; cur != -1; cur = prev_[cur])
      path.push_back(cur);
    reverse(path.begin(), path.end());
    return path;
  }
};
