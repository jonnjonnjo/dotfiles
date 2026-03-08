struct MinQue {
  deque<pair<int, int>> q;
  int cntadded = 0, cntremoved = 0;

  int minimum() { return q.front().first; }

  void insert(int newelement) {
    while (!q.empty() && q.back().first > newelement) {
      q.pop_back();
    }
    q.push_back({newelement, cntadded});
    cntadded++;
  }

  void remove() {
    if (!q.empty() && q.front().second == cntremoved) {
      q.pop_front();
    }
    cntremoved++;
  }
};
