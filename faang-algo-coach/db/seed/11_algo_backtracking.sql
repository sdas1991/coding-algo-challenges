-- Backtracking Arena - 25 Problems (10 with full solutions)

USE faang;

-- Problem 1: Subsets (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'BACKTRACKING',
    'Subsets',
    '# Subsets

Given integer array of unique elements, return all possible subsets (power set).

**Example:**
```
Input: nums = [1,2,3]
Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
```',
    'Hint 1: For each element, choose to include or exclude.
---
Hint 2: Backtrack: add element, recurse, remove element.
---
Hint 3: Base case: reached end, add current subset.',
    'class Solution {
    public List<List<Integer>> subsets(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(result, new ArrayList<>(), nums, 0);
        return result;
    }

    private void backtrack(List<List<Integer>> result, List<Integer> temp, int[] nums, int start) {
        result.add(new ArrayList<>(temp));
        for (int i = start; i < nums.length; i++) {
            temp.add(nums[i]);
            backtrack(result, temp, nums, i + 1);
            temp.remove(temp.size() - 1);
        }
    }
}',
    'class Solution {
    fun subsets(nums: IntArray): List<List<Int>> {
        val result = mutableListOf<List<Int>>()
        backtrack(result, mutableListOf(), nums, 0)
        return result
    }

    private fun backtrack(result: MutableList<List<Int>>, temp: MutableList<Int>, nums: IntArray, start: Int) {
        result.add(ArrayList(temp))
        for (i in start until nums.size) {
            temp.add(nums[i])
            backtrack(result, temp, nums, i + 1)
            temp.removeAt(temp.size - 1)
        }
    }
}',
    '## Solution: Backtracking

Time Complexity: O(2^n × n)
Space Complexity: O(n) recursion depth

Generate all subsets through backtracking.',
    'MEDIUM',
    'array,backtracking,bit-manipulation'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3]', '[[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]', FALSE),
    (LAST_INSERT_ID(), '[0]', '[[],[0]]', FALSE);

-- Problem 2: Permutations (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'BACKTRACKING',
    'Permutations',
    '# Permutations

Given array of distinct integers, return all possible permutations.

**Example:**
```
Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
```',
    'Hint 1: Use backtracking with visited tracking.
---
Hint 2: Try each unvisited element at current position.
---
Hint 3: When temp size equals n, add to result.',
    'class Solution {
    public List<List<Integer>> permute(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(result, new ArrayList<>(), nums);
        return result;
    }

    private void backtrack(List<List<Integer>> result, List<Integer> temp, int[] nums) {
        if (temp.size() == nums.length) {
            result.add(new ArrayList<>(temp));
            return;
        }
        for (int num : nums) {
            if (temp.contains(num)) continue;
            temp.add(num);
            backtrack(result, temp, nums);
            temp.remove(temp.size() - 1);
        }
    }
}',
    'class Solution {
    fun permute(nums: IntArray): List<List<Int>> {
        val result = mutableListOf<List<Int>>()
        backtrack(result, mutableListOf(), nums)
        return result
    }

    private fun backtrack(result: MutableList<List<Int>>, temp: MutableList<Int>, nums: IntArray) {
        if (temp.size == nums.size) {
            result.add(ArrayList(temp))
            return
        }
        for (num in nums) {
            if (num in temp) continue
            temp.add(num)
            backtrack(result, temp, nums)
            temp.removeAt(temp.size - 1)
        }
    }
}',
    '## Solution: Backtracking

Time Complexity: O(n! × n)
Space Complexity: O(n)

Generate permutations through backtracking.',
    'MEDIUM',
    'array,backtracking'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3]', '[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]', FALSE),
    (LAST_INSERT_ID(), '[0,1]', '[[0,1],[1,0]]', FALSE);

