-- Heaps Arena - 25 Problems (10 with full solutions)

USE faang;

-- Problem 1: Kth Largest Element in an Array (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'HEAPS',
    'Kth Largest Element in an Array',
    '# Kth Largest Element in an Array

Find the kth largest element in an unsorted array.

**Example:**
```
Input: nums = [3,2,1,5,6,4], k = 2
Output: 5
```',
    'Hint 1: Use a min-heap of size k.
---
Hint 2: Maintain k largest elements in heap.
---
Hint 3: Alternative: QuickSelect for O(n) average.',
    'class Solution {
    public int findKthLargest(int[] nums, int k) {
        PriorityQueue<Integer> heap = new PriorityQueue<>();
        for (int num : nums) {
            heap.offer(num);
            if (heap.size() > k) {
                heap.poll();
            }
        }
        return heap.peek();
    }
}',
    'class Solution {
    fun findKthLargest(nums: IntArray, k: Int): Int {
        val heap = PriorityQueue<Int>()
        for (num in nums) {
            heap.offer(num)
            if (heap.size > k) {
                heap.poll()
            }
        }
        return heap.peek()
    }
}',
    '## Solution: Min Heap

Time Complexity: O(n log k)
Space Complexity: O(k)

Maintain k largest elements in min-heap.',
    'MEDIUM',
    'array,heap,divide-and-conquer,quickselect,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[3,2,1,5,6,4],2', '5', FALSE),
    (LAST_INSERT_ID(), '[3,2,3,1,2,4,5,5,6],4', '4', FALSE);

-- Problem 2: Top K Frequent Elements (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'HEAPS',
    'Top K Frequent Elements',
    '# Top K Frequent Elements

Given integer array nums and integer k, return the k most frequent elements.

**Example:**
```
Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]
```',
    'Hint 1: Count frequencies using HashMap.
---
Hint 2: Use min-heap of size k with frequency comparison.
---
Hint 3: Alternative: Bucket sort by frequency.',
    'class Solution {
    public int[] topKFrequent(int[] nums, int k) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }
        PriorityQueue<Integer> heap = new PriorityQueue<>((a, b) -> count.get(a) - count.get(b));
        for (int num : count.keySet()) {
            heap.offer(num);
            if (heap.size() > k) {
                heap.poll();
            }
        }
        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = heap.poll();
        }
        return result;
    }
}',
    'class Solution {
    fun topKFrequent(nums: IntArray, k: Int): IntArray {
        val count = mutableMapOf<Int, Int>()
        for (num in nums) {
            count[num] = count.getOrDefault(num, 0) + 1
        }
        val heap = PriorityQueue<Int>(compareBy { count[it] })
        for (num in count.keys) {
            heap.offer(num)
            if (heap.size > k) {
                heap.poll()
            }
        }
        return IntArray(k) { heap.poll() }
    }
}',
    '## Solution: HashMap + Min Heap

Time Complexity: O(n log k)
Space Complexity: O(n)

Frequency counting with heap selection.',
    'MEDIUM',
    'array,hash-table,heap,divide-and-conquer,quickselect,sorting,bucket-sort,counting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,1,1,2,2,3],2', '[1,2]', FALSE),
    (LAST_INSERT_ID(), '[1],1', '[1]', FALSE);

