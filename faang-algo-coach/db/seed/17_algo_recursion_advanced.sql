-- Advanced Recursion Problems - 15 Problems (Pattern Not Obvious)

USE faang;

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags) VALUES

('ALGO', 'GOOGLE', 'RECURSION', 'Decode All Possible Messages', '# Decode All Possible Messages

Given a string of digits, decode it into all possible letter combinations where 1=A, 2=B, ... 26=Z.

**Example:**
```
Input: "123"
Output: ["ABC", "LC", "AW"]
Explanation: 1-2-3 (ABC), 12-3 (LC), 1-23 (AW)

Input: "06"
Output: []
Explanation: Leading zeros are invalid
```', 'Hint 1: Try making decisions at each position - take 1 digit or 2 digits.
---
Hint 2: Backtracking to explore all valid combinations.
---
Hint 3: Validate that numbers are in range 1-26 and no leading zeros.', '## Solution: Backtracking/Recursion

Use recursion to try all possible splits:
- At each position, try taking 1 digit (if valid)
- Try taking 2 digits (if valid and ≤26)
- Base case: reached end of string

Time: O(2^n), Space: O(n) recursion depth', 'MEDIUM', 'recursion,backtracking,string'),

('ALGO', 'META', 'RECURSION', 'Tower Transfer Sequence', '# Tower Transfer Sequence

You have 3 pegs and n disks of different sizes. Move all disks from peg A to peg C following rules:
1. Only one disk moves at a time
2. Larger disk cannot be on smaller disk
3. Can only move top disk from any peg

Return the sequence of moves as list of [from, to] pairs.

**Example:**
```
Input: n = 3
Output: [[1,3], [1,2], [3,2], [1,3], [2,1], [2,3], [1,3]]
```', 'Hint 1: Classic divide and conquer problem.
---
Hint 2: To move n disks A→C: move n-1 disks A→B, move disk n A→C, move n-1 disks B→C.
---
Hint 3: Recursive subproblems with different source/destination/auxiliary pegs.', '## Solution: Divide and Conquer

Tower of Hanoi using recursion:
1. Move n-1 disks to auxiliary peg
2. Move largest disk to target
3. Move n-1 disks from auxiliary to target

Time: O(2^n), Space: O(n)', 'MEDIUM', 'recursion,divide-conquer,classic'),

('ALGO', 'AMAZON', 'RECURSION', 'Generate Valid Bracket Sequences', '# Generate Valid Bracket Sequences

Given n pairs of brackets, generate all valid bracket sequences.

**Example:**
```
Input: n = 3
Output: ["((()))", "(()())", "(())()", "()(())", "()()()"]

Input: n = 1
Output: ["()"]
```', 'Hint 1: Build sequences character by character.
---
Hint 2: Track count of open and close brackets used.
---
Hint 3: Can add open bracket if count < n; can add close if close_count < open_count.', '## Solution: Backtracking

Generate valid sequences recursively:
- Add "(" if open_count < n
- Add ")" if close_count < open_count
- Base case: open_count == close_count == n

Time: O(4^n / √n) Catalan, Space: O(n)', 'MEDIUM', 'recursion,backtracking,string'),

('ALGO', 'GOOGLE', 'RECURSION', 'Staircase Paint Combinations', '# Staircase Paint Combinations

You have a staircase with n steps. Each step can be painted one of k colors. No two adjacent steps can have the same color. How many ways can you paint the staircase?

**Example:**
```
Input: n = 3, k = 2
Output: 6
Explanation: With colors R,B: RBR, RBB, BRB, BRR, BBR, BRB
Wait, that''s wrong... actually: RBR, RBB, BRB, BRR, BBR, BRB = not all unique
Correct: RBR, BRB, RBB, BRR, BBR, RBR (actually 6 valid)
```', 'Hint 1: At each step, you have k-1 color choices (any except previous).
---
Hint 2: First step has k choices, each subsequent has k-1 choices.
---
Hint 3: Actually this is just k * (k-1)^(n-1), but can solve recursively.', '## Solution: Recursion/Math

Base case: 1 step = k ways
Recursive: f(n) = (k-1) * f(n-1)
Or direct: k * (k-1)^(n-1)

Time: O(n) or O(1), Space: O(n) or O(1)', 'EASY', 'recursion,math,combinatorics'),

('ALGO', 'META', 'RECURSION', 'Split Array Into Fibonacci Sequence', '# Split Array Into Fibonacci Sequence

Given a string of digits, split it into a Fibonacci-like sequence where each number is the sum of the previous two. Return any valid sequence or empty if none exists.

**Example:**
```
Input: "1101111"
Output: [110, 1, 111]

Input: "112358130"
Output: [1, 1, 2, 3, 5, 8, 13]
```', 'Hint 1: Try all possible first two numbers.
---
Hint 2: Once first two are chosen, rest is determined.
---
Hint 3: Use recursion to validate if remaining string follows Fibonacci property.', '## Solution: Backtracking

Try all valid splits for first two numbers:
- For each pair, check if rest follows Fibonacci
- Recursively validate remaining string
- Handle overflow and leading zeros

Time: O(n²), Space: O(n)', 'HARD', 'recursion,backtracking,string'),

('ALGO', 'AMAZON', 'RECURSION', 'Count Ways to Tile Floor', '# Count Ways to Tile Floor

You have a 2×n floor and unlimited 2×1 tiles. Count the number of ways to tile the entire floor.

**Example:**
```
Input: n = 3
Output: 3
Explanation: HHH, VHV, HVV (H=horizontal pair, V=vertical)

Input: n = 4
Output: 5
```', 'Hint 1: At each column, you can place tiles vertically or horizontally.
---
Hint 2: If vertical, moves to column i+1. If horizontal, must place two, moves to i+2.
---
Hint 3: Recurrence: f(n) = f(n-1) + f(n-2).', '## Solution: Recursion/DP

Same as Fibonacci:
- f(n) = f(n-1) + f(n-2)
- Base: f(1) = 1, f(2) = 2

Time: O(n), Space: O(n) or O(1) optimized', 'MEDIUM', 'recursion,dynamic-programming,math'),

('ALGO', 'GOOGLE', 'RECURSION', 'Restore IP Addresses', '# Restore IP Addresses

Given a string of digits, return all valid IP addresses that can be formed by inserting dots.

**Example:**
```
Input: "25525511135"
Output: ["255.255.11.135", "255.255.111.35"]

Input: "101023"
Output: ["1.0.10.23", "1.0.102.3", "10.1.0.23", "10.10.2.3", "101.0.2.3"]
```', 'Hint 1: IP has 4 segments, each 0-255.
---
Hint 2: Backtrack to try all valid segment positions.
---
Hint 3: Validate: no leading zeros (except "0"), value ≤255, exactly 4 segments.', '## Solution: Backtracking

Try all ways to split into 4 valid segments:
- Recursively try 1, 2, or 3 digits per segment
- Validate each segment: 0-255, no leading zeros
- Collect valid combinations

Time: O(1) - at most 3^4 combinations, Space: O(1)', 'MEDIUM', 'recursion,backtracking,string'),

('ALGO', 'META', 'RECURSION', 'Letter Case Permutations', '# Letter Case Permutations

Given a string with letters and digits, generate all possible strings by toggling the case of letters.

**Example:**
```
Input: "a1b2"
Output: ["a1b2", "a1B2", "A1b2", "A1B2"]

Input: "3z4"
Output: ["3z4", "3Z4"]
```', 'Hint 1: At each letter position, make 2 choices: lowercase or uppercase.
---
Hint 2: Digits remain unchanged.
---
Hint 3: Backtracking to explore all combinations.', '## Solution: Backtracking

For each character:
- If digit, keep as is
- If letter, branch into lowercase and uppercase
- Total: 2^(number of letters) combinations

Time: O(2^L * n) where L = letters, Space: O(2^L * n)', 'EASY', 'recursion,backtracking,string'),

('ALGO', 'AMAZON', 'RECURSION', 'Beautiful Arrangement Count', '# Beautiful Arrangement Count

Count arrangements of numbers 1 to n where either:
- Number at position i is divisible by i, OR
- Position i is divisible by the number at position i

**Example:**
```
Input: n = 2
Output: 2
Explanation: [1,2] and [2,1]

Input: n = 3
Output: 3
Explanation: [1,2,3], [2,1,3], [3,2,1]
```', 'Hint 1: Try all permutations with pruning.
---
Hint 2: Backtrack: place valid numbers at each position.
---
Hint 3: For position i, try all unused numbers that satisfy the condition.', '## Solution: Backtracking with Pruning

Generate permutations with constraint:
- At position i, try each unused number j
- Check if j%i==0 or i%j==0
- Recursively fill remaining positions

Time: O(n!), Space: O(n)', 'HARD', 'recursion,backtracking,math'),

('ALGO', 'GOOGLE', 'RECURSION', 'Expression Add Operators', '# Expression Add Operators

Given string of digits and target, insert +, -, or * between digits to create expression that evaluates to target. Return all valid expressions.

**Example:**
```
Input: num = "123", target = 6
Output: ["1+2+3", "1*2*3"]

Input: num = "232", target = 8
Output: ["2*3+2", "2+3*2"]
```', 'Hint 1: Backtracking to try all operator placements.
---
Hint 2: Track current value and last multiplied value for * operator.
---
Hint 3: Handle multiplication by reverting last addition and applying *.', '## Solution: Backtracking with Expression Evaluation

At each position:
- Try +, -, *
- Track: current result, last operand (for *)
- Handle operator precedence by tracking last value

Time: O(4^n), Space: O(n)', 'HARD', 'recursion,backtracking,string,math'),

('ALGO', 'META', 'RECURSION', 'Different Ways to Compute Result', '# Different Ways to Compute Result

Given an expression with numbers and operators +, -, *, compute all possible results by grouping operands in different ways.

**Example:**
```
Input: "2-1-1"
Output: [0, 2]
Explanation: ((2-1)-1) = 0, (2-(1-1)) = 2

Input: "2*3-4*5"
Output: [-34, -14, -10, -10, 10]
```', 'Hint 1: Divide and conquer on operators.
---
Hint 2: For each operator, split expression into left and right parts.
---
Hint 3: Recursively compute all results for left and right, combine them.', '## Solution: Divide and Conquer with Memoization

For each operator position:
- Recursively solve left and right subexpressions
- Combine results using the operator
- Memoize to avoid recomputation

Time: O(Catalan number), Space: O(Catalan)', 'HARD', 'recursion,divide-conquer,memoization'),

('ALGO', 'AMAZON', 'RECURSION', 'Robot Path Finder', '# Robot Path Finder

A robot on an n×m grid starts at (0,0) and wants to reach (n-1, m-1). It can only move right or down. Count the number of unique paths.

**Example:**
```
Input: n = 3, m = 2
Output: 3
Explanation: Right→Right→Down, Right→Down→Right, Down→Right→Right

Input: n = 3, m = 3
Output: 6
```', 'Hint 1: At each cell, robot can come from top or left.
---
Hint 2: Recursive: paths(i,j) = paths(i-1,j) + paths(i,j-1).
---
Hint 3: Base case: paths(0,j) = paths(i,0) = 1.', '## Solution: Recursion/DP

Recursive formula:
- f(i,j) = f(i-1,j) + f(i,j-1)
- Base: f(0,j) = f(i,0) = 1
Or use combinatorics: C(n+m-2, n-1)

Time: O(n*m), Space: O(n*m) or O(1)', 'EASY', 'recursion,dynamic-programming,math'),

('ALGO', 'GOOGLE', 'RECURSION', 'Word Pattern Matching', '# Word Pattern Matching

Given a pattern and string s, determine if s follows the same pattern. Here "follow" means a full match where each letter in pattern maps to a non-empty word in s, bijectively.

**Example:**
```
Input: pattern = "abba", s = "dog cat cat dog"
Output: true

Input: pattern = "abba", s = "dog cat cat fish"
Output: false
```', 'Hint 1: This requires backtracking to try all possible word assignments.
---
Hint 2: Map each pattern char to a substring in s.
---
Hint 3: Ensure bijection: pattern char → word and word → pattern char.', '## Solution: Backtracking with HashMaps

Try all possible word splits for first pattern character:
- Recursively match remaining pattern with remaining string
- Use two maps for bijection
- Prune invalid branches

Time: O(n^m) worst case, Space: O(m+n)', 'HARD', 'recursion,backtracking,hash-table,string'),

('ALGO', 'LEETCODE', 'RECURSION', 'Partition Into K Equal Sum Subsets', '# Partition Into K Equal Sum Subsets

Given an array of integers and integer k, determine if the array can be partitioned into k non-empty subsets with equal sum.

**Example:**
```
Input: nums = [4,3,2,3,5,2,1], k = 4
Output: true
Explanation: [5], [1,4], [2,3], [2,3]

Input: nums = [1,2,3,4], k = 3
Output: false
```', 'Hint 1: Sum must be divisible by k.
---
Hint 2: Target sum = total_sum / k.
---
Hint 3: Backtrack to try assigning each number to k buckets.', '## Solution: Backtracking

1. Check if sum divisible by k
2. Target = sum / k
3. Use backtracking to fill k buckets
4. Try placing each number in available buckets
5. Prune when bucket exceeds target

Time: O(k^n), Space: O(n)', 'HARD', 'recursion,backtracking,array,partition'),

('ALGO', 'META', 'RECURSION', 'Generate Abbreviations', '# Generate Abbreviations

Given a word, generate all possible abbreviations by replacing any number of consecutive characters with their count.

**Example:**
```
Input: "word"
Output: ["word", "1ord", "w1rd", "wo1d", "wor1", "2rd", "w2d", "wo2", "1o1d", "1or1", "w1r1", "1o2", "2r1", "3d", "w3", "4"]

Input: "a"
Output: ["a", "1"]
```', 'Hint 1: At each position, either keep the character or start abbreviating.
---
Hint 2: When abbreviating, count consecutive characters.
---
Hint 3: Backtracking to explore: keep char vs. abbreviate.', '## Solution: Backtracking

At each position, two choices:
1. Keep character as is
2. Abbreviate k consecutive characters (try all k)

Generate all combinations recursively.

Time: O(2^n), Space: O(n)', 'MEDIUM', 'recursion,backtracking,string');