-- Problem 3: Combination Sum (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'BACKTRACKING',
    'Combination Sum',
    '# Combination Sum

Given array of distinct integers and target, return all unique combinations that sum to target. Same number may be chosen unlimited times.

**Example:**
```
Input: candidates = [2,3,6,7], target = 7
Output: [[2,2,3],[7]]
```',
    'Hint 1: Backtracking with remaining target.
---
Hint 2: Can reuse same element (don''t increment start).
---
Hint 3: Prune when remaining < 0.',
    'class Solution {
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(candidates);
        backtrack(result, new ArrayList<>(), candidates, target, 0);
        return result;
    }

    private void backtrack(List<List<Integer>> result, List<Integer> temp, int[] candidates, int remain, int start) {
        if (remain < 0) return;
        if (remain == 0) {
            result.add(new ArrayList<>(temp));
            return;
        }
        for (int i = start; i < candidates.length; i++) {
            temp.add(candidates[i]);
            backtrack(result, temp, candidates, remain - candidates[i], i);
            temp.remove(temp.size() - 1);
        }
    }
}',
    'class Solution {
    fun combinationSum(candidates: IntArray, target: Int): List<List<Int>> {
        val result = mutableListOf<List<Int>>()
        candidates.sort()
        backtrack(result, mutableListOf(), candidates, target, 0)
        return result
    }

    private fun backtrack(result: MutableList<List<Int>>, temp: MutableList<Int>, candidates: IntArray, remain: Int, start: Int) {
        if (remain < 0) return
        if (remain == 0) {
            result.add(ArrayList(temp))
            return
        }
        for (i in start until candidates.size) {
            temp.add(candidates[i])
            backtrack(result, temp, candidates, remain - candidates[i], i)
            temp.removeAt(temp.size - 1)
        }
    }
}',
    '## Solution: Backtracking with Reuse

Time Complexity: O(2^n)
Space Complexity: O(target / min(candidates))

Allow reusing elements in combination.',
    'MEDIUM',
    'array,backtracking'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[2,3,6,7],7', '[[2,2,3],[7]]', FALSE),
    (LAST_INSERT_ID(), '[2,3,5],8', '[[2,2,2,2],[2,3,3],[3,5]]', FALSE);

-- Problem 4: N-Queens (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'BACKTRACKING',
    'N-Queens',
    '# N-Queens

Place n queens on n×n chessboard so no two queens attack each other.

**Example:**
```
Input: n = 4
Output: [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
```',
    'Hint 1: Place queens row by row.
---
Hint 2: Check column, diagonal, anti-diagonal conflicts.
---
Hint 3: Use sets to track occupied columns and diagonals.',
    'class Solution {
    public List<List<String>> solveNQueens(int n) {
        List<List<String>> result = new ArrayList<>();
        char[][] board = new char[n][n];
        for (char[] row : board) Arrays.fill(row, ''.'');
        backtrack(result, board, 0, new HashSet<>(), new HashSet<>(), new HashSet<>());
        return result;
    }

    private void backtrack(List<List<String>> result, char[][] board, int row, Set<Integer> cols, Set<Integer> diags, Set<Integer> antiDiags) {
        if (row == board.length) {
            result.add(construct(board));
            return;
        }
        for (int col = 0; col < board.length; col++) {
            int diag = row - col;
            int antiDiag = row + col;
            if (cols.contains(col) || diags.contains(diag) || antiDiags.contains(antiDiag)) {
                continue;
            }
            cols.add(col);
            diags.add(diag);
            antiDiags.add(antiDiag);
            board[row][col] = ''Q'';
            backtrack(result, board, row + 1, cols, diags, antiDiags);
            board[row][col] = ''.'';
            cols.remove(col);
            diags.remove(diag);
            antiDiags.remove(antiDiag);
        }
    }

    private List<String> construct(char[][] board) {
        List<String> result = new ArrayList<>();
        for (char[] row : board) {
            result.add(new String(row));
        }
        return result;
    }
}',
    'class Solution {
    fun solveNQueens(n: Int): List<List<String>> {
        val result = mutableListOf<List<String>>()
        val board = Array(n) { CharArray(n) { ''.'' } }
        backtrack(result, board, 0, mutableSetOf(), mutableSetOf(), mutableSetOf())
        return result
    }

    private fun backtrack(result: MutableList<List<String>>, board: Array<CharArray>, row: Int, cols: MutableSet<Int>, diags: MutableSet<Int>, antiDiags: MutableSet<Int>) {
        if (row == board.size) {
            result.add(board.map { String(it) })
            return
        }
        for (col in board.indices) {
            val diag = row - col
            val antiDiag = row + col
            if (col in cols || diag in diags || antiDiag in antiDiags) {
                continue
            }
            cols.add(col)
            diags.add(diag)
            antiDiags.add(antiDiag)
            board[row][col] = ''Q''
            backtrack(result, board, row + 1, cols, diags, antiDiags)
            board[row][col] = ''.''
            cols.remove(col)
            diags.remove(diag)
            antiDiags.remove(antiDiag)
        }
    }
}',
    '## Solution: Backtracking with Constraint Checking

