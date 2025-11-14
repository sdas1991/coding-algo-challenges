-- Graphs Arena - 25 Problems (10 with full solutions)

USE faang;

-- Problem 1: Number of Islands (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'GRAPHS',
    'Number of Islands',
    '# Number of Islands

Given a 2D grid of ''1''s (land) and ''0''s (water), count the number of islands. An island is surrounded by water and formed by connecting adjacent lands horizontally or vertically.

**Example:**
```
Input: grid = [
  ["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
]
Output: 1
```',
    'Hint 1: Use DFS or BFS to explore connected components.
---
Hint 2: Mark visited cells to avoid revisiting.
---
Hint 3: Count how many times you start a new DFS/BFS.',
    'class Solution {
    public int numIslands(char[][] grid) {
        if (grid == null || grid.length == 0) return 0;
        int count = 0;
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (grid[i][j] == ''1'') {
                    count++;
                    dfs(grid, i, j);
                }
            }
        }
        return count;
    }

    private void dfs(char[][] grid, int i, int j) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] != ''1'') {
            return;
        }
        grid[i][j] = ''0'';
        dfs(grid, i + 1, j);
        dfs(grid, i - 1, j);
        dfs(grid, i, j + 1);
        dfs(grid, i, j - 1);
    }
}',
    'class Solution {
    fun numIslands(grid: Array<CharArray>): Int {
        if (grid.isEmpty()) return 0
        var count = 0
        for (i in grid.indices) {
            for (j in grid[0].indices) {
                if (grid[i][j] == ''1'') {
                    count++
                    dfs(grid, i, j)
                }
            }
        }
        return count
    }

    private fun dfs(grid: Array<CharArray>, i: Int, j: Int) {
        if (i < 0 || i >= grid.size || j < 0 || j >= grid[0].size || grid[i][j] != ''1'') {
            return
        }
        grid[i][j] = ''0''
        dfs(grid, i + 1, j)
        dfs(grid, i - 1, j)
        dfs(grid, i, j + 1)
        dfs(grid, i, j - 1)
    }
}',
    '## Solution: DFS

Time Complexity: O(m * n)
Space Complexity: O(m * n) for recursion stack

Use DFS to mark all cells in each island.',
    'MEDIUM',
    'graph,depth-first-search,breadth-first-search,union-find,matrix'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,1,1,1,0],[1,1,0,1,0],[1,1,0,0,0],[0,0,0,0,0]]', '1', FALSE),
    (LAST_INSERT_ID(), '[[1,1,0,0,0],[1,1,0,0,0],[0,0,1,0,0],[0,0,0,1,1]]', '3', FALSE);

-- Problem 2: Clone Graph (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'GRAPHS',
    'Clone Graph',
    '# Clone Graph

Given a reference of a node in a connected undirected graph, return a deep copy of the graph.

**Example:**
```
Input: adjList = [[2,4],[1,3],[2,4],[1,3]]
Output: [[2,4],[1,3],[2,4],[1,3]]
```',
    'Hint 1: Use HashMap to map original nodes to cloned nodes.
---
Hint 2: DFS or BFS to traverse the graph.
---
Hint 3: Clone neighbors recursively.',
    'class Solution {
    private Map<Node, Node> visited = new HashMap<>();

    public Node cloneGraph(Node node) {
        if (node == null) return null;
        if (visited.containsKey(node)) {
            return visited.get(node);
        }
        Node clone = new Node(node.val);
        visited.put(node, clone);
        for (Node neighbor : node.neighbors) {
            clone.neighbors.add(cloneGraph(neighbor));
        }
        return clone;
    }
}',
    'class Solution {
    private val visited = mutableMapOf<Node, Node>()

    fun cloneGraph(node: Node?): Node? {
        if (node == null) return null
        if (visited.containsKey(node)) {
            return visited[node]
        }
        val clone = Node(node.`val`)
        visited[node] = clone
        for (neighbor in node.neighbors) {
            clone.neighbors.add(cloneGraph(neighbor))
        }
        return clone
    }
}',
    '## Solution: DFS with HashMap

Time Complexity: O(V + E)
Space Complexity: O(V)

Use HashMap to track original→clone mapping.',
    'MEDIUM',
    'graph,depth-first-search,breadth-first-search,hash-table'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[2,4],[1,3],[2,4],[1,3]]', '[[2,4],[1,3],[2,4],[1,3]]', FALSE),
    (LAST_INSERT_ID(), '[[]]', '[[]]', FALSE);

