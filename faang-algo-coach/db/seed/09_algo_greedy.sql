-- Greedy Arena - 25 Problems (10 with full solutions)

USE faang;

-- Problem 1: Jump Game (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'GREEDY',
    'Jump Game',
    '# Jump Game

Given array where nums[i] represents max jump length from position i, determine if you can reach the last index.

**Example:**
```
Input: nums = [2,3,1,1,4]
Output: true
Explanation: Jump 1 step from 0 to 1, then 3 steps to last
```',
    'Hint 1: Track the furthest index reachable.
---
Hint 2: At each position, update max reachable.
---
Hint 3: If max reachable >= last index, return true.',
    'class Solution {
    public boolean canJump(int[] nums) {
        int maxReach = 0;
        for (int i = 0; i < nums.length; i++) {
            if (i > maxReach) return false;
            maxReach = Math.max(maxReach, i + nums[i]);
            if (maxReach >= nums.length - 1) return true;
        }
        return true;
    }
}',
    'class Solution {
    fun canJump(nums: IntArray): Boolean {
        var maxReach = 0
        for (i in nums.indices) {
            if (i > maxReach) return false
            maxReach = maxOf(maxReach, i + nums[i])
            if (maxReach >= nums.size - 1) return true
        }
        return true
    }
}',
    '## Solution: Greedy

Time Complexity: O(n)
Space Complexity: O(1)

Greedily track maximum reachable position.',
    'MEDIUM',
    'array,greedy,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[2,3,1,1,4]', 'true', FALSE),
    (LAST_INSERT_ID(), '[3,2,1,0,4]', 'false', FALSE);

-- Problem 2: Meeting Rooms II (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'GREEDY',
    'Meeting Rooms II',
    '# Meeting Rooms II

Given array of meeting intervals, find minimum number of conference rooms required.

**Example:**
```
Input: intervals = [[0,30],[5,10],[15,20]]
Output: 2
```',
    'Hint 1: Sort meetings by start time.
---
Hint 2: Use min-heap to track end times of ongoing meetings.
---
Hint 3: If new meeting starts after earliest ending, reuse room.',
    'class Solution {
    public int minMeetingRooms(int[][] intervals) {
        if (intervals == null || intervals.length == 0) return 0;
        Arrays.sort(intervals, (a, b) -> a[0] - b[0]);
        PriorityQueue<Integer> heap = new PriorityQueue<>();
        heap.offer(intervals[0][1]);
        for (int i = 1; i < intervals.length; i++) {
            if (intervals[i][0] >= heap.peek()) {
                heap.poll();
            }
            heap.offer(intervals[i][1]);
        }
        return heap.size();
    }
}',
    'class Solution {
    fun minMeetingRooms(intervals: Array<IntArray>): Int {
        if (intervals.isEmpty()) return 0
        intervals.sortBy { it[0] }
        val heap = PriorityQueue<Int>()
        heap.offer(intervals[0][1])
        for (i in 1 until intervals.size) {
            if (intervals[i][0] >= heap.peek()) {
                heap.poll()
            }
            heap.offer(intervals[i][1])
        }
        return heap.size
    }
}',
    '## Solution: Min Heap

Time Complexity: O(n log n)
Space Complexity: O(n)

Use heap to efficiently track available rooms.',
    'MEDIUM',
    'array,greedy,heap,sorting,two-pointers'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[0,30],[5,10],[15,20]]', '2', FALSE),
    (LAST_INSERT_ID(), '[[7,10],[2,4]]', '1', FALSE);

-- Problem 3: Non-overlapping Intervals (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'GREEDY',
    'Non-overlapping Intervals',
    '# Non-overlapping Intervals

Given array of intervals, return minimum number of intervals to remove to make rest non-overlapping.

**Example:**
```
Input: intervals = [[1,2],[2,3],[3,4],[1,3]]
Output: 1
Explanation: Remove [1,3]
```',
    'Hint 1: Sort by end time.
---
Hint 2: Greedily keep intervals that end earliest.
---
Hint 3: Count overlaps to remove.',
    'class Solution {
    public int eraseOverlapIntervals(int[][] intervals) {
        if (intervals.length == 0) return 0;
        Arrays.sort(intervals, (a, b) -> a[1] - b[1]);
        int end = intervals[0][1];
        int count = 0;
        for (int i = 1; i < intervals.length; i++) {
            if (intervals[i][0] < end) {
                count++;
            } else {
                end = intervals[i][1];
            }
        }
        return count;
    }
}',
    'class Solution {
    fun eraseOverlapIntervals(intervals: Array<IntArray>): Int {
        if (intervals.isEmpty()) return 0
        intervals.sortBy { it[1] }
        var end = intervals[0][1]
        var count = 0
        for (i in 1 until intervals.size) {
            if (intervals[i][0] < end) {
                count++
            } else {
                end = intervals[i][1]
            }
        }
        return count
    }
}',
    '## Solution: Greedy Interval Selection