Time Complexity: O(n!)
Space Complexity: O(n²)

Classic backtracking with conflict detection.',
    'HARD',
    'array,backtracking'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '4', '[[.Q..,..Q.,Q...,..Q.],[..Q.,Q...,...Q,.Q..]]', FALSE),
    (LAST_INSERT_ID(), '1', '[[Q]]', FALSE);

-- Problem 5: Word Search (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'BACKTRACKING',
    'Word Search',
    '# Word Search

Given 2D board and word, find if word exists in grid (adjacent cells horizontally or vertically).

**Example:**
```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
Output: true
```',
    'Hint 1: Try starting from each cell.
---
Hint 2: DFS/backtrack in 4 directions.
---
Hint 3: Mark visited cells temporarily.',
    'class Solution {
    public boolean exist(char[][] board, String word) {
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[0].length; j++) {
                if (backtrack(board, word, i, j, 0)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean backtrack(char[][] board, String word, int i, int j, int idx) {
        if (idx == word.length()) return true;
        if (i < 0 || i >= board.length || j < 0 || j >= board[0].length || board[i][j] != word.charAt(idx)) {
            return false;
        }
        char temp = board[i][j];
        board[i][j] = ''#'';
        boolean found = backtrack(board, word, i + 1, j, idx + 1) ||
                        backtrack(board, word, i - 1, j, idx + 1) ||
                        backtrack(board, word, i, j + 1, idx + 1) ||
                        backtrack(board, word, i, j - 1, idx + 1);
        board[i][j] = temp;
        return found;
    }
}',
    'class Solution {
    fun exist(board: Array<CharArray>, word: String): Boolean {
        for (i in board.indices) {
            for (j in board[0].indices) {
                if (backtrack(board, word, i, j, 0)) {
                    return true
                }
            }
        }
        return false
    }

    private fun backtrack(board: Array<CharArray>, word: String, i: Int, j: Int, idx: Int): Boolean {
        if (idx == word.length) return true
        if (i !in board.indices || j !in board[0].indices || board[i][j] != word[idx]) {
            return false
        }
        val temp = board[i][j]
        board[i][j] = ''#''
        val found = backtrack(board, word, i + 1, j, idx + 1) ||
                    backtrack(board, word, i - 1, j, idx + 1) ||
                    backtrack(board, word, i, j + 1, idx + 1) ||
                    backtrack(board, word, i, j - 1, idx + 1)
        board[i][j] = temp
        return found
    }
}',
    '## Solution: DFS Backtracking

Time Complexity: O(m × n × 4^L), L = word length
Space Complexity: O(L) recursion depth

Grid search with backtracking.',
    'MEDIUM',
    'array,backtracking,matrix'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[A,B,C,E],[S,F,C,S],[A,D,E,E]],ABCCED', 'true', FALSE),
    (LAST_INSERT_ID(), '[[A,B,C,E],[S,F,C,S],[A,D,E,E]],SEE', 'true', FALSE),
    (LAST_INSERT_ID(), '[[A,B,C,E],[S,F,C,S],[A,D,E,E]],ABCB', 'false', FALSE);