-- Problem 3: Find Median from Data Stream (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'HEAPS',
    'Find Median from Data Stream',
    '# Find Median from Data Stream

Design data structure that supports adding numbers and finding median in O(log n) and O(1).

**Example:**
```
Input: ["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
[[], [1], [2], [], [3], []]
Output: [null, null, null, 1.5, null, 2.0]
```',
    'Hint 1: Use two heaps: max-heap (lower half) and min-heap (upper half).
---
Hint 2: Balance heaps so sizes differ by at most 1.
---
Hint 3: Median is from top of larger heap or average of both tops.',
    'class MedianFinder {
    private PriorityQueue<Integer> maxHeap;
    private PriorityQueue<Integer> minHeap;

    public MedianFinder() {
        maxHeap = new PriorityQueue<>((a, b) -> b - a);
        minHeap = new PriorityQueue<>();
    }

    public void addNum(int num) {
        maxHeap.offer(num);
        minHeap.offer(maxHeap.poll());
        if (minHeap.size() > maxHeap.size()) {
            maxHeap.offer(minHeap.poll());
        }
    }

    public double findMedian() {
        if (maxHeap.size() > minHeap.size()) {
            return maxHeap.peek();
        }
        return (maxHeap.peek() + minHeap.peek()) / 2.0;
    }
}',
    'class MedianFinder() {
    private val maxHeap = PriorityQueue<Int>(reverseOrder())
    private val minHeap = PriorityQueue<Int>()

    fun addNum(num: Int) {
        maxHeap.offer(num)
        minHeap.offer(maxHeap.poll())
        if (minHeap.size > maxHeap.size) {
            maxHeap.offer(minHeap.poll())
        }
    }

    fun findMedian(): Double {
        return if (maxHeap.size > minHeap.size) {
            maxHeap.peek().toDouble()
        } else {
            (maxHeap.peek() + minHeap.peek()) / 2.0
        }
    }
}',
    '## Solution: Two Heaps

Time Complexity: O(log n) add, O(1) find
Space Complexity: O(n)

Maintain balance between two heaps.',
    'HARD',
    'heap,design,two-pointers,data-stream,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'addNum(1),addNum(2),findMedian()', '1.5', FALSE),
    (LAST_INSERT_ID(), 'addNum(1),addNum(2),findMedian(),addNum(3),findMedian()', '1.5,2.0', FALSE);

-- Problem 4: Merge K Sorted Lists (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'HEAPS',
    'Merge K Sorted Lists',
    '# Merge K Sorted Lists

Merge k sorted linked lists into one sorted list.

**Example:**
```
Input: lists = [[1,4,5],[1,3,4],[2,6]]
Output: [1,1,2,3,4,4,5,6]
```',
    'Hint 1: Use min-heap to track smallest element from each list.
---
Hint 2: Add head of each list to heap initially.
---
Hint 3: Extract min, add its next node to heap.',
    'class Solution {
    public ListNode mergeKLists(ListNode[] lists) {
        PriorityQueue<ListNode> heap = new PriorityQueue<>((a, b) -> a.val - b.val);
        for (ListNode node : lists) {
            if (node != null) heap.offer(node);
        }
        ListNode dummy = new ListNode(0);
        ListNode curr = dummy;
        while (!heap.isEmpty()) {
            ListNode node = heap.poll();
            curr.next = node;
            curr = curr.next;
            if (node.next != null) {
                heap.offer(node.next);
            }
        }
        return dummy.next;
    }
}',
    'class Solution {
    fun mergeKLists(lists: Array<ListNode?>): ListNode? {
        val heap = PriorityQueue<ListNode>(compareBy { it.`val` })
        for (node in lists) {
            node?.let { heap.offer(it) }
        }
        val dummy = ListNode(0)
        var curr = dummy
        while (heap.isNotEmpty()) {
            val node = heap.poll()
            curr.next = node
            curr = curr.next!!
            node.next?.let { heap.offer(it) }
        }
        return dummy.next
    }
}',
    '## Solution: Min Heap

Time Complexity: O(N log k), N = total nodes
Space Complexity: O(k)

Efficient merging using priority queue.',
    'HARD',
    'linked-list,heap,divide-and-conquer,merge-sort'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,4,5],[1,3,4],[2,6]]', '[1,1,2,3,4,4,5,6]', FALSE),
    (LAST_INSERT_ID(), '[]', '[]', FALSE);