-- Problem 3: Course Schedule (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'GRAPHS',
    'Course Schedule',
    '# Course Schedule

Given numCourses and prerequisites where prerequisites[i] = [ai, bi] (must take bi before ai), determine if you can finish all courses.

**Example:**
```
Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: Take course 0, then course 1
```',
    'Hint 1: This is a cycle detection problem.
---
Hint 2: Use topological sort (Kahn''s algorithm) or DFS.
---
Hint 3: Graph has cycle → impossible to complete all courses.',
    'class Solution {
    public boolean canFinish(int numCourses, int[][] prerequisites) {
        List<List<Integer>> graph = new ArrayList<>();
        int[] inDegree = new int[numCourses];
        for (int i = 0; i < numCourses; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] prereq : prerequisites) {
            graph.get(prereq[1]).add(prereq[0]);
            inDegree[prereq[0]]++;
        }
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < numCourses; i++) {
            if (inDegree[i] == 0) queue.offer(i);
        }
        int count = 0;
        while (!queue.isEmpty()) {
            int course = queue.poll();
            count++;
            for (int next : graph.get(course)) {
                inDegree[next]--;
                if (inDegree[next] == 0) {
                    queue.offer(next);
                }
            }
        }
        return count == numCourses;
    }
}',
    'class Solution {
    fun canFinish(numCourses: Int, prerequisites: Array<IntArray>): Boolean {
        val graph = List(numCourses) { mutableListOf<Int>() }
        val inDegree = IntArray(numCourses)
        for ((course, prereq) in prerequisites) {
            graph[prereq].add(course)
            inDegree[course]++
        }
        val queue = ArrayDeque<Int>()
        for (i in 0 until numCourses) {
            if (inDegree[i] == 0) queue.add(i)
        }
        var count = 0
        while (queue.isNotEmpty()) {
            val course = queue.removeFirst()
            count++
            for (next in graph[course]) {
                inDegree[next]--
                if (inDegree[next] == 0) {
                    queue.add(next)
                }
            }
        }
        return count == numCourses
    }
}',
    '## Solution: Topological Sort (Kahn''s Algorithm)

Time Complexity: O(V + E)
Space Complexity: O(V + E)

Use BFS-based topological sort to detect cycles.',
    'MEDIUM',
    'graph,depth-first-search,breadth-first-search,topological-sort'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '2,[[1,0]]', 'true', FALSE),
    (LAST_INSERT_ID(), '2,[[1,0],[0,1]]', 'false', FALSE);

-- Problem 4: Pacific Atlantic Water Flow (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'GRAPHS',
    'Pacific Atlantic Water Flow',
    '# Pacific Atlantic Water Flow

Given m×n matrix where heights[i][j] represents height above sea level. Find cells where water can flow to both Pacific (top/left) and Atlantic (bottom/right) oceans.

**Example:**
```
Input: heights = [[1,2,2,3,5],[3,2,3,4,4],[2,4,5,3,1]]
Output: [[0,4],[1,3],[1,4],[2,2]]
```',
    'Hint 1: Work backwards from oceans.
---
Hint 2: DFS from Pacific border and Atlantic border.
---
Hint 3: Find intersection of reachable cells.',
    'class Solution {
    public List<List<Integer>> pacificAtlantic(int[][] heights) {
        List<List<Integer>> result = new ArrayList<>();
        if (heights == null || heights.length == 0) return result;
        int m = heights.length, n = heights[0].length;
        boolean[][] pacific = new boolean[m][n];
        boolean[][] atlantic = new boolean[m][n];
        for (int i = 0; i < m; i++) {
            dfs(heights, pacific, i, 0, m, n);
            dfs(heights, atlantic, i, n - 1, m, n);
        }
        for (int j = 0; j < n; j++) {
            dfs(heights, pacific, 0, j, m, n);
            dfs(heights, atlantic, m - 1, j, m, n);
        }
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (pacific[i][j] && atlantic[i][j]) {
                    result.add(Arrays.asList(i, j));
                }
            }
        }
        return result;
    }

    private void dfs(int[][] heights, boolean[][] visited, int i, int j, int m, int n) {
        visited[i][j] = true;
        int[][] dirs = {{0,1},{1,0},{0,-1},{-1,0}};
        for (int[] dir : dirs) {
            int x = i + dir[0], y = j + dir[1];
            if (x >= 0 && x < m && y >= 0 && y < n && !visited[x][y] && heights[x][y] >= heights[i][j]) {
                dfs(heights, visited, x, y, m, n);
            }
        }
    }
}',
    'class Solution {
    fun pacificAtlantic(heights: Array<IntArray>): List<List<Int>> {
        val result = mutableListOf<List<Int>>()
        if (heights.isEmpty()) return result
        val m = heights.size
        val n = heights[0].size
        val pacific = Array(m) { BooleanArray(n) }
        val atlantic = Array(m) { BooleanArray(n) }
        for (i in 0 until m) {
            dfs(heights, pacific, i, 0, m, n)
            dfs(heights, atlantic, i, n - 1, m, n)
        }
        for (j in 0 until n) {
            dfs(heights, pacific, 0, j, m, n)
            dfs(heights, atlantic, m - 1, j, m, n)
        }
        for (i in 0 until m) {
            for (j in 0 until n) {
                if (pacific[i][j] && atlantic[i][j]) {
                    result.add(listOf(i, j))
                }
            }
        }
        return result
    }

    private fun dfs(heights: Array<IntArray>, visited: Array<BooleanArray>, i: Int, j: Int, m: Int, n: Int) {
        visited[i][j] = true
        val dirs = arrayOf(intArrayOf(0,1), intArrayOf(1,0), intArrayOf(0,-1), intArrayOf(-1,0))
        for (dir in dirs) {
            val x = i + dir[0]
            val y = j + dir[1]
            if (x in 0 until m && y in 0 until n && !visited[x][y] && heights[x][y] >= heights[i][j]) {
                dfs(heights, visited, x, y, m, n)
            }
        }
    }
}',
    '## Solution: Reverse DFS