-- Problem 6: Letter Combinations of Phone Number (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'BACKTRACKING',
    'Letter Combinations of a Phone Number',
    '# Letter Combinations of a Phone Number

Given string of digits 2-9, return all possible letter combinations.

**Example:**
```
Input: digits = "23"
Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
```',
    'Hint 1: Map digits to letters.
---
Hint 2: Backtrack through each digit.
---
Hint 3: Try each letter for current digit.',
    'class Solution {
    private static final String[] LETTERS = {"", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};

    public List<String> letterCombinations(String digits) {
        List<String> result = new ArrayList<>();
        if (digits.isEmpty()) return result;
        backtrack(result, new StringBuilder(), digits, 0);
        return result;
    }

    private void backtrack(List<String> result, StringBuilder temp, String digits, int idx) {
        if (idx == digits.length()) {
            result.add(temp.toString());
            return;
        }
        String letters = LETTERS[digits.charAt(idx) - ''0''];
        for (char letter : letters.toCharArray()) {
            temp.append(letter);
            backtrack(result, temp, digits, idx + 1);
            temp.deleteCharAt(temp.length() - 1);
        }
    }
}',
    'class Solution {
    private val letters = arrayOf("", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz")

    fun letterCombinations(digits: String): List<String> {
        val result = mutableListOf<String>()
        if (digits.isEmpty()) return result
        backtrack(result, StringBuilder(), digits, 0)
        return result
    }

    private fun backtrack(result: MutableList<String>, temp: StringBuilder, digits: String, idx: Int) {
        if (idx == digits.length) {
            result.add(temp.toString())
            return
        }
        val letterStr = letters[digits[idx] - ''0'']
        for (letter in letterStr) {
            temp.append(letter)
            backtrack(result, temp, digits, idx + 1)
            temp.deleteCharAt(temp.length - 1)
        }
    }
}',
    '## Solution: Backtracking with Mapping

Time Complexity: O(4^n × n), n = digits length
Space Complexity: O(n)

Generate all combinations through backtracking.',
    'MEDIUM',
    'string,hash-table,backtracking'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '23', '[ad,ae,af,bd,be,bf,cd,ce,cf]', FALSE),
    (LAST_INSERT_ID(), '', '[]', FALSE),
    (LAST_INSERT_ID(), '2', '[a,b,c]', FALSE);

-- Problem 7: Palindrome Partitioning (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'BACKTRACKING',
    'Palindrome Partitioning',
    '# Palindrome Partitioning

Partition string such that every substring is a palindrome. Return all possible partitions.

**Example:**
```
Input: s = "aab"
Output: [["a","a","b"],["aa","b"]]
```',
    'Hint 1: Backtrack through all possible partitions.
---
Hint 2: Check if current substring is palindrome.
---
Hint 3: If yes, add to temp and recurse on remaining.',
    'class Solution {
    public List<List<String>> partition(String s) {
        List<List<String>> result = new ArrayList<>();
        backtrack(result, new ArrayList<>(), s, 0);
        return result;
    }

    private void backtrack(List<List<String>> result, List<String> temp, String s, int start) {
        if (start == s.length()) {
            result.add(new ArrayList<>(temp));
            return;
        }
        for (int i = start; i < s.length(); i++) {
            if (isPalindrome(s, start, i)) {
                temp.add(s.substring(start, i + 1));
                backtrack(result, temp, s, i + 1);
                temp.remove(temp.size() - 1);
            }
        }
    }

    private boolean isPalindrome(String s, int left, int right) {
        while (left < right) {
            if (s.charAt(left++) != s.charAt(right--)) {
                return false;
            }
        }
        return true;
    }
}',
    'class Solution {
    fun partition(s: String): List<List<String>> {
        val result = mutableListOf<List<String>>()
        backtrack(result, mutableListOf(), s, 0)
        return result
    }

    private fun backtrack(result: MutableList<List<String>>, temp: MutableList<String>, s: String, start: Int) {
        if (start == s.length) {
            result.add(ArrayList(temp))
            return
        }
        for (i in start until s.length) {
            if (isPalindrome(s, start, i)) {
                temp.add(s.substring(start, i + 1))
                backtrack(result, temp, s, i + 1)
                temp.removeAt(temp.size - 1)
            }
        }
    }

    private fun isPalindrome(s: String, left: Int, right: Int): Boolean {
        var l = left
        var r = right
        while (l < r) {
            if (s[l++] != s[r--]) {
                return false
            }
        }
        return true
    }
}',
    '## Solution: Backtracking with Palindrome Check

