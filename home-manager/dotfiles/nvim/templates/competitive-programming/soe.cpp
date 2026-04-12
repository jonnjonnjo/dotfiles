struct PrimeFactorizer {
  vector<int> spf;

  PrimeFactorizer(int n) {
    spf.resize(n + 1);
    iota(spf.begin(), spf.end(), 0);
    for (int i = 2; i * i <= n; i++)
      if (spf[i] == i)
        for (int j = i * i; j <= n; j += i)
          if (spf[j] == j)
            spf[j] = i;
  }

  map<int, int> factorize(int n) {
    map<int, int> factors;
    while (n > 1) {
      int p = spf[n];
      while (n % p == 0) {
        factors[p]++;
        n /= p;
      }
    }
    return factors;
  }

  bool isPrime(int n) { return spf[n] == n; }
};