Time Complexity: O(m * n)
Space Complexity: O(m * n)

DFS from ocean borders inward, find intersection.',
    'MEDIUM',
    'graph,depth-first-search,breadth-first-search,matrix'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,2,2,3,5],[3,2,3,4,4],[2,4,5,3,1],[6,7,1,4,5],[5,1,1,2,4]]', '[[0,4],[1,3],[1,4],[2,2],[3,0],[3,1],[4,0]]', FALSE);

-- Problem 5: Word Ladder (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'GRAPHS',
    'Word Ladder',
    '# Word Ladder

Given beginWord, endWord, and wordList, find length of shortest transformation sequence from beginWord to endWord. Each step changes one letter, and each intermediate word must be in wordList.

**Example:**
```
Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
Output: 5
Explanation: hit→hot→dot→dog→cog
```',
    'Hint 1: BFS to find shortest path.
---
Hint 2: Generate all possible one-letter transformations.
---
Hint 3: Use HashSet for O(1) word lookup.',
    'class Solution {
    public int ladderLength(String beginWord, String endWord, List<String> wordList) {
        Set<String> wordSet = new HashSet<>(wordList);
        if (!wordSet.contains(endWord)) return 0;
        Queue<String> queue = new LinkedList<>();
        queue.offer(beginWord);
        int level = 1;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String word = queue.poll();
                if (word.equals(endWord)) return level;
                char[] chars = word.toCharArray();
                for (int j = 0; j < chars.length; j++) {
                    char original = chars[j];
                    for (char c = ''a''; c <= ''z''; c++) {
                        chars[j] = c;
                        String newWord = new String(chars);
                        if (wordSet.contains(newWord)) {
                            queue.offer(newWord);
                            wordSet.remove(newWord);
                        }
                    }
                    chars[j] = original;
                }
            }
            level++;
        }
        return 0;
    }
}',
    'class Solution {
    fun ladderLength(beginWord: String, endWord: String, wordList: List<String>): Int {
        val wordSet = wordList.toMutableSet()
        if (!wordSet.contains(endWord)) return 0
        val queue = ArrayDeque<String>()
        queue.add(beginWord)
        var level = 1
        while (queue.isNotEmpty()) {
            val size = queue.size
            repeat(size) {
                val word = queue.removeFirst()
                if (word == endWord) return level
                val chars = word.toCharArray()
                for (j in chars.indices) {
                    val original = chars[j]
                    for (c in ''a''..''z'') {
                        chars[j] = c
                        val newWord = String(chars)
                        if (newWord in wordSet) {
                            queue.add(newWord)
                            wordSet.remove(newWord)
                        }
                    }
                    chars[j] = original
                }
            }
            level++
        }
        return 0
    }
}',
    '## Solution: BFS

Time Complexity: O(M² × N), M = word length, N = wordList size
Space Complexity: O(N)

BFS finds shortest path in unweighted graph.',
    'HARD',
    'graph,breadth-first-search,hash-table,string'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'hit,cog,[hot,dot,dog,lot,log,cog]', '5', FALSE),
    (LAST_INSERT_ID(), 'hit,cog,[hot,dot,dog,lot,log]', '0', FALSE);