Time Complexity: O(n log n)
Space Complexity: O(1)

Keep intervals ending earliest to maximize room for others.',
    'MEDIUM',
    'array,greedy,sorting,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,2],[2,3],[3,4],[1,3]]', '1', FALSE),
    (LAST_INSERT_ID(), '[[1,2],[1,2],[1,2]]', '2', FALSE);

-- Problem 4: Partition Labels (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'GREEDY',
    'Partition Labels',
    '# Partition Labels

Partition string into as many parts as possible such that each letter appears in at most one part.

**Example:**
```
Input: s = "ababcbacadefegdehijhklij"
Output: [9,7,8]
Explanation: "ababcbaca", "defegde", "hijhklij"
```',
    'Hint 1: Track last occurrence of each character.
---
Hint 2: Expand current partition to include last occurrence.
---
Hint 3: Create new partition when reaching end of current.',
    'class Solution {
    public List<Integer> partitionLabels(String s) {
        int[] last = new int[26];
        for (int i = 0; i < s.length(); i++) {
            last[s.charAt(i) - ''a''] = i;
        }
        List<Integer> result = new ArrayList<>();
        int start = 0, end = 0;
        for (int i = 0; i < s.length(); i++) {
            end = Math.max(end, last[s.charAt(i) - ''a'']);
            if (i == end) {
                result.add(end - start + 1);
                start = i + 1;
            }
        }
        return result;
    }
}',
    'class Solution {
    fun partitionLabels(s: String): List<Int> {
        val last = IntArray(26)
        for (i in s.indices) {
            last[s[i] - ''a''] = i
        }
        val result = mutableListOf<Int>()
        var start = 0
        var end = 0
        for (i in s.indices) {
            end = maxOf(end, last[s[i] - ''a''])
            if (i == end) {
                result.add(end - start + 1)
                start = i + 1
            }
        }
        return result
    }
}',
    '## Solution: Greedy with Last Occurrence

Time Complexity: O(n)
Space Complexity: O(1)

Track last position, extend partition greedily.',
    'MEDIUM',
    'string,greedy,hash-table,two-pointers'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'ababcbacadefegdehijhklij', '[9,7,8]', FALSE),
    (LAST_INSERT_ID(), 'eccbbbbdec', '[10]', FALSE);

-- Problem 5: Gas Station (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'GREEDY',
    'Gas Station',
    '# Gas Station

Given gas and cost arrays (circular route), find starting station to complete circuit, or -1 if impossible.

**Example:**
```
Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
Output: 3
```',
    'Hint 1: If total gas < total cost, impossible.
---
Hint 2: Track current tank balance.
---
Hint 3: If tank goes negative, start from next station.',
    'class Solution {
    public int canCompleteCircuit(int[] gas, int[] cost) {
        int totalGas = 0, totalCost = 0;
        int tank = 0, start = 0;
        for (int i = 0; i < gas.length; i++) {
            totalGas += gas[i];
            totalCost += cost[i];
            tank += gas[i] - cost[i];
            if (tank < 0) {
                start = i + 1;
                tank = 0;
            }
        }
        return totalGas >= totalCost ? start : -1;
    }
}',
    'class Solution {
    fun canCompleteCircuit(gas: IntArray, cost: IntArray): Int {
        var totalGas = 0
        var totalCost = 0
        var tank = 0
        var start = 0
        for (i in gas.indices) {
            totalGas += gas[i]
            totalCost += cost[i]
            tank += gas[i] - cost[i]
            if (tank < 0) {
                start = i + 1
                tank = 0
            }
        }
        return if (totalGas >= totalCost) start else -1
    }
}',
    '## Solution: Greedy One Pass

Time Complexity: O(n)
Space Complexity: O(1)

