-- Advanced Graph Problems - 15 Problems (Pattern Not Obvious)

USE faang;

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags) VALUES

('ALGO', 'GOOGLE', 'GRAPHS', 'Word Transformation Ladder', '# Word Transformation Ladder

Given two words (start and end) and a dictionary, find the shortest transformation sequence where:
- Only one letter changes at a time
- Each transformed word must exist in the dictionary

**Example:**
```
Input: start = "hit", end = "cog", dict = ["hot","dot","dog","lot","log","cog"]
Output: 5
Explanation: "hit" → "hot" → "dot" → "dog" → "cog"

Input: start = "hit", end = "cog", dict = ["hot","dot","dog","lot","log"]
Output: 0 (impossible)
```', 'Hint 1: This is a graph problem - words are nodes, edges exist if one char differs.
---
Hint 2: BFS to find shortest path.
---
Hint 3: Generate neighbors by changing each character.', '## Solution: BFS on Implicit Graph

Build graph where words are nodes:
- Edge exists if words differ by one character
- Use BFS from start to end
- Track visited to avoid cycles

Time: O(n * m^2) where n=words, m=word length, Space: O(n)', 'HARD', 'graph,bfs,string,shortest-path'),

('ALGO', 'META', 'GRAPHS', 'Friend Groups in Social Network', '# Friend Groups in Social Network

Given n people and array of friend pairs, count the number of friend groups (connected components). If A is friends with B, and B is friends with C, then A-B-C form one group.

**Example:**
```
Input: n = 5, friendships = [[0,1], [1,2], [3,4]]
Output: 2
Explanation: Group 1: {0,1,2}, Group 2: {3,4}

Input: n = 5, friendships = [[0,1], [2,3]]
Output: 3
Explanation: {0,1}, {2,3}, {4}
```', 'Hint 1: Each friend group is a connected component.
---
Hint 2: Use Union-Find or DFS to find components.
---
Hint 3: Count number of disjoint sets.', '## Solution: Union-Find

Use Union-Find to group friends:
- Union friends together
- Count distinct parent nodes

Or use DFS/BFS to find connected components.

Time: O(n + e*α(n)), Space: O(n)', 'MEDIUM', 'graph,union-find,dfs,connected-components'),

('ALGO', 'AMAZON', 'GRAPHS', 'Course Schedule Validator', '# Course Schedule Validator

Given n courses and prerequisites array where prerequisites[i] = [a, b] means you must take course b before course a. Determine if you can finish all courses.

**Example:**
```
Input: n = 2, prerequisites = [[1,0]]
Output: true
Explanation: Take course 0, then course 1

Input: n = 2, prerequisites = [[1,0], [0,1]]
Output: false
Explanation: Circular dependency
```', 'Hint 1: This is a cycle detection problem.
---
Hint 2: Build directed graph from prerequisites.
---
Hint 3: Use DFS or topological sort to detect cycles.', '## Solution: Cycle Detection (DFS)

Build directed graph, use DFS to detect cycles:
- White (unvisited), Gray (visiting), Black (visited)
- If we reach a gray node, cycle exists
- Or use Kahn''s algorithm (topological sort)

Time: O(V + E), Space: O(V + E)', 'MEDIUM', 'graph,dfs,topological-sort,cycle-detection'),

('ALGO', 'GOOGLE', 'GRAPHS', 'Clone Connected Data Structure', '# Clone Connected Data Structure

Given a reference to a node in a connected undirected graph, return a deep copy of the graph. Each node contains a value and a list of neighbors.

**Example:**
```
Input: node with value 1, neighbors [2,4], node 2 neighbors [1,3], etc.
Output: Deep copy of entire graph structure
```', 'Hint 1: Need to track visited nodes to avoid infinite loops.
---
Hint 2: Use HashMap to map original nodes to cloned nodes.
---
Hint 3: DFS or BFS to traverse and clone.', '## Solution: DFS/BFS with HashMap

Use HashMap<Original, Clone>:
- For each node, create clone
- Recursively clone all neighbors
- Use map to handle cycles

Time: O(V + E), Space: O(V)', 'MEDIUM', 'graph,dfs,bfs,hash-table,clone'),

('ALGO', 'META', 'GRAPHS', 'Network Delay Time', '# Network Delay Time

Given n network nodes (1 to n), times array where times[i] = [source, target, time], and starting node k, find minimum time for all nodes to receive signal. Return -1 if impossible.

**Example:**
```
Input: times = [[2,1,1],[2,3,1],[3,4,1]], n = 4, k = 2
Output: 2
Explanation: Signal reaches all nodes in 2 time units

Input: times = [[1,2,1]], n = 2, k = 2
Output: -1
```', 'Hint 1: This is a shortest path problem.
---
Hint 2: Use Dijkstra''s algorithm from starting node.
---
Hint 3: Answer is the maximum shortest path to any node.', '## Solution: Dijkstra''s Algorithm

Find shortest paths from k to all nodes:
- Use min-heap (priority queue)
- Track minimum time to each node
- Return max time if all reachable, else -1

Time: O(E log V), Space: O(V + E)', 'HARD', 'graph,dijkstra,shortest-path,heap'),

('ALGO', 'AMAZON', 'GRAPHS', 'Evaluate Division Equations', '# Evaluate Division Equations

Given equations like a/b=2.0, b/c=3.0, answer queries like a/c=?, a/e=?

**Example:**
```
Input: equations = [["a","b"],["b","c"]], values = [2.0,3.0], queries = [["a","c"],["b","a"],["a","e"]]
Output: [6.0, 0.5, -1.0]
Explanation: a/c = (a/b)*(b/c) = 6, b/a = 1/2 = 0.5, a/e = undefined
```', 'Hint 1: Build a weighted directed graph.
---
Hint 2: Edge from a to b with weight = value of a/b.
---
Hint 3: Use DFS/BFS to find path, multiply weights along path.', '## Solution: Weighted Graph DFS

Build graph with weighted edges:
- a → b with weight a/b
- b → a with weight b/a
- DFS from query start to end, multiply weights

Time: O(E + Q*V), Space: O(E)', 'MEDIUM', 'graph,dfs,hash-table,weighted-graph'),

('ALGO', 'GOOGLE', 'GRAPHS', 'Minimum Genetic Mutations', '# Minimum Genetic Mutations

A gene string has 8 characters, each is A/C/G/T. Given start gene, end gene, and gene bank, find minimum mutations needed. Each mutation changes one character and result must be in bank.

**Example:**
```
Input: start = "AACCGGTT", end = "AACCGGTA", bank = ["AACCGGTA"]
Output: 1

Input: start = "AACCGGTT", end = "AAACGGTA", bank = ["AACCGGTA","AACCGCTA","AAACGGTA"]
Output: 2
```', 'Hint 1: Similar to word ladder - BFS on implicit graph.
---
Hint 2: Nodes are gene strings, edges connect strings differing by 1 char.
---
Hint 3: Only consider genes in bank.', '## Solution: BFS

BFS on gene strings:
- Generate neighbors by changing each position to A/C/G/T
- Only visit genes in bank
- Track visited to avoid cycles

Time: O(B * 8 * 4) where B=bank size, Space: O(B)', 'MEDIUM', 'graph,bfs,string,shortest-path'),

('ALGO', 'META', 'GRAPHS', 'Critical Connections in Network', '# Critical Connections in Network

Given n servers and connections, find all critical connections. A critical connection is one that, if removed, will disconnect the network.

**Example:**
```
Input: n = 4, connections = [[0,1],[1,2],[2,0],[1,3]]
Output: [[1,3]]
Explanation: Removing [1,3] disconnects server 3

Input: n = 6, connections = [[0,1],[1,2],[2,0],[1,3],[3,4],[4,5],[5,3]]
Output: [[1,3]]
```', 'Hint 1: Critical connections are bridges in the graph.
---
Hint 2: Use Tarjan''s algorithm to find bridges.
---
Hint 3: Track discovery time and low-link values.', '## Solution: Tarjan''s Bridge-Finding Algorithm

Use DFS with timestamps:
- Track discovery time and low-link value
- Bridge exists if low[v] > disc[u] for edge u-v
- Low-link = min reachable discovery time

Time: O(V + E), Space: O(V)', 'HARD', 'graph,dfs,tarjan,bridges'),

('ALGO', 'AMAZON', 'GRAPHS', 'Shortest Path in Binary Matrix', '# Shortest Path in Binary Matrix

Given n×n binary matrix (0=walkable, 1=blocked), find shortest path from top-left to bottom-right. You can move in 8 directions. Return -1 if no path exists.

**Example:**
```
Input: grid = [[0,0,0],[1,1,0],[1,1,0]]
Output: 4
Explanation: (0,0)→(0,1)→(0,2)→(1,2)→(2,2)

Input: grid = [[0,1],[1,0]]
Output: -1
```', 'Hint 1: BFS for shortest path in unweighted graph.
---
Hint 2: Treat cells as nodes, edges connect adjacent walkable cells.
---
Hint 3: 8 directions: horizontal, vertical, diagonal.', '## Solution: BFS on Grid

Treat grid as graph:
- BFS from (0,0) to (n-1,n-1)
- Explore 8 directions
- Track visited cells

Time: O(n²), Space: O(n²)', 'MEDIUM', 'graph,bfs,matrix,shortest-path'),

('ALGO', 'GOOGLE', 'GRAPHS', 'Detect Cycle in Undirected Graph', '# Detect Cycle in Undirected Graph

Given n nodes and edges, determine if the undirected graph contains a cycle.

**Example:**
```
Input: n = 5, edges = [[0,1],[1,2],[2,3],[3,4]]
Output: false

Input: n = 5, edges = [[0,1],[1,2],[2,0],[3,4]]
Output: true
Explanation: 0-1-2-0 forms a cycle
```', 'Hint 1: Use DFS or Union-Find.
---
Hint 2: In DFS, cycle exists if we visit a visited node that isn''t the parent.
---
Hint 3: In Union-Find, cycle exists if both ends already in same set.', '## Solution: DFS or Union-Find

DFS approach:
- Track parent to avoid false positive
- If we visit a visited node (not parent), cycle exists

Union-Find:
- For each edge, if both ends in same set, cycle exists

Time: O(V + E), Space: O(V)', 'MEDIUM', 'graph,dfs,union-find,cycle-detection'),

('ALGO', 'META', 'GRAPHS', 'Cheapest Flights With K Stops', '# Cheapest Flights With K Stops

Given n cities, flights array [from, to, price], find cheapest price from src to dst with at most k stops. Return -1 if impossible.

**Example:**
```
Input: n=3, flights=[[0,1,100],[1,2,100],[0,2,500]], src=0, dst=2, k=1
Output: 200
Explanation: 0→1→2 with 1 stop costs 200

Input: n=3, flights=[[0,1,100],[1,2,100],[0,2,500]], src=0, dst=2, k=0
Output: 500
```', 'Hint 1: Modified Dijkstra or Bellman-Ford.
---
Hint 2: Track both cost and number of stops.
---
Hint 3: BFS with priority queue, prune paths exceeding k stops.', '## Solution: Modified Dijkstra/BFS

Use BFS with priority queue:
- State: (cost, city, stops)
- Explore neighbors if stops ≤ k
- Track minimum cost to reach each city with stops limit

Time: O(E * k), Space: O(V + E)', 'HARD', 'graph,dijkstra,bfs,dynamic-programming'),

('ALGO', 'AMAZON', 'GRAPHS', 'Accounts Merge', '# Accounts Merge

Given accounts list where accounts[i] = [name, email1, email2, ...], merge accounts belonging to same person. Two accounts belong to same person if they share at least one email.

**Example:**
```
Input: accounts = [["John","john@mail.com","john_work@mail.com"],["John","john@mail.com","john_other@mail.com"],["Mary","mary@mail.com"]]
Output: [["John","john@mail.com","john_other@mail.com","john_work@mail.com"],["Mary","mary@mail.com"]]
```', 'Hint 1: Union-Find on emails.
---
Hint 2: Connect all emails within same account.
---
Hint 3: Group emails by parent, sort results.', '## Solution: Union-Find

Use Union-Find on email addresses:
- Union all emails within each account
- Group emails by parent
- Map parent back to account name

Time: O(n * m * α(n)), Space: O(n * m)', 'MEDIUM', 'graph,union-find,hash-table,dfs'),

('ALGO', 'GOOGLE', 'GRAPHS', 'Redundant Connection', '# Redundant Connection

Given a graph that started as tree with n nodes, one edge was added creating a cycle. Find the edge that can be removed to restore tree. If multiple answers, return the last one in input.

**Example:**
```
Input: edges = [[1,2],[1,3],[2,3]]
Output: [2,3]

Input: edges = [[1,2],[2,3],[3,4],[1,4],[1,5]]
Output: [1,4]
```', 'Hint 1: Union-Find to detect cycle.
---
Hint 2: Process edges in order.
---
Hint 3: First edge that connects already-connected nodes is the answer.', '## Solution: Union-Find

Process edges sequentially:
- Use Union-Find
- When both ends already in same set, this edge creates cycle
- Return this edge

Time: O(n * α(n)), Space: O(n)', 'MEDIUM', 'graph,union-find,tree,cycle-detection'),

('ALGO', 'META', 'GRAPHS', 'Alien Dictionary Order', '# Alien Dictionary Order

Given a sorted dictionary of alien language words, derive the order of characters. If no valid order exists, return "".

**Example:**
```
Input: words = ["wrt","wrf","er","ett","rftt"]
Output: "wertf"

Input: words = ["z","x"]
Output: "zx"

Input: words = ["z","x","z"]
Output: ""
```', 'Hint 1: Build directed graph of character ordering.
---
Hint 2: Compare adjacent words to find character order.
---
Hint 3: Topological sort to get final ordering. Cycle means invalid.', '## Solution: Topological Sort

Build graph from word comparisons:
- Compare adjacent words, find first differing char
- Add edge from first to second char
- Topological sort (DFS or Kahn''s)
- Detect cycles (invalid order)

Time: O(C) where C=total chars, Space: O(1) - limited alphabet', 'HARD', 'graph,topological-sort,dfs,string'),

('ALGO', 'LEETCODE', 'GRAPHS', 'Number of Provinces', '# Number of Provinces

Given n×n matrix isConnected where isConnected[i][j]=1 means city i and j are directly connected, find number of provinces (connected components).

**Example:**
```
Input: isConnected = [[1,1,0],[1,1,0],[0,0,1]]
Output: 2
Explanation: Province 1: {0,1}, Province 2: {2}

Input: isConnected = [[1,0,0],[0,1,0],[0,0,1]]
Output: 3
```', 'Hint 1: This is finding connected components.
---
Hint 2: Use DFS, BFS, or Union-Find.
---
Hint 3: Count number of separate components.', '## Solution: DFS/BFS/Union-Find

Count connected components:
- DFS/BFS from each unvisited city
- Or Union-Find and count distinct parents

Time: O(n²), Space: O(n)', 'MEDIUM', 'graph,dfs,bfs,union-find,connected-components');