-- Problem 6: Network Delay Time (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'GRAPHS',
    'Network Delay Time',
    '# Network Delay Time

Given network of n nodes and times array where times[i] = [ui, vi, wi] (signal from ui to vi takes wi time), find minimum time for all nodes to receive signal from node k. Return -1 if impossible.

**Example:**
```
Input: times = [[2,1,1],[2,3,1],[3,4,1]], n = 4, k = 2
Output: 2
```',
    'Hint 1: Dijkstra''s algorithm for shortest paths.
---
Hint 2: Use priority queue (min-heap).
---
Hint 3: Return maximum distance to any node.',
    'class Solution {
    public int networkDelayTime(int[][] times, int n, int k) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] time : times) {
            graph.computeIfAbsent(time[0], x -> new ArrayList<>()).add(new int[]{time[1], time[2]});
        }
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{k, 0});
        Map<Integer, Integer> dist = new HashMap<>();
        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0], time = curr[1];
            if (dist.containsKey(node)) continue;
            dist.put(node, time);
            if (graph.containsKey(node)) {
                for (int[] edge : graph.get(node)) {
                    int neighbor = edge[0], weight = edge[1];
                    if (!dist.containsKey(neighbor)) {
                        pq.offer(new int[]{neighbor, time + weight});
                    }
                }
            }
        }
        if (dist.size() != n) return -1;
        return Collections.max(dist.values());
    }
}',
    'class Solution {
    fun networkDelayTime(times: Array<IntArray>, n: Int, k: Int): Int {
        val graph = mutableMapOf<Int, MutableList<Pair<Int, Int>>>()
        for ((u, v, w) in times) {
            graph.computeIfAbsent(u) { mutableListOf() }.add(v to w)
        }
        val pq = PriorityQueue<Pair<Int, Int>>(compareBy { it.second })
        pq.offer(k to 0)
        val dist = mutableMapOf<Int, Int>()
        while (pq.isNotEmpty()) {
            val (node, time) = pq.poll()
            if (node in dist) continue
            dist[node] = time
            graph[node]?.forEach { (neighbor, weight) ->
                if (neighbor !in dist) {
                    pq.offer(neighbor to time + weight)
                }
            }
        }
        if (dist.size != n) return -1
        return dist.values.maxOrNull() ?: 0
    }
}',
    '## Solution: Dijkstra''s Algorithm

Time Complexity: O(E log V)
Space Complexity: O(V + E)

Use Dijkstra to find shortest paths from source.',
    'MEDIUM',
    'graph,heap,shortest-path'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[2,1,1],[2,3,1],[3,4,1]],4,2', '2', FALSE),
    (LAST_INSERT_ID(), '[[1,2,1]],2,1', '1', FALSE);

-- Problem 7: Course Schedule II (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'GRAPHS',
    'Course Schedule II',
    '# Course Schedule II

Return the ordering of courses you should take to finish all courses. If impossible, return empty array.

**Example:**
```
Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
Output: [0,2,1,3] (or [0,1,2,3])
```',
    'Hint 1: Topological sort with BFS (Kahn''s) or DFS.
---
Hint 2: Track course order as you process.
---
Hint 3: Cycle detection: if count < numCourses, return empty.',
    'class Solution {
    public int[] findOrder(int numCourses, int[][] prerequisites) {
        List<List<Integer>> graph = new ArrayList<>();
        int[] inDegree = new int[numCourses];
        for (int i = 0; i < numCourses; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] prereq : prerequisites) {
            graph.get(prereq[1]).add(prereq[0]);
            inDegree[prereq[0]]++;
        }
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < numCourses; i++) {
            if (inDegree[i] == 0) queue.offer(i);
        }
        int[] result = new int[numCourses];
        int idx = 0;
        while (!queue.isEmpty()) {
            int course = queue.poll();
            result[idx++] = course;
            for (int next : graph.get(course)) {
                inDegree[next]--;
                if (inDegree[next] == 0) {
                    queue.offer(next);
                }
            }
        }
        return idx == numCourses ? result : new int[0];
    }
}',
    'class Solution {
    fun findOrder(numCourses: Int, prerequisites: Array<IntArray>): IntArray {
        val graph = List(numCourses) { mutableListOf<Int>() }
        val inDegree = IntArray(numCourses)
        for ((course, prereq) in prerequisites) {
            graph[prereq].add(course)
            inDegree[course]++
        }
        val queue = ArrayDeque<Int>()
        for (i in 0 until numCourses) {
            if (inDegree[i] == 0) queue.add(i)
        }
        val result = IntArray(numCourses)
        var idx = 0
        while (queue.isNotEmpty()) {
            val course = queue.removeFirst()
            result[idx++] = course
            for (next in graph[course]) {
                inDegree[next]--
                if (inDegree[next] == 0) {
                    queue.add(next)
                }
            }
        }
        return if (idx == numCourses) result else intArrayOf()
    }
}',
    '## Solution: Topological Sort

