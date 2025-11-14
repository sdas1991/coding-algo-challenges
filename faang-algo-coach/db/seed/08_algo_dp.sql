-- Dynamic Programming Arena - 25 Problems (10 with full solutions)

USE faang;

-- Problem 1: Climbing Stairs (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'DYNAMIC_PROGRAMMING',
    'Climbing Stairs',
    '# Climbing Stairs

You are climbing a staircase with n steps. Each time you can climb 1 or 2 steps. How many distinct ways can you climb to the top?

**Example:**
```
Input: n = 3
Output: 3
Explanation: 1+1+1, 1+2, 2+1
```',
    'Hint 1: This is the Fibonacci sequence.
---
Hint 2: ways(n) = ways(n-1) + ways(n-2).
---
Hint 3: Can optimize space to O(1).',
    'class Solution {
    public int climbStairs(int n) {
        if (n <= 2) return n;
        int prev2 = 1, prev1 = 2;
        for (int i = 3; i <= n; i++) {
            int curr = prev1 + prev2;
            prev2 = prev1;
            prev1 = curr;
        }
        return prev1;
    }
}',
    'class Solution {
    fun climbStairs(n: Int): Int {
        if (n <= 2) return n
        var prev2 = 1
        var prev1 = 2
        for (i in 3..n) {
            val curr = prev1 + prev2
            prev2 = prev1
            prev1 = curr
        }
        return prev1
    }
}',
    '## Solution: Fibonacci Pattern

Time Complexity: O(n)
Space Complexity: O(1)

Classic DP problem with Fibonacci recurrence.',
    'EASY',
    'dynamic-programming,math,memoization'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '2', '2', FALSE),
    (LAST_INSERT_ID(), '3', '3', FALSE),
    (LAST_INSERT_ID(), '5', '8', FALSE);

-- Problem 2: Coin Change (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'DYNAMIC_PROGRAMMING',
    'Coin Change',
    '# Coin Change

Given coins of different denominations and total amount, compute fewest coins needed. Return -1 if impossible.

**Example:**
```
Input: coins = [1,2,5], amount = 11
Output: 3
Explanation: 11 = 5 + 5 + 1
```',
    'Hint 1: DP array where dp[i] = min coins for amount i.
---
Hint 2: For each amount, try all coins.
---
Hint 3: dp[amount] = min(dp[amount - coin] + 1).',
    'class Solution {
    public int coinChange(int[] coins, int amount) {
        int[] dp = new int[amount + 1];
        Arrays.fill(dp, amount + 1);
        dp[0] = 0;
        for (int i = 1; i <= amount; i++) {
            for (int coin : coins) {
                if (i >= coin) {
                    dp[i] = Math.min(dp[i], dp[i - coin] + 1);
                }
            }
        }
        return dp[amount] > amount ? -1 : dp[amount];
    }
}',
    'class Solution {
    fun coinChange(coins: IntArray, amount: Int): Int {
        val dp = IntArray(amount + 1) { amount + 1 }
        dp[0] = 0
        for (i in 1..amount) {
            for (coin in coins) {
                if (i >= coin) {
                    dp[i] = minOf(dp[i], dp[i - coin] + 1)
                }
            }
        }
        return if (dp[amount] > amount) -1 else dp[amount]
    }
}',
    '## Solution: Bottom-Up DP

Time Complexity: O(amount × coins)
Space Complexity: O(amount)

Classic unbounded knapsack variant.',
    'MEDIUM',
    'dynamic-programming,breadth-first-search,array'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,5],11', '3', FALSE),
    (LAST_INSERT_ID(), '[2],3', '-1', FALSE),
    (LAST_INSERT_ID(), '[1],0', '0', FALSE);