Key insight: if total gas >= cost, solution exists.',
    'MEDIUM',
    'array,greedy'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3,4,5],[3,4,5,1,2]', '3', FALSE),
    (LAST_INSERT_ID(), '[2,3,4],[3,4,3]', '-1', FALSE);

-- Problem 6: Task Scheduler (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'GREEDY',
    'Task Scheduler',
    '# Task Scheduler

Given tasks and cooldown period n, find minimum time to complete all tasks (same task needs n gaps).

**Example:**
```
Input: tasks = ["A","A","A","B","B","B"], n = 2
Output: 8
Explanation: A→B→idle→A→B→idle→A→B
```',
    'Hint 1: Most frequent task determines minimum time.
---
Hint 2: Calculate idle slots needed.
---
Hint 3: Fill idle slots with other tasks.',
    'class Solution {
    public int leastInterval(char[] tasks, int n) {
        int[] freq = new int[26];
        for (char task : tasks) {
            freq[task - ''A'']++;
        }
        Arrays.sort(freq);
        int maxFreq = freq[25];
        int idleSlots = (maxFreq - 1) * n;
        for (int i = 24; i >= 0 && idleSlots > 0; i--) {
            idleSlots -= Math.min(maxFreq - 1, freq[i]);
        }
        idleSlots = Math.max(0, idleSlots);
        return tasks.length + idleSlots;
    }
}',
    'class Solution {
    fun leastInterval(tasks: CharArray, n: Int): Int {
        val freq = IntArray(26)
        for (task in tasks) {
            freq[task - ''A'']++
        }
        freq.sort()
        val maxFreq = freq[25]
        var idleSlots = (maxFreq - 1) * n
        for (i in 24 downTo 0) {
            if (idleSlots <= 0) break
            idleSlots -= minOf(maxFreq - 1, freq[i])
        }
        idleSlots = maxOf(0, idleSlots)
        return tasks.size + idleSlots
    }
}',
    '## Solution: Greedy Scheduling

Time Complexity: O(n)
Space Complexity: O(1)

Calculate idle time based on most frequent task.',
    'MEDIUM',
    'array,hash-table,greedy,heap,counting,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[A,A,A,B,B,B],2', '8', FALSE),
    (LAST_INSERT_ID(), '[A,A,A,B,B,B],0', '6', FALSE);

-- Problem 7: Merge Intervals (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'GREEDY',
    'Merge Intervals',
    '# Merge Intervals

Given array of intervals, merge all overlapping intervals.

**Example:**
```
Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
Output: [[1,6],[8,10],[15,18]]
```',
    'Hint 1: Sort intervals by start time.
---
Hint 2: Merge if current overlaps with previous.
---
Hint 3: Update end to maximum of both ends.',
    'class Solution {
    public int[][] merge(int[][] intervals) {
        if (intervals.length <= 1) return intervals;
        Arrays.sort(intervals, (a, b) -> a[0] - b[0]);
        List<int[]> result = new ArrayList<>();
        int[] current = intervals[0];
        for (int i = 1; i < intervals.length; i++) {
            if (intervals[i][0] <= current[1]) {
                current[1] = Math.max(current[1], intervals[i][1]);
            } else {
                result.add(current);
                current = intervals[i];
            }
        }
        result.add(current);
        return result.toArray(new int[result.size()][]);
    }
}',
    'class Solution {
    fun merge(intervals: Array<IntArray>): Array<IntArray> {
        if (intervals.size <= 1) return intervals
        intervals.sortBy { it[0] }
        val result = mutableListOf<IntArray>()
        var current = intervals[0]
        for (i in 1 until intervals.size) {
            if (intervals[i][0] <= current[1]) {
                current[1] = maxOf(current[1], intervals[i][1])
            } else {
                result.add(current)
                current = intervals[i]
            }
        }
        result.add(current)
        return result.toTypedArray()
    }
}',
    '## Solution: Sort and Merge

Time Complexity: O(n log n)
Space Complexity: O(n)

Sort then greedily merge overlapping intervals.',
    'MEDIUM',
    'array,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,3],[2,6],[8,10],[15,18]]', '[[1,6],[8,10],[15,18]]', FALSE),
    (LAST_INSERT_ID(), '[[1,4],[4,5]]', '[[1,5]]', FALSE);