Time Complexity: O(V + E)
Space Complexity: O(V + E)

Build ordering using Kahn''s algorithm.',
    'MEDIUM',
    'graph,depth-first-search,breadth-first-search,topological-sort'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '4,[[1,0],[2,0],[3,1],[3,2]]', '[0,1,2,3]', FALSE),
    (LAST_INSERT_ID(), '2,[[1,0],[0,1]]', '[]', FALSE);

-- Problem 8: Cheapest Flights Within K Stops (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'GRAPHS',
    'Cheapest Flights Within K Stops',
    '# Cheapest Flights Within K Stops

Given flights[i] = [from, to, price], find cheapest price from src to dst with at most k stops. Return -1 if no such route.

**Example:**
```
Input: n = 4, flights = [[0,1,100],[1,2,100],[2,0,100],[1,3,600],[2,3,200]], src = 0, dst = 3, k = 1
Output: 700
```',
    'Hint 1: Modified Dijkstra or BFS with stop tracking.
---
Hint 2: Track (cost, node, stops) in queue.
---
Hint 3: Prune paths exceeding k stops.',
    'class Solution {
    public int findCheapestPrice(int n, int[][] flights, int src, int dst, int k) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] flight : flights) {
            graph.computeIfAbsent(flight[0], x -> new ArrayList<>()).add(new int[]{flight[1], flight[2]});
        }
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{0, src, 0});
        int[][] best = new int[n][k + 2];
        for (int[] row : best) Arrays.fill(row, Integer.MAX_VALUE);
        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int cost = curr[0], node = curr[1], stops = curr[2];
            if (node == dst) return cost;
            if (stops > k) continue;
            if (graph.containsKey(node)) {
                for (int[] edge : graph.get(node)) {
                    int nextNode = edge[0], price = edge[1];
                    int newCost = cost + price;
                    if (newCost < best[nextNode][stops + 1]) {
                        best[nextNode][stops + 1] = newCost;
                        pq.offer(new int[]{newCost, nextNode, stops + 1});
                    }
                }
            }
        }
        return -1;
    }
}',
    'class Solution {
    fun findCheapestPrice(n: Int, flights: Array<IntArray>, src: Int, dst: Int, k: Int): Int {
        val graph = mutableMapOf<Int, MutableList<Pair<Int, Int>>>()
        for ((from, to, price) in flights) {
            graph.computeIfAbsent(from) { mutableListOf() }.add(to to price)
        }
        val pq = PriorityQueue<Triple<Int, Int, Int>>(compareBy { it.first })
        pq.offer(Triple(0, src, 0))
        val best = Array(n) { IntArray(k + 2) { Int.MAX_VALUE } }
        while (pq.isNotEmpty()) {
            val (cost, node, stops) = pq.poll()
            if (node == dst) return cost
            if (stops > k) continue
            graph[node]?.forEach { (nextNode, price) ->
                val newCost = cost + price
                if (newCost < best[nextNode][stops + 1]) {
                    best[nextNode][stops + 1] = newCost
                    pq.offer(Triple(newCost, nextNode, stops + 1))
                }
            }
        }
        return -1
    }
}',
    '## Solution: Modified Dijkstra

Time Complexity: O(E * K * log(E * K))
Space Complexity: O(N * K)

Dijkstra with additional stop constraint.',
    'MEDIUM',
    'graph,heap,shortest-path,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '4,[[0,1,100],[1,2,100],[2,0,100],[1,3,600],[2,3,200]],0,3,1', '700', FALSE);