-- Problem 5: Kth Smallest Element in a Sorted Matrix (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'HEAPS',
    'Kth Smallest Element in a Sorted Matrix',
    '# Kth Smallest Element in a Sorted Matrix

Given n×n matrix where rows and columns are sorted, find kth smallest element.

**Example:**
```
Input: matrix = [[1,5,9],[10,11,13],[12,13,15]], k = 8
Output: 13
```',
    'Hint 1: Use min-heap starting with first column.
---
Hint 2: Extract min k times, adding right neighbor.
---
Hint 3: Alternative: Binary search on value range.',
    'class Solution {
    public int kthSmallest(int[][] matrix, int k) {
        int n = matrix.length;
        PriorityQueue<int[]> heap = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        for (int i = 0; i < Math.min(n, k); i++) {
            heap.offer(new int[]{matrix[i][0], i, 0});
        }
        int result = 0;
        for (int i = 0; i < k; i++) {
            int[] curr = heap.poll();
            result = curr[0];
            int row = curr[1], col = curr[2];
            if (col + 1 < n) {
                heap.offer(new int[]{matrix[row][col + 1], row, col + 1});
            }
        }
        return result;
    }
}',
    'class Solution {
    fun kthSmallest(matrix: Array<IntArray>, k: Int): Int {
        val n = matrix.size
        val heap = PriorityQueue<Triple<Int, Int, Int>>(compareBy { it.first })
        for (i in 0 until minOf(n, k)) {
            heap.offer(Triple(matrix[i][0], i, 0))
        }
        var result = 0
        repeat(k) {
            val (value, row, col) = heap.poll()
            result = value
            if (col + 1 < n) {
                heap.offer(Triple(matrix[row][col + 1], row, col + 1))
            }
        }
        return result
    }
}',
    '## Solution: Min Heap

Time Complexity: O(k log n)
Space Complexity: O(n)

Use heap to efficiently extract smallest elements.',
    'MEDIUM',
    'array,heap,binary-search,matrix,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,5,9],[10,11,13],[12,13,15]],8', '13', FALSE),
    (LAST_INSERT_ID(), '[[-5]],1', '-5', FALSE);

-- Problem 6: K Closest Points to Origin (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'HEAPS',
    'K Closest Points to Origin',
    '# K Closest Points to Origin

Given array of points, return k closest points to origin (0, 0).

**Example:**
```
Input: points = [[1,3],[-2,2]], k = 1
Output: [[-2,2]]
```',
    'Hint 1: Use max-heap of size k with distance comparison.
---
Hint 2: Distance = x² + y² (no need for sqrt).
---
Hint 3: Keep k smallest distances in heap.',
    'class Solution {
    public int[][] kClosest(int[][] points, int k) {
        PriorityQueue<int[]> heap = new PriorityQueue<>((a, b) ->
            (b[0] * b[0] + b[1] * b[1]) - (a[0] * a[0] + a[1] * a[1])
        );
        for (int[] point : points) {
            heap.offer(point);
            if (heap.size() > k) {
                heap.poll();
            }
        }
        int[][] result = new int[k][2];
        for (int i = 0; i < k; i++) {
            result[i] = heap.poll();
        }
        return result;
    }
}',
    'class Solution {
    fun kClosest(points: Array<IntArray>, k: Int): Array<IntArray> {
        val heap = PriorityQueue<IntArray>(compareByDescending { it[0] * it[0] + it[1] * it[1] })
        for (point in points) {
            heap.offer(point)
            if (heap.size > k) {
                heap.poll()
            }
        }
        return Array(k) { heap.poll() }
    }
}',
    '## Solution: Max Heap

Time Complexity: O(n log k)
Space Complexity: O(k)

Maintain k closest points using max-heap.',
    'MEDIUM',
    'array,heap,geometry,sorting,divide-and-conquer,quickselect'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,3],[-2,2]],1', '[[-2,2]]', FALSE),
    (LAST_INSERT_ID(), '[[3,3],[5,-1],[-2,4]],2', '[[3,3],[-2,4]]', FALSE);