-- Problem 8: Insert Interval (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'GREEDY',
    'Insert Interval',
    '# Insert Interval

Insert newInterval into sorted non-overlapping intervals, merging if necessary.

**Example:**
```
Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
Output: [[1,5],[6,9]]
```',
    'Hint 1: Add all intervals before newInterval.
---
Hint 2: Merge all overlapping intervals with newInterval.
---
Hint 3: Add all intervals after newInterval.',
    'class Solution {
    public int[][] insert(int[][] intervals, int[] newInterval) {
        List<int[]> result = new ArrayList<>();
        int i = 0, n = intervals.length;
        while (i < n && intervals[i][1] < newInterval[0]) {
            result.add(intervals[i++]);
        }
        while (i < n && intervals[i][0] <= newInterval[1]) {
            newInterval[0] = Math.min(newInterval[0], intervals[i][0]);
            newInterval[1] = Math.max(newInterval[1], intervals[i][1]);
            i++;
        }
        result.add(newInterval);
        while (i < n) {
            result.add(intervals[i++]);
        }
        return result.toArray(new int[result.size()][]);
    }
}',
    'class Solution {
    fun insert(intervals: Array<IntArray>, newInterval: IntArray): Array<IntArray> {
        val result = mutableListOf<IntArray>()
        var i = 0
        val n = intervals.size
        while (i < n && intervals[i][1] < newInterval[0]) {
            result.add(intervals[i++])
        }
        while (i < n && intervals[i][0] <= newInterval[1]) {
            newInterval[0] = minOf(newInterval[0], intervals[i][0])
            newInterval[1] = maxOf(newInterval[1], intervals[i][1])
            i++
        }
        result.add(newInterval)
        while (i < n) {
            result.add(intervals[i++])
        }
        return result.toTypedArray()
    }
}',
    '## Solution: Three-Phase Insertion

Time Complexity: O(n)
Space Complexity: O(n)

Process in three phases: before, merge, after.',
    'MEDIUM',
    'array'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,3],[6,9]],[2,5]', '[[1,5],[6,9]]', FALSE),
    (LAST_INSERT_ID(), '[[1,2],[3,5],[6,7],[8,10],[12,16]],[4,8]', '[[1,2],[3,10],[12,16]]', FALSE);

-- Problem 9: Best Time to Buy and Sell Stock II (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'GREEDY',
    'Best Time to Buy and Sell Stock II',
    '# Best Time to Buy and Sell Stock II

You can complete as many transactions as you like. Find maximum profit.

**Example:**
```
Input: prices = [7,1,5,3,6,4]
Output: 7
Explanation: Buy day 2, sell day 3 (+4), buy day 4, sell day 5 (+3)
```',
    'Hint 1: Capture every upward price movement.
---
Hint 2: Add profit for each increasing consecutive pair.
---
Hint 3: Greedy: buy before every increase.',
    'class Solution {
    public int maxProfit(int[] prices) {
        int profit = 0;
        for (int i = 1; i < prices.length; i++) {
            if (prices[i] > prices[i - 1]) {
                profit += prices[i] - prices[i - 1];
            }
        }
        return profit;
    }
}',
    'class Solution {
    fun maxProfit(prices: IntArray): Int {
        var profit = 0
        for (i in 1 until prices.size) {
            if (prices[i] > prices[i - 1]) {
                profit += prices[i] - prices[i - 1]
            }
        }
        return profit
    }
}',
    '## Solution: Greedy Peak-Valley

Time Complexity: O(n)
Space Complexity: O(1)

Add every positive difference.',
    'MEDIUM',
    'array,greedy,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[7,1,5,3,6,4]', '7', FALSE),
    (LAST_INSERT_ID(), '[1,2,3,4,5]', '4', FALSE);