Time Complexity: O(n × 2^n)
Space Complexity: O(n)

Partition and validate palindromes.',
    'MEDIUM',
    'string,backtracking,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'aab', '[[a,a,b],[aa,b]]', FALSE),
    (LAST_INSERT_ID(), 'a', '[[a]]', FALSE);

-- Problem 8: Generate Parentheses (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'BACKTRACKING',
    'Generate Parentheses',
    '# Generate Parentheses

Given n pairs of parentheses, generate all valid combinations.

**Example:**
```
Input: n = 3
Output: ["((()))","(()())","(())()","()(())","()()()"]
```',
    'Hint 1: Track count of open and close parentheses.
---
Hint 2: Can add ''('' if open < n.
---
Hint 3: Can add '')'' if close < open.',
    'class Solution {
    public List<String> generateParenthesis(int n) {
        List<String> result = new ArrayList<>();
        backtrack(result, new StringBuilder(), 0, 0, n);
        return result;
    }

    private void backtrack(List<String> result, StringBuilder temp, int open, int close, int max) {
        if (temp.length() == max * 2) {
            result.add(temp.toString());
            return;
        }
        if (open < max) {
            temp.append(''('');
            backtrack(result, temp, open + 1, close, max);
            temp.deleteCharAt(temp.length() - 1);
        }
        if (close < open) {
            temp.append('')'');
            backtrack(result, temp, open, close + 1, max);
            temp.deleteCharAt(temp.length() - 1);
        }
    }
}',
    'class Solution {
    fun generateParenthesis(n: Int): List<String> {
        val result = mutableListOf<String>()
        backtrack(result, StringBuilder(), 0, 0, n)
        return result
    }

    private fun backtrack(result: MutableList<String>, temp: StringBuilder, open: Int, close: Int, max: Int) {
        if (temp.length == max * 2) {
            result.add(temp.toString())
            return
        }
        if (open < max) {
            temp.append(''('')
            backtrack(result, temp, open + 1, close, max)
            temp.deleteCharAt(temp.length - 1)
        }
        if (close < open) {
            temp.append('')'')
            backtrack(result, temp, open, close + 1, max)
            temp.deleteCharAt(temp.length - 1)
        }
    }
}',
    '## Solution: Backtracking with Constraints

Time Complexity: O(4^n / √n) - Catalan number
Space Complexity: O(n)

Generate valid parentheses combinations.',
    'MEDIUM',
    'string,backtracking,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '3', '[((())),(()()), (())(),()(()), ()()()]', FALSE),
    (LAST_INSERT_ID(), '1', '[()]', FALSE);