-- Problem 3: House Robber (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'DYNAMIC_PROGRAMMING',
    'House Robber',
    '# House Robber

Rob houses along a street. Cannot rob adjacent houses. Maximize amount robbed.

**Example:**
```
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (1) and house 3 (3)
```',
    'Hint 1: For each house, decide: rob it or skip it.
---
Hint 2: dp[i] = max(dp[i-1], dp[i-2] + nums[i]).
---
Hint 3: Space optimize to two variables.',
    'class Solution {
    public int rob(int[] nums) {
        if (nums.length == 0) return 0;
        if (nums.length == 1) return nums[0];
        int prev2 = 0, prev1 = 0;
        for (int num : nums) {
            int curr = Math.max(prev1, prev2 + num);
            prev2 = prev1;
            prev1 = curr;
        }
        return prev1;
    }
}',
    'class Solution {
    fun rob(nums: IntArray): Int {
        if (nums.isEmpty()) return 0
        if (nums.size == 1) return nums[0]
        var prev2 = 0
        var prev1 = 0
        for (num in nums) {
            val curr = maxOf(prev1, prev2 + num)
            prev2 = prev1
            prev1 = curr
        }
        return prev1
    }
}',
    '## Solution: DP with Space Optimization

Time Complexity: O(n)
Space Complexity: O(1)

Classic DP with non-adjacent selection.',
    'MEDIUM',
    'dynamic-programming,array'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3,1]', '4', FALSE),
    (LAST_INSERT_ID(), '[2,7,9,3,1]', '12', FALSE);

-- Problem 4: Longest Common Subsequence (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'DYNAMIC_PROGRAMMING',
    'Longest Common Subsequence',
    '# Longest Common Subsequence

Given two strings, return the length of their longest common subsequence.

**Example:**
```
Input: text1 = "abcde", text2 = "ace"
Output: 3
Explanation: "ace" is LCS
```',
    'Hint 1: 2D DP table: dp[i][j] = LCS of text1[0..i] and text2[0..j].
---
Hint 2: If chars match: dp[i][j] = dp[i-1][j-1] + 1.
---
Hint 3: Else: dp[i][j] = max(dp[i-1][j], dp[i][j-1]).',
    'class Solution {
    public int longestCommonSubsequence(String text1, String text2) {
        int m = text1.length(), n = text2.length();
        int[][] dp = new int[m + 1][n + 1];
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (text1.charAt(i - 1) == text2.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j - 1] + 1;
                } else {
                    dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }
        return dp[m][n];
    }
}',
    'class Solution {
    fun longestCommonSubsequence(text1: String, text2: String): Int {
        val m = text1.length
        val n = text2.length
        val dp = Array(m + 1) { IntArray(n + 1) }
        for (i in 1..m) {
            for (j in 1..n) {
                if (text1[i - 1] == text2[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {
                    dp[i][j] = maxOf(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }
        return dp[m][n]
    }
}',
    '## Solution: 2D DP

Time Complexity: O(m × n)
Space Complexity: O(m × n)

Classic LCS problem with 2D table.',
    'MEDIUM',
    'dynamic-programming,string'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'abcde,ace', '3', FALSE),
    (LAST_INSERT_ID(), 'abc,abc', '3', FALSE),
    (LAST_INSERT_ID(), 'abc,def', '0', FALSE);

-- Problem 5: Longest Increasing Subsequence (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'DYNAMIC_PROGRAMMING',
    'Longest Increasing Subsequence',
    '# Longest Increasing Subsequence

Find length of longest strictly increasing subsequence.

**Example:**
```
Input: nums = [10,9,2,5,3,7,101,18]
Output: 4
Explanation: [2,3,7,101]
```',
    'Hint 1: dp[i] = length of LIS ending at i.
---
Hint 2: For each i, check all j < i where nums[j] < nums[i].
---
Hint 3: Binary search optimization for O(n log n).',
    'class Solution {
    public int lengthOfLIS(int[] nums) {
        int[] dp = new int[nums.length];
        int len = 0;
        for (int num : nums) {
            int i = Arrays.binarySearch(dp, 0, len, num);
            if (i < 0) i = -(i + 1);
            dp[i] = num;
            if (i == len) len++;
        }
        return len;
    }
}',
    'class Solution {
    fun lengthOfLIS(nums: IntArray): Int {
        val dp = IntArray(nums.size)
        var len = 0
        for (num in nums) {
            var i = dp.binarySearch(num, 0, len)
            if (i < 0) i = -(i + 1)
            dp[i] = num
            if (i == len) len++
        }
        return len
    }
}',
    '## Solution: Binary Search DP

Time Complexity: O(n log n)
Space Complexity: O(n)

Maintain array of smallest tails for each length.',
    'MEDIUM',
    'dynamic-programming,binary-search,array'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[10,9,2,5,3,7,101,18]', '4', FALSE),
    (LAST_INSERT_ID(), '[0,1,0,3,2,3]', '4', FALSE),
    (LAST_INSERT_ID(), '[7,7,7,7,7,7,7]', '1', FALSE);

-- Problem 6: Word Break (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'DYNAMIC_PROGRAMMING',
    'Word Break',
    '# Word Break

Given string s and dictionary wordDict, determine if s can be segmented into space-separated dictionary words.

**Example:**
```
Input: s = "leetcode", wordDict = ["leet","code"]
Output: true
```',
    'Hint 1: dp[i] = can segment s[0..i].
---
Hint 2: For each position, check all possible last words.
---
Hint 3: dp[i] = true if any dp[j] && s[j..i] in dict.',
    'class Solution {
    public boolean wordBreak(String s, List<String> wordDict) {
        Set<String> dict = new HashSet<>(wordDict);
        boolean[] dp = new boolean[s.length() + 1];
        dp[0] = true;
        for (int i = 1; i <= s.length(); i++) {
            for (int j = 0; j < i; j++) {
                if (dp[j] && dict.contains(s.substring(j, i))) {
                    dp[i] = true;
                    break;
                }
            }
        }
        return dp[s.length()];
    }
}',
    'class Solution {
    fun wordBreak(s: String, wordDict: List<String>): Boolean {
        val dict = wordDict.toSet()
        val dp = BooleanArray(s.length + 1)
        dp[0] = true
        for (i in 1..s.length) {
            for (j in 0 until i) {
                if (dp[j] && s.substring(j, i) in dict) {
                    dp[i] = true
                    break
                }
            }
        }
        return dp[s.length]
    }
}',
    '## Solution: 1D DP

Time Complexity: O(n² × m), m = max word length
Space Complexity: O(n)

Check all possible word boundaries.',
    'MEDIUM',
    'dynamic-programming,string,hash-table,trie,memoization'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'leetcode,[leet,code]', 'true', FALSE),
    (LAST_INSERT_ID(), 'applepenapple,[apple,pen]', 'true', FALSE),
    (LAST_INSERT_ID(), 'catsandog,[cats,dog,sand,and,cat]', 'false', FALSE);