-- Problem 7: Reorganize String (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'HEAPS',
    'Reorganize String',
    '# Reorganize String

Rearrange string so no two adjacent characters are the same.

**Example:**
```
Input: s = "aab"
Output: "aba"
```',
    'Hint 1: Use max-heap based on character frequency.
---
Hint 2: Always pick most frequent character not used last.
---
Hint 3: Check if reorganization possible (maxFreq <= (n+1)/2).',
    'class Solution {
    public String reorganizeString(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - ''a'']++;
        }
        PriorityQueue<int[]> heap = new PriorityQueue<>((a, b) -> b[1] - a[1]);
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0) {
                heap.offer(new int[]{i, count[i]});
            }
        }
        StringBuilder result = new StringBuilder();
        int[] prev = new int[]{-1, 0};
        while (!heap.isEmpty()) {
            int[] curr = heap.poll();
            result.append((char) (curr[0] + ''a''));
            if (prev[1] > 0) {
                heap.offer(prev);
            }
            curr[1]--;
            prev = curr;
        }
        return result.length() == s.length() ? result.toString() : "";
    }
}',
    'class Solution {
    fun reorganizeString(s: String): String {
        val count = IntArray(26)
        for (c in s) {
            count[c - ''a'']++
        }
        val heap = PriorityQueue<Pair<Int, Int>>(compareByDescending { it.second })
        for (i in 0..25) {
            if (count[i] > 0) {
                heap.offer(i to count[i])
            }
        }
        val result = StringBuilder()
        var prev: Pair<Int, Int>? = null
        while (heap.isNotEmpty()) {
            val curr = heap.poll()
            result.append(''a'' + curr.first)
            prev?.let { if (it.second > 0) heap.offer(it) }
            prev = curr.first to curr.second - 1
        }
        return if (result.length == s.length) result.toString() else ""
    }
}',
    '## Solution: Greedy with Max Heap

Time Complexity: O(n log 26) = O(n)
Space Complexity: O(1)

Place most frequent characters with gaps.',
    'MEDIUM',
    'string,greedy,heap,hash-table,sorting,counting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'aab', 'aba', FALSE),
    (LAST_INSERT_ID(), 'aaab', '', FALSE);

-- Problem 8: Ugly Number II (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'HEAPS',
    'Ugly Number II',
    '# Ugly Number II

Ugly numbers have only prime factors 2, 3, and 5. Find the nth ugly number.

**Example:**
```
Input: n = 10
Output: 12
Explanation: 1,2,3,4,5,6,8,9,10,12
```',
    'Hint 1: Use min-heap, starting with 1.
---
Hint 2: For each ugly number, generate next by multiplying with 2, 3, 5.
---
Hint 3: Use set to avoid duplicates.',
    'class Solution {
    public int nthUglyNumber(int n) {
        PriorityQueue<Long> heap = new PriorityQueue<>();
        Set<Long> seen = new HashSet<>();
        heap.offer(1L);
        seen.add(1L);
        long ugly = 1;
        for (int i = 0; i < n; i++) {
            ugly = heap.poll();
            for (int factor : new int[]{2, 3, 5}) {
                long next = ugly * factor;
                if (seen.add(next)) {
                    heap.offer(next);
                }
            }
        }
        return (int) ugly;
    }
}',
    'class Solution {
    fun nthUglyNumber(n: Int): Int {
        val heap = PriorityQueue<Long>()
        val seen = mutableSetOf<Long>()
        heap.offer(1L)
        seen.add(1L)
        var ugly = 1L
        repeat(n) {
            ugly = heap.poll()
            for (factor in listOf(2, 3, 5)) {
                val next = ugly * factor
                if (seen.add(next)) {
                    heap.offer(next)
                }
            }
        }
        return ugly.toInt()
    }
}',
    '## Solution: Min Heap with Set

Time Complexity: O(n log n)
Space Complexity: O(n)

Generate ugly numbers in order using heap.',
    'MEDIUM',
    'heap,hash-table,math,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '10', '12', FALSE),
    (LAST_INSERT_ID(), '1', '1', FALSE);