-- Problem 9: Redundant Connection (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'GRAPHS',
    'Redundant Connection',
    '# Redundant Connection

Given graph as edge list that started as a tree with one additional edge added, return an edge that can be removed.

**Example:**
```
Input: edges = [[1,2],[1,3],[2,3]]
Output: [2,3]
```',
    'Hint 1: Use Union-Find (Disjoint Set Union).
---
Hint 2: For each edge, check if nodes already connected.
---
Hint 3: If connected, this edge creates cycle.',
    'class Solution {
    public int[] findRedundantConnection(int[][] edges) {
        int n = edges.length;
        int[] parent = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            parent[i] = i;
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            if (find(parent, u) == find(parent, v)) {
                return edge;
            }
            union(parent, u, v);
        }
        return new int[0];
    }

    private int find(int[] parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }

    private void union(int[] parent, int x, int y) {
        parent[find(parent, x)] = find(parent, y);
    }
}',
    'class Solution {
    fun findRedundantConnection(edges: Array<IntArray>): IntArray {
        val n = edges.size
        val parent = IntArray(n + 1) { it }
        for ((u, v) in edges) {
            if (find(parent, u) == find(parent, v)) {
                return intArrayOf(u, v)
            }
            union(parent, u, v)
        }
        return intArrayOf()
    }

    private fun find(parent: IntArray, x: Int): Int {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x])
        }
        return parent[x]
    }

    private fun union(parent: IntArray, x: Int, y: Int) {
        parent[find(parent, x)] = find(parent, y)
    }
}',
    '## Solution: Union-Find

Time Complexity: O(N * α(N)), α is inverse Ackermann
Space Complexity: O(N)

Detect cycle using union-find data structure.',
    'MEDIUM',
    'graph,union-find,depth-first-search'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,2],[1,3],[2,3]]', '[2,3]', FALSE),
    (LAST_INSERT_ID(), '[[1,2],[2,3],[3,4],[1,4],[1,5]]', '[1,4]', FALSE);

-- Problem 10: Alien Dictionary (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'GRAPHS',
    'Alien Dictionary',
    '# Alien Dictionary

Given sorted dictionary of alien language, derive the order of characters.

**Example:**
```
Input: words = ["wrt","wrf","er","ett","rftt"]
Output: "wertf"
```',
    'Hint 1: Build graph from character ordering.
---
Hint 2: Compare adjacent words to find character order.
---
Hint 3: Topological sort to get final ordering.',
    'class Solution {
    public String alienOrder(String[] words) {
        Map<Character, Set<Character>> graph = new HashMap<>();
        Map<Character, Integer> inDegree = new HashMap<>();
        for (String word : words) {
            for (char c : word.toCharArray()) {
                graph.putIfAbsent(c, new HashSet<>());
                inDegree.putIfAbsent(c, 0);
            }
        }
        for (int i = 0; i < words.length - 1; i++) {
            String w1 = words[i], w2 = words[i + 1];
            int minLen = Math.min(w1.length(), w2.length());
            if (w1.length() > w2.length() && w1.startsWith(w2)) return "";
            for (int j = 0; j < minLen; j++) {
                char c1 = w1.charAt(j), c2 = w2.charAt(j);
                if (c1 != c2) {
                    if (!graph.get(c1).contains(c2)) {
                        graph.get(c1).add(c2);
                        inDegree.put(c2, inDegree.get(c2) + 1);
                    }
                    break;
                }
            }
        }
        Queue<Character> queue = new LinkedList<>();
        for (char c : inDegree.keySet()) {
            if (inDegree.get(c) == 0) queue.offer(c);
        }
        StringBuilder result = new StringBuilder();
        while (!queue.isEmpty()) {
            char c = queue.poll();
            result.append(c);
            for (char next : graph.get(c)) {
                inDegree.put(next, inDegree.get(next) - 1);
                if (inDegree.get(next) == 0) {
                    queue.offer(next);
                }
            }
        }
        return result.length() == inDegree.size() ? result.toString() : "";
    }
}',
    'class Solution {
    fun alienOrder(words: Array<String>): String {
        val graph = mutableMapOf<Char, MutableSet<Char>>()
        val inDegree = mutableMapOf<Char, Int>()
        for (word in words) {
            for (c in word) {
                graph.putIfAbsent(c, mutableSetOf())
                inDegree.putIfAbsent(c, 0)
            }
        }
        for (i in 0 until words.size - 1) {
            val w1 = words[i]
            val w2 = words[i + 1]
            if (w1.length > w2.length && w1.startsWith(w2)) return ""
            for (j in 0 until minOf(w1.length, w2.length)) {
                val c1 = w1[j]
                val c2 = w2[j]
                if (c1 != c2) {
                    if (c2 !in graph[c1]!!) {
                        graph[c1]!!.add(c2)
                        inDegree[c2] = inDegree[c2]!! + 1
                    }
                    break
                }
            }
        }
        val queue = ArrayDeque<Char>()
        for ((c, degree) in inDegree) {
            if (degree == 0) queue.add(c)
        }
        val result = StringBuilder()
        while (queue.isNotEmpty()) {
            val c = queue.removeFirst()
            result.append(c)
            for (next in graph[c]!!) {
                inDegree[next] = inDegree[next]!! - 1
                if (inDegree[next] == 0) {
                    queue.add(next)
                }
            }
        }
        return if (result.length == inDegree.size) result.toString() else ""
    }
}',
    '## Solution: Topological Sort