-- Problem 7: Partition Equal Subset Sum (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'DYNAMIC_PROGRAMMING',
    'Partition Equal Subset Sum',
    '# Partition Equal Subset Sum

Determine if array can be partitioned into two subsets with equal sum.

**Example:**
```
Input: nums = [1,5,11,5]
Output: true
Explanation: [1,5,5] and [11]
```',
    'Hint 1: If sum is odd, impossible.
---
Hint 2: Problem becomes: can we find subset with sum = total/2?
---
Hint 3: 0/1 knapsack problem.',
    'class Solution {
    public boolean canPartition(int[] nums) {
        int sum = 0;
        for (int num : nums) sum += num;
        if (sum % 2 != 0) return false;
        int target = sum / 2;
        boolean[] dp = new boolean[target + 1];
        dp[0] = true;
        for (int num : nums) {
            for (int i = target; i >= num; i--) {
                dp[i] = dp[i] || dp[i - num];
            }
        }
        return dp[target];
    }
}',
    'class Solution {
    fun canPartition(nums: IntArray): Boolean {
        val sum = nums.sum()
        if (sum % 2 != 0) return false
        val target = sum / 2
        val dp = BooleanArray(target + 1)
        dp[0] = true
        for (num in nums) {
            for (i in target downTo num) {
                dp[i] = dp[i] || dp[i - num]
            }
        }
        return dp[target]
    }
}',
    '## Solution: 0/1 Knapsack

Time Complexity: O(n × sum)
Space Complexity: O(sum)

Subset sum variant of knapsack problem.',
    'MEDIUM',
    'dynamic-programming,array'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,5,11,5]', 'true', FALSE),
    (LAST_INSERT_ID(), '[1,2,3,5]', 'false', FALSE);