-- Problem 9: Minimum Cost to Hire K Workers (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'HEAPS',
    'Minimum Cost to Hire K Workers',
    '# Minimum Cost to Hire K Workers

Given quality and wage arrays, hire exactly k workers maintaining wage/quality ratio. Minimize cost.

**Example:**
```
Input: quality = [10,20,5], wage = [70,50,30], k = 2
Output: 105.00000
```',
    'Hint 1: Sort workers by wage/quality ratio.
---
Hint 2: Use max-heap to track k smallest qualities.
---
Hint 3: Calculate cost using current ratio and quality sum.',
    'class Solution {
    public double mincostToHireWorkers(int[] quality, int[] wage, int k) {
        int n = quality.length;
        double[][] workers = new double[n][2];
        for (int i = 0; i < n; i++) {
            workers[i] = new double[]{(double) wage[i] / quality[i], (double) quality[i]};
        }
        Arrays.sort(workers, (a, b) -> Double.compare(a[0], b[0]));
        PriorityQueue<Double> heap = new PriorityQueue<>((a, b) -> Double.compare(b, a));
        double qualitySum = 0, minCost = Double.MAX_VALUE;
        for (double[] worker : workers) {
            qualitySum += worker[1];
            heap.offer(worker[1]);
            if (heap.size() > k) {
                qualitySum -= heap.poll();
            }
            if (heap.size() == k) {
                minCost = Math.min(minCost, qualitySum * worker[0]);
            }
        }
        return minCost;
    }
}',
    'class Solution {
    fun mincostToHireWorkers(quality: IntArray, wage: IntArray, k: Int): Double {
        val n = quality.size
        val workers = Array(n) { i ->
            doubleArrayOf(wage[i].toDouble() / quality[i], quality[i].toDouble())
        }
        workers.sortBy { it[0] }
        val heap = PriorityQueue<Double>(reverseOrder())
        var qualitySum = 0.0
        var minCost = Double.MAX_VALUE
        for ((ratio, qual) in workers) {
            qualitySum += qual
            heap.offer(qual)
            if (heap.size > k) {
                qualitySum -= heap.poll()
            }
            if (heap.size == k) {
                minCost = minOf(minCost, qualitySum * ratio)
            }
        }
        return minCost
    }
}',
    '## Solution: Sort + Max Heap

Time Complexity: O(n log n)
Space Complexity: O(n)

Maintain k smallest qualities at each ratio.',
    'HARD',
    'array,heap,greedy,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[10,20,5],[70,50,30],2', '105.0', FALSE);

-- Problem 10: IPO (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'HEAPS',
    'IPO',
    '# IPO

Given k projects with profit and capital requirements, maximize capital (can do at most k projects).

**Example:**
```
Input: k = 2, w = 0, profits = [1,2,3], capital = [0,1,1]
Output: 4
```',
    'Hint 1: Sort projects by capital requirement.
---
Hint 2: Use max-heap for available projects (by profit).
---
Hint 3: Greedily pick highest profit project you can afford.',
    'class Solution {
    public int findMaximizedCapital(int k, int w, int[] profits, int[] capital) {
        int n = profits.length;
        int[][] projects = new int[n][2];
        for (int i = 0; i < n; i++) {
            projects[i] = new int[]{capital[i], profits[i]};
        }
        Arrays.sort(projects, (a, b) -> a[0] - b[0]);
        PriorityQueue<Integer> heap = new PriorityQueue<>((a, b) -> b - a);
        int i = 0;
        for (int j = 0; j < k; j++) {
            while (i < n && projects[i][0] <= w) {
                heap.offer(projects[i][1]);
                i++;
            }
            if (heap.isEmpty()) break;
            w += heap.poll();
        }
        return w;
    }
}',
    'class Solution {
    fun findMaximizedCapital(k: Int, w: Int, profits: IntArray, capital: IntArray): Int {
        val n = profits.size
        val projects = Array(n) { i -> intArrayOf(capital[i], profits[i]) }
        projects.sortBy { it[0] }
        val heap = PriorityQueue<Int>(reverseOrder())
        var currentCapital = w
        var i = 0
        repeat(k) {
            while (i < n && projects[i][0] <= currentCapital) {
                heap.offer(projects[i][1])
                i++
            }
            if (heap.isEmpty()) return currentCapital
            currentCapital += heap.poll()
        }
        return currentCapital
    }
}',
    '## Solution: Greedy with Heap

Time Complexity: O(n log n)
Space Complexity: O(n)

Sort by capital, greedily pick max profit.',
    'HARD',
    'array,heap,greedy,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '2,0,[1,2,3],[0,1,1]', '4', FALSE);