-- Problem 10: Queue Reconstruction by Height (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'GREEDY',
    'Queue Reconstruction by Height',
    '# Queue Reconstruction by Height

people[i] = [hi, ki] where hi is height and ki is number of people in front with height >= hi. Reconstruct queue.

**Example:**
```
Input: people = [[7,0],[4,4],[7,1],[5,0],[6,1],[5,2]]
Output: [[5,0],[7,0],[5,2],[6,1],[4,4],[7,1]]
```',
    'Hint 1: Sort by height descending, then by k ascending.
---
Hint 2: Insert each person at position k.
---
Hint 3: Taller people inserted first don''t affect k for shorter.',
    'class Solution {
    public int[][] reconstructQueue(int[][] people) {
        Arrays.sort(people, (a, b) -> a[0] == b[0] ? a[1] - b[1] : b[0] - a[0]);
        List<int[]> result = new ArrayList<>();
        for (int[] person : people) {
            result.add(person[1], person);
        }
        return result.toArray(new int[people.length][]);
    }
}',
    'class Solution {
    fun reconstructQueue(people: Array<IntArray>): Array<IntArray> {
        people.sortWith(compareBy({ -it[0] }, { it[1] }))
        val result = mutableListOf<IntArray>()
        for (person in people) {
            result.add(person[1], person)
        }
        return result.toTypedArray()
    }
}',
    '## Solution: Sort and Insert

Time Complexity: O(n²)
Space Complexity: O(n)

Process tallest first, insert at k position.',
    'MEDIUM',
    'array,greedy,sorting,binary-indexed-tree,segment-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[7,0],[4,4],[7,1],[5,0],[6,1],[5,2]]', '[[5,0],[7,0],[5,2],[6,1],[4,4],[7,1]]', FALSE);

-- Additional 15 greedy problems (without full solutions)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'LEETCODE', 'GREEDY', 'Assign Cookies', '# Assign Cookies

Assign cookies to children to maximize content children.

**Example:**
```
Input: g = [1,2,3], s = [1,1]
Output: 1
```', 'Hint 1: Sort both arrays.
---
Hint 2: Greedily assign smallest satisfying cookie.
---
Hint 3: Use two pointers.', 'EASY', 'array,greedy,sorting,two-pointers'),