-- Problem 8: Edit Distance (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'DYNAMIC_PROGRAMMING',
    'Edit Distance',
    '# Edit Distance

Given two strings, find minimum number of operations (insert, delete, replace) to convert word1 to word2.

**Example:**
```
Input: word1 = "horse", word2 = "ros"
Output: 3
Explanation: horse → rorse → rose → ros
```',
    'Hint 1: 2D DP: dp[i][j] = min operations for word1[0..i] → word2[0..j].
---
Hint 2: If chars match, dp[i][j] = dp[i-1][j-1].
---
Hint 3: Else, min of insert, delete, replace.',
    'class Solution {
    public int minDistance(String word1, String word2) {
        int m = word1.length(), n = word2.length();
        int[][] dp = new int[m + 1][n + 1];
        for (int i = 0; i <= m; i++) dp[i][0] = i;
        for (int j = 0; j <= n; j++) dp[0][j] = j;
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (word1.charAt(i - 1) == word2.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = 1 + Math.min(dp[i - 1][j - 1],
                        Math.min(dp[i - 1][j], dp[i][j - 1]));
                }
            }
        }
        return dp[m][n];
    }
}',
    'class Solution {
    fun minDistance(word1: String, word2: String): Int {
        val m = word1.length
        val n = word2.length
        val dp = Array(m + 1) { IntArray(n + 1) }
        for (i in 0..m) dp[i][0] = i
        for (j in 0..n) dp[0][j] = j
        for (i in 1..m) {
            for (j in 1..n) {
                if (word1[i - 1] == word2[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1]
                } else {
                    dp[i][j] = 1 + minOf(dp[i - 1][j - 1], dp[i - 1][j], dp[i][j - 1])
                }
            }
        }
        return dp[m][n]
    }
}',
    '## Solution: 2D DP (Levenshtein Distance)

Time Complexity: O(m × n)
Space Complexity: O(m × n)

Classic edit distance algorithm.',
    'HARD',
    'dynamic-programming,string'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'horse,ros', '3', FALSE),
    (LAST_INSERT_ID(), 'intention,execution', '5', FALSE);

-- Problem 9: Decode Ways (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'DYNAMIC_PROGRAMMING',
    'Decode Ways',
    '# Decode Ways

A = 1, B = 2, ..., Z = 26. Given digit string, count number of ways to decode it.

**Example:**
```
Input: s = "226"
Output: 3
Explanation: "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6)
```',
    'Hint 1: dp[i] = ways to decode s[0..i].
---
Hint 2: Consider single digit (1-9) and two digits (10-26).
---
Hint 3: Handle leading zeros carefully.',
    'class Solution {
    public int numDecodings(String s) {
        if (s.charAt(0) == ''0'') return 0;
        int n = s.length();
        int prev2 = 1, prev1 = 1;
        for (int i = 1; i < n; i++) {
            int curr = 0;
            if (s.charAt(i) != ''0'') {
                curr += prev1;
            }
            int twoDigit = Integer.parseInt(s.substring(i - 1, i + 1));
            if (twoDigit >= 10 && twoDigit <= 26) {
                curr += prev2;
            }
            prev2 = prev1;
            prev1 = curr;
        }
        return prev1;
    }
}',
    'class Solution {
    fun numDecodings(s: String): Int {
        if (s[0] == ''0'') return 0
        val n = s.length
        var prev2 = 1
        var prev1 = 1
        for (i in 1 until n) {
            var curr = 0
            if (s[i] != ''0'') {
                curr += prev1
            }
            val twoDigit = s.substring(i - 1, i + 1).toInt()
            if (twoDigit in 10..26) {
                curr += prev2
            }
            prev2 = prev1
            prev1 = curr
        }
        return prev1
    }
}',
    '## Solution: 1D DP

Time Complexity: O(n)
Space Complexity: O(1)

Similar to Fibonacci with constraints.',
    'MEDIUM',
    'dynamic-programming,string'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '12', '2', FALSE),
    (LAST_INSERT_ID(), '226', '3', FALSE),
    (LAST_INSERT_ID(), '06', '0', FALSE);