-- Problem 9: Sudoku Solver (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'BACKTRACKING',
    'Sudoku Solver',
    '# Sudoku Solver

Solve a Sudoku puzzle by filling empty cells.

**Example:**
```
Input: board with some filled cells
Output: board completely filled validly
```',
    'Hint 1: Try digits 1-9 for each empty cell.
---
Hint 2: Check row, column, and 3×3 box validity.
---
Hint 3: Backtrack if no valid digit found.',
    'class Solution {
    public void solveSudoku(char[][] board) {
        solve(board);
    }

    private boolean solve(char[][] board) {
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (board[i][j] == ''.'') {
                    for (char c = ''1''; c <= ''9''; c++) {
                        if (isValid(board, i, j, c)) {
                            board[i][j] = c;
                            if (solve(board)) {
                                return true;
                            }
                            board[i][j] = ''.'';
                        }
                    }
                    return false;
                }
            }
        }
        return true;
    }

    private boolean isValid(char[][] board, int row, int col, char c) {
        for (int i = 0; i < 9; i++) {
            if (board[row][i] == c || board[i][col] == c ||
                board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == c) {
                return false;
            }
        }
        return true;
    }
}',
    'class Solution {
    fun solveSudoku(board: Array<CharArray>) {
        solve(board)
    }

    private fun solve(board: Array<CharArray>): Boolean {
        for (i in 0..8) {
            for (j in 0..8) {
                if (board[i][j] == ''.'') {
                    for (c in ''1''..''9'') {
                        if (isValid(board, i, j, c)) {
                            board[i][j] = c
                            if (solve(board)) {
                                return true
                            }
                            board[i][j] = ''.''
                        }
                    }
                    return false
                }
            }
        }
        return true
    }

    private fun isValid(board: Array<CharArray>, row: Int, col: Int, c: Char): Boolean {
        for (i in 0..8) {
            if (board[row][i] == c || board[i][col] == c ||
                board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == c) {
                return false
            }
        }
        return true
    }
}',
    '## Solution: Backtracking with Validation

Time Complexity: O(9^(empty cells))
Space Complexity: O(1)

Classic constraint satisfaction problem.',
    'HARD',
    'array,backtracking,matrix'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[5,3,.,.,7,.,.,.,.],[6,.,.,1,9,5,.,.,.]]', 'valid-complete-board', FALSE);

-- Problem 10: Restore IP Addresses (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'BACKTRACKING',
    'Restore IP Addresses',
    '# Restore IP Addresses

Given string of digits, return all valid IP address combinations.

**Example:**
```
Input: s = "25525511135"
Output: ["255.255.11.135","255.255.111.35"]
```',
    'Hint 1: Need exactly 4 segments.
---
Hint 2: Each segment: 0-255, no leading zeros (except "0").
---
Hint 3: Backtrack with segment count and position.',
    'class Solution {
    public List<String> restoreIpAddresses(String s) {
        List<String> result = new ArrayList<>();
        if (s.length() > 12) return result;
        backtrack(result, s, 0, "", 0);
        return result;
    }

    private void backtrack(List<String> result, String s, int idx, String temp, int count) {
        if (count == 4 && idx == s.length()) {
            result.add(temp.substring(0, temp.length() - 1));
            return;
        }
        if (count == 4 || idx >= s.length()) return;
        for (int i = 1; i <= 3 && idx + i <= s.length(); i++) {
            String segment = s.substring(idx, idx + i);
            if (isValid(segment)) {
                backtrack(result, s, idx + i, temp + segment + ".", count + 1);
            }
        }
    }

    private boolean isValid(String segment) {
        if (segment.length() > 1 && segment.charAt(0) == ''0'') return false;
        int val = Integer.parseInt(segment);
        return val >= 0 && val <= 255;
    }
}',
    'class Solution {
    fun restoreIpAddresses(s: String): List<String> {
        val result = mutableListOf<String>()
        if (s.length > 12) return result
        backtrack(result, s, 0, "", 0)
        return result
    }

    private fun backtrack(result: MutableList<String>, s: String, idx: Int, temp: String, count: Int) {
        if (count == 4 && idx == s.length) {
            result.add(temp.substring(0, temp.length - 1))
            return
        }
        if (count == 4 || idx >= s.length) return
        for (i in 1..3) {
            if (idx + i > s.length) break
            val segment = s.substring(idx, idx + i)
            if (isValid(segment)) {
                backtrack(result, s, idx + i, temp + segment + ".", count + 1)
            }
        }
    }

    private fun isValid(segment: String): Boolean {
        if (segment.length > 1 && segment[0] == ''0'') return false
        val `val` = segment.toInt()
        return `val` in 0..255
    }
}',
    '## Solution: Backtracking with Validation

Time Complexity: O(1) - fixed number of combinations
Space Complexity: O(1)