-- Additional 15 heap problems (without full solutions)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'LEETCODE', 'HEAPS', 'Last Stone Weight', '# Last Stone Weight

Smash two heaviest stones. If different weights, one remains. Find last stone weight.

**Example:**
```
Input: stones = [2,7,4,1,8,1]
Output: 1
```', 'Hint 1: Use max-heap.
---
Hint 2: Extract two largest, add difference back.
---
Hint 3: Continue until 0 or 1 stone remains.', 'EASY', 'array,heap'),

('ALGO', 'AMAZON', 'HEAPS', 'Kth Largest Element in a Stream', '# Kth Largest Element in a Stream

Design class to find kth largest element in a stream.

**Example:**
```
Input: k = 3, arr = [4,5,8,2]
Output: [4,5,5,5,8]
```', 'Hint 1: Maintain min-heap of size k.
---
Hint 2: Heap top is always kth largest.
---
Hint 3: Add element, remove if size > k.', 'EASY', 'heap,design,tree,binary-search-tree,binary-tree,data-stream'),

('ALGO', 'GOOGLE', 'HEAPS', 'Sort Characters By Frequency', '# Sort Characters By Frequency

Sort characters by frequency (descending).

**Example:**
```
Input: s = "tree"
Output: "eert"
```', 'Hint 1: Count character frequencies.
---
Hint 2: Use max-heap or bucket sort.
---
Hint 3: Build result from most to least frequent.', 'MEDIUM', 'string,heap,hash-table,sorting,bucket-sort,counting'),

('ALGO', 'META', 'HEAPS', 'Task Scheduler II', '# Task Scheduler II

Complete tasks with space requirement between same tasks. Find minimum days.

**Example:**
```
Input: tasks = [1,2,1,2,3,1], space = 3
Output: 9
```', 'Hint 1: Track last completion day of each task.
---
Hint 2: For each task, check if enough days passed.
---
Hint 3: Use HashMap to store last day.', 'MEDIUM', 'array,heap,hash-table,simulation'),

('ALGO', 'LEETCODE', 'HEAPS', 'Find K Pairs with Smallest Sums', '# Find K Pairs with Smallest Sums

Find k pairs (u, v) with smallest sums from two arrays.

**Example:**
```
Input: nums1 = [1,7,11], nums2 = [2,4,6], k = 3
Output: [[1,2],[1,4],[1,6]]
```', 'Hint 1: Start with (nums1[0], nums2[0]).
---
Hint 2: Use min-heap with sum as priority.
---
Hint 3: For each pair, consider next pairs.', 'MEDIUM', 'array,heap'),

('ALGO', 'AMAZON', 'HEAPS', 'Kth Smallest Prime Fraction', '# Kth Smallest Prime Fraction

Given sorted array, find kth smallest fraction arr[i]/arr[j] where i < j.

**Example:**
```
Input: arr = [1,2,3,5], k = 3
Output: [2,5]
```', 'Hint 1: Use min-heap with fractions.
---
Hint 2: Start with arr[i]/arr[n-1] for all i.
---
Hint 3: For each extracted, add arr[i]/arr[j-1].', 'MEDIUM', 'array,heap,binary-search,sorting'),

('ALGO', 'GOOGLE', 'HEAPS', 'Smallest Range Covering Elements from K Lists', '# Smallest Range Covering Elements from K Lists

Find smallest range that includes at least one number from each list.

**Example:**
```
Input: nums = [[4,10,15,24,26],[0,9,12,20],[5,18,22,30]]
Output: [20,24]
```', 'Hint 1: Use min-heap with one element from each list.
---
Hint 2: Track current max in range.
---
Hint 3: Move min forward, update range.', 'HARD', 'array,heap,greedy,hash-table,sliding-window,sorting'),

('ALGO', 'META', 'HEAPS', 'Super Ugly Number', '# Super Ugly Number

Ugly numbers have only given prime factors. Find nth ugly number.

**Example:**
```
Input: n = 12, primes = [2,7,13,19]
Output: 32
```', 'Hint 1: Similar to Ugly Number II.
---
Hint 2: Use heap with all prime factors.
---
Hint 3: Generate multiples of each prime.', 'MEDIUM', 'array,heap,hash-table,math,dynamic-programming'),

('ALGO', 'LEETCODE', 'HEAPS', 'Sliding Window Median', '# Sliding Window Median

Find median of each sliding window of size k.

**Example:**
```
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [1.0,-1.0,-1.0,3.0,5.0,6.0]
```', 'Hint 1: Use two heaps like Find Median from Data Stream.
---
Hint 2: Handle removals efficiently.
---
Hint 3: Use lazy deletion with counters.', 'HARD', 'array,heap,sliding-window'),

('ALGO', 'AMAZON', 'HEAPS', 'The Skyline Problem', '# The Skyline Problem

Given building positions, find skyline (key points).

**Example:**
```
Input: buildings = [[2,9,10],[3,7,15],[5,12,12]]
Output: [[2,10],[3,15],[7,12],[12,0]]
```', 'Hint 1: Process building edges (start/end).
---
Hint 2: Use multiset or heap for active heights.
---
Hint 3: Output when max height changes.', 'HARD', 'array,heap,divide-and-conquer,binary-indexed-tree,segment-tree,line-sweep,ordered-set'),

('ALGO', 'GOOGLE', 'HEAPS', 'Maximum Performance of a Team', '# Maximum Performance of a Team

Select at most k engineers to maximize performance (min efficiency × sum speed).

**Example:**
```
Input: n = 6, speed = [2,10,3,1,5,8], efficiency = [5,4,3,9,7,2], k = 2
Output: 60
```', 'Hint 1: Sort by efficiency descending.
---
Hint 2: For each engineer as min efficiency, pick k-1 fastest.
---
Hint 3: Use min-heap for speeds.', 'HARD', 'array,heap,greedy,sorting'),

('ALGO', 'META', 'HEAPS', 'Maximum Subsequence Score', '# Maximum Subsequence Score

Select k indices to maximize (sum of nums1) * (min of nums2).

**Example:**
```
Input: nums1 = [1,3,3,2], nums2 = [2,1,3,4], k = 3
Output: 12
```', 'Hint 1: Sort by nums2 descending.
---
Hint 2: Use min-heap for nums1 values.
---
Hint 3: Track sum and multiply by current min nums2.', 'MEDIUM', 'array,heap,greedy,sorting'),

('ALGO', 'LEETCODE', 'HEAPS', 'Process Tasks Using Servers', '# Process Tasks Using Servers

Assign tasks to servers with weights. Find which server processes each task.

**Example:**
```
Input: servers = [3,3,2], tasks = [1,2,3,2,1,2]
Output: [2,2,0,2,1,2]
```', 'Hint 1: Use two heaps: available and busy servers.
---
Hint 2: Track when busy servers become free.
---
Hint 3: Process by time, moving servers between heaps.', 'MEDIUM', 'array,heap,simulation'),

('ALGO', 'AMAZON', 'HEAPS', 'Maximum Number of Events Attended', '# Maximum Number of Events That Can Be Attended

Given events [startDay, endDay], attend maximum number (one per day).

**Example:**
```
Input: events = [[1,2],[2,3],[3,4]]
Output: 3
```', 'Hint 1: Sort events by start day.
---
Hint 2: Use min-heap for end days of active events.
---
Hint 3: Greedily attend earliest ending event each day.', 'MEDIUM', 'array,heap,greedy,sorting'),

('ALGO', 'GOOGLE', 'HEAPS', 'Single-Threaded CPU', '# Single-Threaded CPU

Schedule tasks on single-threaded CPU. Return order of task indices.

**Example:**
```
Input: tasks = [[1,2],[2,4],[3,2],[4,1]]
Output: [0,2,3,1]
```', 'Hint 1: Sort tasks by arrival time.
---
Hint 2: Use min-heap ordered by processing time.
---
Hint 3: Process available tasks, advance time if none.', 'MEDIUM', 'array,heap,sorting');