-- Problem 10: Unique Paths (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'DYNAMIC_PROGRAMMING',
    'Unique Paths',
    '# Unique Paths

Robot on m×n grid starts at top-left. Can only move down or right. How many unique paths to bottom-right?

**Example:**
```
Input: m = 3, n = 7
Output: 28
```',
    'Hint 1: dp[i][j] = paths to reach (i, j).
---
Hint 2: dp[i][j] = dp[i-1][j] + dp[i][j-1].
---
Hint 3: Space optimize to 1D array.',
    'class Solution {
    public int uniquePaths(int m, int n) {
        int[] dp = new int[n];
        Arrays.fill(dp, 1);
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                dp[j] += dp[j - 1];
            }
        }
        return dp[n - 1];
    }
}',
    'class Solution {
    fun uniquePaths(m: Int, n: Int): Int {
        val dp = IntArray(n) { 1 }
        for (i in 1 until m) {
            for (j in 1 until n) {
                dp[j] += dp[j - 1]
            }
        }
        return dp[n - 1]
    }
}',
    '## Solution: Space-Optimized DP

Time Complexity: O(m × n)
Space Complexity: O(n)

Grid path counting with DP.',
    'MEDIUM',
    'dynamic-programming,math,combinatorics'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '3,7', '28', FALSE),
    (LAST_INSERT_ID(), '3,2', '3', FALSE);

-- Additional 15 DP problems (without full solutions)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'LEETCODE', 'DYNAMIC_PROGRAMMING', 'Min Cost Climbing Stairs', '# Min Cost Climbing Stairs

Pay cost[i] to climb i-th step. Find minimum cost to reach top.

**Example:**
```
Input: cost = [10,15,20]
Output: 15
```', 'Hint 1: Can start from step 0 or 1.
---
Hint 2: dp[i] = min cost to reach step i.
---
Hint 3: dp[i] = cost[i] + min(dp[i-1], dp[i-2]).', 'EASY', 'dynamic-programming,array'),