('ALGO', 'AMAZON', 'GREEDY', 'Lemonade Change', '# Lemonade Change

Determine if you can provide correct change for all customers (bills are 5, 10, or 20).

**Example:**
```
Input: bills = [5,5,10,10,20]
Output: false
```', 'Hint 1: Track count of $5 and $10 bills.
---
Hint 2: For $10, give $5. For $20, give $10+$5 or $5×3.
---
Hint 3: Prefer giving $10 when possible.', 'EASY', 'array,greedy'),

('ALGO', 'GOOGLE', 'GREEDY', 'Minimum Add to Make Parentheses Valid', '# Minimum Add to Make Parentheses Valid

Find minimum parentheses to add to make string valid.

**Example:**
```
Input: s = "())"
Output: 1
```', 'Hint 1: Track unmatched open and close brackets.
---
Hint 2: Increment open count for (, decrement for ).
---
Hint 3: If open goes negative, need closing brackets.', 'MEDIUM', 'string,greedy,stack'),

('ALGO', 'META', 'GREEDY', 'Minimum Number of Arrows to Burst Balloons', '# Minimum Number of Arrows to Burst Balloons

Find minimum arrows needed to burst all balloons (interval problem).

**Example:**
```
Input: points = [[10,16],[2,8],[1,6],[7,12]]
Output: 2
```', 'Hint 1: Sort by end position.
---
Hint 2: Shoot arrow at end of each group.
---
Hint 3: Similar to interval scheduling.', 'MEDIUM', 'array,greedy,sorting'),

('ALGO', 'LEETCODE', 'GREEDY', 'Remove Duplicate Letters', '# Remove Duplicate Letters

Remove duplicates to get smallest lexicographical string (each letter appears once).

**Example:**
```
Input: s = "bcabc"
Output: "abc"
```', 'Hint 1: Use stack for monotonic increasing result.
---
Hint 2: Track remaining count of each character.
---
Hint 3: Remove larger chars if they appear later.', 'MEDIUM', 'string,greedy,stack,monotonic-stack'),

('ALGO', 'AMAZON', 'GREEDY', 'Wiggle Subsequence', '# Wiggle Subsequence

Find length of longest wiggling subsequence (alternating differences).

**Example:**
```
Input: nums = [1,7,4,9,2,5]
Output: 6
```', 'Hint 1: Track up and down streaks.
---
Hint 2: Greedy: include peaks and valleys.
---
Hint 3: Update based on current trend.', 'MEDIUM', 'array,greedy,dynamic-programming'),

('ALGO', 'GOOGLE', 'GREEDY', 'Reorganize String', '# Reorganize String

Rearrange string so no two adjacent characters are same.

**Example:**
```
Input: s = "aab"
Output: "aba"
```', 'Hint 1: Use max heap for most frequent chars.
---
Hint 2: Greedily place most frequent first.
---
Hint 3: Alternate with second most frequent.', 'MEDIUM', 'string,greedy,heap,hash-table,sorting,counting'),

('ALGO', 'META', 'GREEDY', 'Boats to Save People', '# Boats to Save People

Each boat carries at most 2 people with weight limit. Find minimum boats.

**Example:**
```
Input: people = [3,2,2,1], limit = 3
Output: 3
```', 'Hint 1: Sort people by weight.
---
Hint 2: Two pointers: heaviest and lightest.
---
Hint 3: Pair if sum <= limit, else heaviest alone.', 'MEDIUM', 'array,greedy,two-pointers,sorting'),

('ALGO', 'LEETCODE', 'GREEDY', 'Bag of Tokens', '# Bag of Tokens

Play tokens face-up (spend power, gain score) or face-down (lose score, gain power). Maximize score.

**Example:**
```
Input: tokens = [100,200,300,400], power = 200
Output: 2
```', 'Hint 1: Sort tokens.
---
Hint 2: Play smallest face-up, largest face-down.
---
Hint 3: Use two pointers.', 'MEDIUM', 'array,greedy,two-pointers,sorting'),

('ALGO', 'AMAZON', 'GREEDY', 'Break a Palindrome', '# Break a Palindrome

Replace one character to make string not a palindrome (lexicographically smallest).

**Example:**
```
Input: palindrome = "abccba"
Output: "aaccba"
```', 'Hint 1: Change first non-''a'' to ''a''.
---
Hint 2: If all ''a''s, change last to ''b''.
---
Hint 3: Handle single character edge case.', 'MEDIUM', 'string,greedy'),

('ALGO', 'GOOGLE', 'GREEDY', 'Advantage Shuffle', '# Advantage Shuffle

Rearrange nums1 to maximize points where nums1[i] > nums2[i].

**Example:**
```
Input: nums1 = [2,7,11,15], nums2 = [1,10,4,11]
Output: [2,11,7,15]
```', 'Hint 1: Sort nums1.
---
Hint 2: For each nums2 element, find smallest larger in nums1.
---
Hint 3: Use remaining nums1 for losses.', 'MEDIUM', 'array,greedy,sorting'),

('ALGO', 'META', 'GREEDY', 'Minimum Deletions to Make Character Frequencies Unique', '# Minimum Deletions to Make Character Frequencies Unique

Make all character frequencies unique with minimum deletions.

**Example:**
```
Input: s = "aaabbbcc"
Output: 2
```', 'Hint 1: Count frequencies.
---
Hint 2: Sort frequencies descending.
---
Hint 3: Decrease duplicates to unique values.', 'MEDIUM', 'string,greedy,hash-table,sorting'),

('ALGO', 'LEETCODE', 'GREEDY', 'Remove Covered Intervals', '# Remove Covered Intervals

Remove all intervals that are covered by another. Count remaining.

**Example:**
```
Input: intervals = [[1,4],[3,6],[2,8]]
Output: 2
```', 'Hint 1: Sort by start ascending, end descending.
---
Hint 2: Track maximum end seen.
---
Hint 3: Interval covered if end <= maxEnd.', 'MEDIUM', 'array,sorting'),

('ALGO', 'AMAZON', 'GREEDY', 'Maximum Swap', '# Maximum Swap

Swap two digits at most once to get maximum number.

**Example:**
```
Input: num = 2736
Output: 7236
```', 'Hint 1: Track last occurrence of each digit.
---
Hint 2: From left, find first digit smaller than a later larger digit.
---
Hint 3: Swap with rightmost larger digit.', 'MEDIUM', 'math,greedy'),

('ALGO', 'GOOGLE', 'GREEDY', 'Video Stitching', '# Video Stitching

Stitch video clips to cover [0, time]. Find minimum clips needed.

**Example:**
```
Input: clips = [[0,2],[4,6],[8,10],[1,9],[1,5],[5,9]], time = 10
Output: 3
```', 'Hint 1: Sort clips by start time.
---
Hint 2: Greedily extend coverage as far as possible.
---
Hint 3: Jump to farthest reachable endpoint.', 'MEDIUM', 'array,greedy,dynamic-programming');