Generate and validate IP segments.',
    'MEDIUM',
    'string,backtracking'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '25525511135', '[255.255.11.135,255.255.111.35]', FALSE),
    (LAST_INSERT_ID(), '0000', '[0.0.0.0]', FALSE);

-- Additional 15 backtracking problems (without full solutions)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'LEETCODE', 'BACKTRACKING', 'Combinations', '# Combinations

Return all possible combinations of k numbers from 1 to n.

**Example:**
```
Input: n = 4, k = 2
Output: [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
```', 'Hint 1: Similar to subsets but with size constraint.
---
Hint 2: Backtrack with k remaining slots.
---
Hint 3: Prune when not enough numbers left.', 'MEDIUM', 'array,backtracking'),

('ALGO', 'AMAZON', 'BACKTRACKING', 'Permutations II', '# Permutations II

Return all unique permutations from array with duplicates.

**Example:**
```
Input: nums = [1,1,2]
Output: [[1,1,2],[1,2,1],[2,1,1]]
```', 'Hint 1: Sort array first.
---
Hint 2: Skip duplicates at same recursion level.
---
Hint 3: Use visited array or frequency map.', 'MEDIUM', 'array,backtracking'),

('ALGO', 'GOOGLE', 'BACKTRACKING', 'Subsets II', '# Subsets II

Return all subsets from array with duplicates (no duplicate subsets).

**Example:**
```
Input: nums = [1,2,2]
Output: [[],[1],[1,2],[1,2,2],[2],[2,2]]
```', 'Hint 1: Sort array to group duplicates.
---
Hint 2: Skip duplicates at same level.
---
Hint 3: Use i > start check.', 'MEDIUM', 'array,backtracking,bit-manipulation'),

('ALGO', 'META', 'BACKTRACKING', 'Combination Sum II', '# Combination Sum II

Like Combination Sum but each number used once, array may have duplicates.

**Example:**
```
Input: candidates = [10,1,2,7,6,1,5], target = 8
Output: [[1,1,6],[1,2,5],[1,7],[2,6]]
```', 'Hint 1: Sort first to handle duplicates.
---
Hint 2: Skip duplicates at same level.
---
Hint 3: Each element used once (increment start).', 'MEDIUM', 'array,backtracking'),

('ALGO', 'LEETCODE', 'BACKTRACKING', 'Combination Sum III', '# Combination Sum III

Find k numbers that add up to n, using only 1-9, each used once.

**Example:**
```
Input: k = 3, n = 7
Output: [[1,2,4]]
```', 'Hint 1: Backtrack with remaining k and n.
---
Hint 2: Try digits 1-9.
---
Hint 3: Prune when remaining < 0.', 'MEDIUM', 'array,backtracking'),

('ALGO', 'AMAZON', 'BACKTRACKING', 'Word Search II', '# Word Search II

Find all words from list that exist in 2D board.

**Example:**
```
Input: board = [["o","a","a","n"],["e","t","a","e"]], words = ["oath","pea","eat","rain"]
Output: ["eat","oath"]
```', 'Hint 1: Build Trie from word list.
---
Hint 2: DFS from each cell with Trie matching.
---
Hint 3: Mark found words to avoid duplicates.', 'HARD', 'array,string,backtracking,trie,matrix'),

('ALGO', 'GOOGLE', 'BACKTRACKING', 'Expression Add Operators', '# Expression Add Operators

Add +, -, or * between digits to get target value.

**Example:**
```
Input: num = "123", target = 6
Output: ["1*2*3","1+2+3"]
```', 'Hint 1: Backtrack with current value and last operand.
---
Hint 2: Handle multiplication by subtracting last and adding last*curr.
---
Hint 3: Avoid leading zeros in numbers.', 'HARD', 'string,backtracking,math'),

('ALGO', 'META', 'BACKTRACKING', 'Beautiful Arrangement', '# Beautiful Arrangement

Count arrangements where nums[i] % i == 0 or i % nums[i] == 0.

**Example:**
```
Input: n = 2
Output: 2 ([1,2] and [2,1])
```', 'Hint 1: Backtrack position by position.
---
Hint 2: Try each unused number that satisfies condition.
---
Hint 3: Use visited set or swap approach.', 'MEDIUM', 'array,backtracking,dynamic-programming,bit-manipulation,bitmask'),

('ALGO', 'LEETCODE', 'BACKTRACKING', 'Letter Case Permutation', '# Letter Case Permutation

Generate all permutations by changing letter case.

**Example:**
```
Input: s = "a1b2"
Output: ["a1b2","a1B2","A1b2","A1B2"]
```', 'Hint 1: For each letter, choose lowercase or uppercase.
---
Hint 2: Skip non-letters.
---
Hint 3: Backtrack with current index.', 'MEDIUM', 'string,backtracking,bit-manipulation'),

('ALGO', 'AMAZON', 'BACKTRACKING', 'Split Array into Fibonacci Sequence', '# Split Array into Fibonacci Sequence

Split string into Fibonacci-like sequence.

**Example:**
```
Input: num = "1101111"
Output: [11,0,11,11]
```', 'Hint 1: Backtrack to find first two numbers.
---
Hint 2: Check if remaining forms valid Fibonacci.
---
Hint 3: Numbers must fit in 32-bit integer.', 'MEDIUM', 'string,backtracking'),

('ALGO', 'GOOGLE', 'BACKTRACKING', 'Matchsticks to Square', '# Matchsticks to Square

Determine if matchsticks can form a square (4 equal sides).

**Example:**
```
Input: matchsticks = [1,1,2,2,2]
Output: true
```', 'Hint 1: Total must be divisible by 4.
---
Hint 2: Backtrack to fill 4 sides of length total/4.
---
Hint 3: Sort descending for better pruning.', 'MEDIUM', 'array,backtracking,dynamic-programming,bit-manipulation,bitmask'),

('ALGO', 'META', 'BACKTRACKING', 'Partition to K Equal Sum Subsets', '# Partition to K Equal Sum Subsets

Partition array into k non-empty subsets with equal sum.

**Example:**
```
Input: nums = [4,3,2,3,5,2,1], k = 4
Output: true
```', 'Hint 1: Check if sum divisible by k.
---
Hint 2: Backtrack to fill k buckets of size sum/k.
---
Hint 3: Sort descending, prune early.', 'MEDIUM', 'array,backtracking,dynamic-programming,bit-manipulation,memoization,bitmask'),

('ALGO', 'LEETCODE', 'BACKTRACKING', 'Additive Number', '# Additive Number

Check if string can form additive sequence (each num = sum of previous two).

**Example:**
```
Input: "112358"
Output: true (1+1=2, 1+2=3, 2+3=5, 3+5=8)
```', 'Hint 1: Try all combinations for first two numbers.
---
Hint 2: Check if remaining forms valid sequence.
---
Hint 3: Handle leading zeros and large numbers.', 'MEDIUM', 'string,backtracking'),

('ALGO', 'AMAZON', 'BACKTRACKING', 'Remove Invalid Parentheses', '# Remove Invalid Parentheses

Remove minimum invalid parentheses to make string valid.

**Example:**
```
Input: s = "()())()"
Output: ["(())()","()()()"]
```', 'Hint 1: Count mismatched left and right parentheses.
---
Hint 2: Backtrack, removing exactly that many.
---
Hint 3: Use set to avoid duplicate results.', 'HARD', 'string,backtracking,breadth-first-search'),

('ALGO', 'GOOGLE', 'BACKTRACKING', 'Wildcard Matching', '# Wildcard Matching

Match string with pattern containing ? (any char) and * (any sequence).

**Example:**
```
Input: s = "aa", p = "*"
Output: true
```', 'Hint 1: Use DP or backtracking with memoization.
---
Hint 2: Handle * by trying 0 to all remaining chars.
---
Hint 3: ? matches exactly one character.', 'HARD', 'string,backtracking,dynamic-programming,greedy');