Time Complexity: O(C), C = total characters
Space Complexity: O(1) - at most 26 unique chars

Build graph from word comparisons, topological sort.',
    'HARD',
    'graph,string,topological-sort,array'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[wrt,wrf,er,ett,rftt]', 'wertf', FALSE),
    (LAST_INSERT_ID(), '[z,x]', 'zx', FALSE);

-- Additional 15 graph problems (without full solutions)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'LEETCODE', 'GRAPHS', 'Max Area of Island', '# Max Area of Island

Find the maximum area of an island in grid (1 = land, 0 = water).

**Example:**
```
Input: grid = [[0,0,1,0,0],[0,1,1,0,0],[0,1,0,0,0]]
Output: 4
```', 'Hint 1: DFS to explore each island.
---
Hint 2: Count cells in each island.
---
Hint 3: Track maximum area seen.', 'MEDIUM', 'graph,depth-first-search,breadth-first-search,union-find,matrix'),

('ALGO', 'AMAZON', 'GRAPHS', 'Surrounded Regions', '# Surrounded Regions

Capture all regions (O) surrounded by X. Convert surrounded O to X.

**Example:**
```
Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
```', 'Hint 1: DFS from border Os to mark unsurrounded.
---
Hint 2: All other Os are surrounded.
---
Hint 3: Use temporary marker for border-connected Os.', 'MEDIUM', 'graph,depth-first-search,breadth-first-search,union-find,matrix'),

('ALGO', 'GOOGLE', 'GRAPHS', 'Rotting Oranges', '# Rotting Oranges

Every minute, fresh oranges adjacent to rotten ones rot. Find minimum minutes until no fresh oranges remain.

**Example:**
```
Input: grid = [[2,1,1],[1,1,0],[0,1,1]]
Output: 4
```', 'Hint 1: Multi-source BFS.
---
Hint 2: Start from all rotten oranges simultaneously.
---
Hint 3: Track minutes as BFS levels.', 'MEDIUM', 'graph,breadth-first-search,matrix'),

('ALGO', 'META', 'GRAPHS', 'Shortest Path in Binary Matrix', '# Shortest Path in Binary Matrix

Find shortest clear path from top-left to bottom-right (8-directional movement).

**Example:**
```
Input: grid = [[0,1],[1,0]]
Output: 2
```', 'Hint 1: BFS for shortest path.
---
Hint 2: 8 directions: horizontal, vertical, diagonal.
---
Hint 3: Check if start and end are clear (0).', 'MEDIUM', 'graph,breadth-first-search,matrix'),

('ALGO', 'LEETCODE', 'GRAPHS', 'Is Graph Bipartite', '# Is Graph Bipartite?

Determine if graph can be colored with 2 colors such that no adjacent nodes share color.

**Example:**
```
Input: graph = [[1,2,3],[0,2],[0,1,3],[0,2]]
Output: false
```', 'Hint 1: Try to color using BFS or DFS.
---
Hint 2: Color neighbors with opposite color.
---
Hint 3: If conflict found, not bipartite.', 'MEDIUM', 'graph,depth-first-search,breadth-first-search,union-find'),

('ALGO', 'AMAZON', 'GRAPHS', 'Accounts Merge', '# Accounts Merge

Merge accounts belonging to same person (shared email means same person).

**Example:**
```
Input: accounts = [["John","john@mail.com","john_work@mail.com"],["John","john@mail.com","john_other@mail.com"]]
Output: [["John","john@mail.com","john_other@mail.com","john_work@mail.com"]]
```', 'Hint 1: Union-Find or DFS to group connected emails.
---
Hint 2: Build graph where edges connect emails.
---
Hint 3: Sort emails in each group.', 'MEDIUM', 'graph,depth-first-search,breadth-first-search,union-find,array,string'),

('ALGO', 'GOOGLE', 'GRAPHS', 'Minimum Height Trees', '# Minimum Height Trees

Find all root nodes that minimize tree height.

**Example:**
```
Input: n = 4, edges = [[1,0],[1,2],[1,3]]
Output: [1]
```', 'Hint 1: Trim leaf nodes layer by layer.
---
Hint 2: Like topological sort from leaves inward.
---
Hint 3: Last remaining nodes are centers.', 'MEDIUM', 'graph,breadth-first-search,topological-sort'),

('ALGO', 'META', 'GRAPHS', 'Graph Valid Tree', '# Graph Valid Tree

Determine if edges form a valid tree (n nodes, no cycles, connected).

**Example:**
```
Input: n = 5, edges = [[0,1],[0,2],[0,3],[1,4]]
Output: true
```', 'Hint 1: Tree has exactly n-1 edges.
---
Hint 2: Must be connected (DFS/BFS visits all).
---
Hint 3: Must not have cycles (Union-Find).', 'MEDIUM', 'graph,depth-first-search,breadth-first-search,union-find'),

('ALGO', 'LEETCODE', 'GRAPHS', 'Evaluate Division', '# Evaluate Division

Given equations and values, evaluate queries. equations[i] = [a, b], values[i] represents a/b.

**Example:**
```
Input: equations = [["a","b"],["b","c"]], values = [2.0,3.0], queries = [["a","c"]]
Output: [6.0]
```', 'Hint 1: Build weighted directed graph.
---
Hint 2: DFS to find path and multiply weights.
---
Hint 3: Return -1.0 if no path exists.', 'MEDIUM', 'graph,depth-first-search,breadth-first-search,union-find,shortest-path'),

('ALGO', 'AMAZON', 'GRAPHS', 'Longest Increasing Path in Matrix', '# Longest Increasing Path in Matrix

Find length of longest increasing path in matrix.

**Example:**
```
Input: matrix = [[9,9,4],[6,6,8],[2,1,1]]
Output: 4 (path: 1→2→6→9)
```', 'Hint 1: DFS with memoization.
---
Hint 2: Cache longest path from each cell.
---
Hint 3: Move to larger neighbors only.', 'HARD', 'graph,depth-first-search,breadth-first-search,dynamic-programming,topological-sort,memoization,matrix'),

('ALGO', 'GOOGLE', 'GRAPHS', 'Critical Connections in Network', '# Critical Connections in a Network

Find all critical connections (bridges) in network.

**Example:**
```
Input: n = 4, connections = [[0,1],[1,2],[2,0],[1,3]]
Output: [[1,3]]
```', 'Hint 1: Tarjan''s algorithm for finding bridges.
---
Hint 2: Track discovery time and low link values.
---
Hint 3: Edge is bridge if low[v] > disc[u].', 'HARD', 'graph,depth-first-search,biconnected-component'),

('ALGO', 'META', 'GRAPHS', 'Swim in Rising Water', '# Swim in Rising Water

Find minimum time to swim from top-left to bottom-right (elevation increases with time).

**Example:**
```
Input: grid = [[0,2],[1,3]]
Output: 3
```', 'Hint 1: Binary search on time + BFS.
---
Hint 2: Alternative: Dijkstra treating elevation as cost.
---
Hint 3: Or union-find sorted by elevation.', 'HARD', 'graph,breadth-first-search,binary-search,heap,union-find,matrix'),

('ALGO', 'LEETCODE', 'GRAPHS', 'Min Cost to Connect All Points', '# Min Cost to Connect All Points

Find minimum cost to connect all points (Manhattan distance).

**Example:**
```
Input: points = [[0,0],[2,2],[3,10],[5,2],[7,0]]
Output: 20
```', 'Hint 1: Minimum Spanning Tree (MST).
---
Hint 2: Prim''s or Kruskal''s algorithm.
---
Hint 3: All points are connected (complete graph).', 'MEDIUM', 'graph,union-find,minimum-spanning-tree'),

('ALGO', 'AMAZON', 'GRAPHS', 'Reconstruct Itinerary', '# Reconstruct Itinerary

Given airline tickets, reconstruct itinerary starting from JFK (lexical order).

**Example:**
```
Input: tickets = [["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]]
Output: ["JFK","MUC","LHR","SFO","SJC"]
```', 'Hint 1: Eulerian path problem.
---
Hint 2: DFS with backtracking.
---
Hint 3: Sort destinations lexically, add to result in reverse.', 'HARD', 'graph,depth-first-search,eulerian-circuit'),

('ALGO', 'GOOGLE', 'GRAPHS', 'Shortest Path Visiting All Nodes', '# Shortest Path Visiting All Nodes

Find shortest path length that visits every node (can revisit).

**Example:**
```
Input: graph = [[1,2,3],[0],[0],[0]]
Output: 4
```', 'Hint 1: BFS with state: (node, visited_set).
---
Hint 2: Use bitmask to represent visited set.
---
Hint 3: Start from all nodes simultaneously.', 'HARD', 'graph,breadth-first-search,bit-manipulation,dynamic-programming,bitmask');