('ALGO', 'AMAZON', 'DYNAMIC_PROGRAMMING', 'House Robber II', '# House Robber II

Houses arranged in circle. Cannot rob adjacent houses.

**Example:**
```
Input: nums = [2,3,2]
Output: 3
```', 'Hint 1: First and last houses are adjacent.
---
Hint 2: Solve twice: exclude first OR exclude last.
---
Hint 3: Take max of both solutions.', 'MEDIUM', 'dynamic-programming,array'),

('ALGO', 'GOOGLE', 'DYNAMIC_PROGRAMMING', 'Maximum Product Subarray', '# Maximum Product Subarray

Find contiguous subarray with largest product.

**Example:**
```
Input: nums = [2,3,-2,4]
Output: 6
```', 'Hint 1: Track both max and min (negatives flip).
---
Hint 2: Update both at each step.
---
Hint 3: Result is global maximum.', 'MEDIUM', 'dynamic-programming,array'),

('ALGO', 'META', 'DYNAMIC_PROGRAMMING', 'Longest Palindromic Substring', '# Longest Palindromic Substring

Find longest palindromic substring.

**Example:**
```
Input: s = "babad"
Output: "bab" (or "aba")
```', 'Hint 1: Expand around centers.
---
Hint 2: Or 2D DP: dp[i][j] = is s[i..j] palindrome.
---
Hint 3: Consider odd and even length palindromes.', 'MEDIUM', 'dynamic-programming,string'),

('ALGO', 'LEETCODE', 'DYNAMIC_PROGRAMMING', 'Palindromic Substrings', '# Palindromic Substrings

Count all palindromic substrings.

**Example:**
```
Input: s = "abc"
Output: 3
```', 'Hint 1: Expand around each center.
---
Hint 2: Check both odd and even length.
---
Hint 3: Count valid expansions.', 'MEDIUM', 'dynamic-programming,string'),

('ALGO', 'AMAZON', 'DYNAMIC_PROGRAMMING', 'Target Sum', '# Target Sum

Assign + or - to each number to reach target sum.

**Example:**
```
Input: nums = [1,1,1,1,1], target = 3
Output: 5
```', 'Hint 1: Convert to subset sum problem.
---
Hint 2: sum(P) - sum(N) = target, sum(P) + sum(N) = sum.
---
Hint 3: Find subsets with sum = (target + sum) / 2.', 'MEDIUM', 'dynamic-programming,array,backtracking'),

('ALGO', 'GOOGLE', 'DYNAMIC_PROGRAMMING', 'Perfect Squares', '# Perfect Squares

Find minimum perfect squares that sum to n.

**Example:**
```
Input: n = 12
Output: 3 (4 + 4 + 4)
```', 'Hint 1: DP: dp[i] = min squares for i.
---
Hint 2: Try all perfect squares ≤ i.
---
Hint 3: dp[i] = min(dp[i - j²] + 1).', 'MEDIUM', 'dynamic-programming,math,breadth-first-search'),

('ALGO', 'META', 'DYNAMIC_PROGRAMMING', 'Coin Change 2', '# Coin Change 2

Count number of ways to make amount using coins.

**Example:**
```
Input: amount = 5, coins = [1,2,5]
Output: 4
```', 'Hint 1: Unbounded knapsack (combinations).
---
Hint 2: dp[i] = ways to make amount i.
---
Hint 3: For each coin, update all amounts.', 'MEDIUM', 'dynamic-programming,array'),

('ALGO', 'LEETCODE', 'DYNAMIC_PROGRAMMING', 'Unique Binary Search Trees', '# Unique Binary Search Trees

Count structurally unique BSTs with n nodes.

**Example:**
```
Input: n = 3
Output: 5
```', 'Hint 1: Catalan number problem.
---
Hint 2: dp[n] = sum of dp[i] * dp[n-i-1] for all roots.
---
Hint 3: Each root splits into left and right subtrees.', 'MEDIUM', 'dynamic-programming,math,tree,binary-search-tree,binary-tree'),

('ALGO', 'AMAZON', 'DYNAMIC_PROGRAMMING', 'Minimum Path Sum', '# Minimum Path Sum

Find path from top-left to bottom-right with minimum sum (only move down/right).

**Example:**
```
Input: grid = [[1,3,1],[1,5,1],[4,2,1]]
Output: 7
```', 'Hint 1: dp[i][j] = min path sum to (i, j).
---
Hint 2: dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1]).
---
Hint 3: Can modify grid in-place.', 'MEDIUM', 'dynamic-programming,array,matrix'),

('ALGO', 'GOOGLE', 'DYNAMIC_PROGRAMMING', 'Maximal Square', '# Maximal Square

Find largest square containing only 1s in binary matrix.

**Example:**
```
Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"]]
Output: 4
```', 'Hint 1: dp[i][j] = side length of largest square with bottom-right at (i,j).
---
Hint 2: dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1.
---
Hint 3: Track maximum side length.', 'MEDIUM', 'dynamic-programming,array,matrix'),

('ALGO', 'META', 'DYNAMIC_PROGRAMMING', 'Jump Game II', '# Jump Game II

Find minimum jumps to reach last index.

**Example:**
```
Input: nums = [2,3,1,1,4]
Output: 2
```', 'Hint 1: Greedy BFS approach.
---
Hint 2: Track current reach and next reach.
---
Hint 3: Increment jumps when reaching current boundary.', 'MEDIUM', 'dynamic-programming,array,greedy'),

('ALGO', 'LEETCODE', 'DYNAMIC_PROGRAMMING', 'Interleaving String', '# Interleaving String

Check if s3 is formed by interleaving s1 and s2.

**Example:**
```
Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
Output: true
```', 'Hint 1: 2D DP: dp[i][j] = can form s3[0..i+j] from s1[0..i] and s2[0..j].
---
Hint 2: Match current char from s1 or s2.
---
Hint 3: Check both possibilities.', 'MEDIUM', 'dynamic-programming,string'),

('ALGO', 'AMAZON', 'DYNAMIC_PROGRAMMING', 'Regular Expression Matching', '# Regular Expression Matching

Implement regex matching with . and *.

**Example:**
```
Input: s = "aa", p = "a*"
Output: true
```', 'Hint 1: 2D DP: dp[i][j] = does s[0..i] match p[0..j].
---
Hint 2: Handle . (any char) and * (0+ of previous).
---
Hint 3: * case: match 0 times or 1+ times.', 'HARD', 'dynamic-programming,string,recursion'),

('ALGO', 'GOOGLE', 'DYNAMIC_PROGRAMMING', 'Burst Balloons', '# Burst Balloons

Burst balloons to maximize coins (coins = left × balloon × right).

**Example:**
```
Input: nums = [3,1,5,8]
Output: 167
```', 'Hint 1: DP on ranges: dp[i][j] = max coins from bursting (i, j).
---
Hint 2: Try each balloon as last to burst in range.
---
Hint 3: Add dummy 1s at boundaries.', 'HARD', 'dynamic-programming,array');
