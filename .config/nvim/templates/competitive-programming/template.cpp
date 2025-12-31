#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>
using namespace __gnu_pbds;
using namespace std;
template<class T>
using Tree = tree<T, null_type, less<T>, rb_tree_tag, tree_order_statistics_node_update>;
// REFERENCE
// https://codeforces.com/blog/entry/11080
// from k a c tl
#define rep(i, a, b) for(int i = a; i < (b); ++i)
#define rep2(i,a,b) for(int i = a;i >=b;i--)
#define sz(x) (int)(x).size()
// Define Template          Python++
// Data Structure and Algorithm
#define all(vec)            (vec).begin(),(vec).end()
#define arrsize(arr)        sizeof(arr)/sizeof(int)
#define sortarr(arr)        sort(arr,arr+arrsize(arr));
#define sortvec(vec)        sort(all(vec));
#define minarr(arr)         *min_element(arr,arr+arrsize(arr))
#define minvec(vec)         *min_element(all(vec))
#define maxarr(arr)         *max_element(arr,arr+arrsize(arr))
#define maxvec(vec)         *max_element(all(vec))
#define sumarr(arr)         accumulate(arr,arr+arrsize(arr),0LL)
#define sumvec(vec)         accumulate(all(vec),0LL)
#define reversearr(arr)     reverse(arr,arr+arrsize(arr));
#define reversevec(vec)     reverse(all(vec));
#define fors(var,arr)       for(auto &var:arr)
// Input Output Manage
#define endl "\n"
#define debughere cout << "HERE\n";
#define test        cout<<"test"<<endl;
#define fastIO              ios_base::sync_with_stdio(0);cin.tie(0);cout.tie(0);
#define floatprecision      cout<<fixed<<setprecision(9);
#define query               cin>>QUERY;while(QUERY--)
#define inputarr(arr,am)    int arr[am];fors(num,arr)cin>>num;
#define inputvec(vec,am)    vector<int> vec(am);fors(num,vec)cin>>num;
#define input(var)          int var;cin>>var;
#define input2(a,b)         int a,b;cin>>a>>b;
#define inputs(var)         string var;cin>>var;
template<typename T>
void printRec(const T& t) {
    std::cout << t << "\n";
}
template<typename T, typename... Args>
void printRec(const T& t, const Args&... args) {
    std::cout << t << ' ';
    printRec(args...);
}
#define print(...) printRec(__VA_ARGS__);
#define printp(paired)      cout<<(paired.first)<<" "<<(paired.second)<<endl;
#define printyes(cond)      cout<<((cond)?"Yes":"No")<<endl;
#define printarr(arr)       fors(num,arr){cout<<num<<" ";};cout<<endl;
#define printmap(hashmap)   for(auto[x,y]:hashmap)cout<<x<<" : "<<y<<endl;
#define endline             cout<<endl;
// Macro
#define ll long long
#define pii pair<int,int>
#define vi vector<int>
#define vvi vector<vector<int>>
#define mii map<int,int>
#define pb push_back
#define lb lower_bound
#define ub upper_bound
#define pq priority_queue
#define mp make_pair
#define ms multiset
// Oneliner Function
ll sigma(ll num){return (num*(num+1))/2;}
ll gcd(ll a, ll b){return (a==0?b:gcd(b%a,a));}
ll lcm(ll a, ll b){return (a*b)/gcd(a,b);}
ll binpow(ll a,ll b,ll m=INT64_MAX){ll r=1;a%=m;while(b){if(b&1)r=(r*a)%m;a=(a*a)%m;b>>=1;}return r;}
ll invmod(ll a,ll m){return gcd(a,m)==1?binpow(a,m-2,m):0;}
ll modDivide(ll a,ll b,ll mod){a%=mod;ll inv=invmod(b,mod);return (inv*a)%mod;}
ll lsb(ll x){return log2(x&-x)+1;}
#define int long long
#define float long double
int QUERY;
// Constant
const int MOD1 = 1e9+7;
const int MOD2 = 998244353;
const long long INF = 1e18;
const int maxn = 2e5+5;
const float eps = 1e-9;
void open(){
    freopen("haybales.in", "r", stdin);
    freopen("haybales.out", "w", stdout);
}

void solve(){

}
int32_t main(){
    fastIO
    query
     solve();
    return 0;
}
 
