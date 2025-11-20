-- Advanced Matrix Problems - 15 Problems (Pattern Not Obvious)

USE faang;

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags) VALUES

('ALGO', 'GOOGLE', 'MATRIX', 'Surrounded Regions Capture', '# Surrounded Regions Capture

Given m×n board with ''X'' and ''O'', capture all regions surrounded by ''X''. A region is captured by flipping all ''O''s into ''X''s. Surrounded means all 4 directions lead to ''X'' (not edges).

**Example:**
```
Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
Explanation: Surrounded regions are flipped, edge-connected regions remain
```', 'Hint 1: Regions connected to edges cannot be captured.
---
Hint 2: DFS/BFS from all edge ''O''s to mark safe regions.
---
Hint 3: Flip all unmarked ''O''s to ''X''.', '## Solution: DFS/BFS from Edges

1. Mark all ''O''s connected to edges as safe (DFS/BFS)
2. Flip all other ''O''s to ''X''
3. Restore safe ''O''s

Time: O(m*n), Space: O(m*n)', 'MEDIUM', 'matrix,dfs,bfs,flood-fill'),

('ALGO', 'META', 'MATRIX', 'Island Perimeter Calculator', '# Island Perimeter Calculator

Given 2D grid where 1 represents land and 0 represents water, calculate the perimeter of the island. There is exactly one island and no lakes.

**Example:**
```
Input: grid = [[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]
Output: 16

Input: grid = [[1]]
Output: 4
```', 'Hint 1: Count edges exposed to water or boundary.
---
Hint 2: For each land cell, check 4 neighbors.
---
Hint 3: Add 1 to perimeter for each water/boundary neighbor.', '## Solution: Count Edges

For each land cell:
- Add 4 to perimeter
- Subtract 2 for each adjacent land cell (shared edge)

Or count each edge exposed to water/boundary.

Time: O(m*n), Space: O(1)', 'EASY', 'matrix,array,counting'),

('ALGO', 'AMAZON', 'MATRIX', 'Rotate Image In-Place', '# Rotate Image In-Place

Given n×n 2D matrix representing an image, rotate it 90 degrees clockwise in-place.

**Example:**
```
Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [[7,4,1],[8,5,2],[9,6,3]]

Input: matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
Output: [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
```', 'Hint 1: Rotation = Transpose + Reverse rows.
---
Hint 2: Or rotate layer by layer from outside to inside.
---
Hint 3: Process 4 cells at a time in circular fashion.', '## Solution: Transpose + Reverse

Two approaches:
1. Transpose matrix, then reverse each row
2. Rotate layer by layer (4-way swap)

Both work in-place.

Time: O(n²), Space: O(1)', 'MEDIUM', 'matrix,array,transformation'),

('ALGO', 'GOOGLE', 'MATRIX', 'Set Matrix Zeros', '# Set Matrix Zeros

Given m×n matrix, if element is 0, set its entire row and column to 0. Do it in-place.

**Example:**
```
Input: matrix = [[1,1,1],[1,0,1],[1,1,1]]
Output: [[1,0,1],[0,0,0],[1,0,1]]

Input: matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]
```', 'Hint 1: Cannot modify while scanning, need to mark rows/columns.
---
Hint 2: Use first row and column as markers.
---
Hint 3: Need separate flag for first row/column themselves.', '## Solution: First Row/Column as Markers

1. Use first row/column to mark which rows/columns to zero
2. Use separate variables for first row/column
3. Process matrix based on markers
4. Handle first row/column last

Time: O(m*n), Space: O(1)', 'MEDIUM', 'matrix,array,hash-table'),

('ALGO', 'META', 'MATRIX', 'Spiral Matrix Traversal', '# Spiral Matrix Traversal

Given m×n matrix, return all elements in spiral order (clockwise from outside to inside).

**Example:**
```
Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,2,3,6,9,8,7,4,5]

Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
Output: [1,2,3,4,8,12,11,10,9,5,6,7]
```', 'Hint 1: Use four boundaries: top, bottom, left, right.
---
Hint 2: Move right, down, left, up, then shrink boundaries.
---
Hint 3: Continue until boundaries cross.', '## Solution: Layer-by-Layer

Track 4 boundaries, traverse in spiral:
1. Left to right on top row
2. Top to bottom on right column
3. Right to left on bottom row
4. Bottom to top on left column
5. Shrink boundaries, repeat

Time: O(m*n), Space: O(1)', 'MEDIUM', 'matrix,array,traversal'),

('ALGO', 'AMAZON', 'MATRIX', 'Search in Row-Column Sorted Matrix', '# Search in Row-Column Sorted Matrix

Given m×n matrix where each row is sorted left to right and each column is sorted top to bottom, search for a target value.

**Example:**
```
Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 5
Output: true

Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 20
Output: false
```', 'Hint 1: Start from top-right or bottom-left corner.
---
Hint 2: If target > current, move down. If target < current, move left.
---
Hint 3: This eliminates one row or column at each step.', '## Solution: Staircase Search

Start at top-right:
- If target > current: go down
- If target < current: go left
- If equal: found
- If out of bounds: not found

Time: O(m+n), Space: O(1)', 'MEDIUM', 'matrix,binary-search,divide-conquer'),

('ALGO', 'GOOGLE', 'MATRIX', 'Longest Line of Consecutive Ones', '# Longest Line of Consecutive Ones

Given binary matrix, find the length of the longest line of consecutive 1s. The line could be horizontal, vertical, diagonal, or anti-diagonal.

**Example:**
```
Input: mat = [[0,1,1,0],[0,1,1,0],[0,0,0,1]]
Output: 3

Input: mat = [[1,1,0,0,1],[1,1,0,0,0],[0,0,0,1,0]]
Output: 3
```', 'Hint 1: DP with 4 directions for each cell.
---
Hint 2: dp[i][j][d] = length of consecutive 1s ending at (i,j) in direction d.
---
Hint 3: Four directions: horizontal, vertical, diagonal, anti-diagonal.', '## Solution: 3D DP

For each cell with 1:
- Track longest line ending at this cell in 4 directions
- dp[i][j][0] = horizontal from left
- dp[i][j][1] = vertical from top
- dp[i][j][2] = diagonal from top-left
- dp[i][j][3] = anti-diagonal from top-right

Time: O(m*n), Space: O(m*n)', 'MEDIUM', 'matrix,dynamic-programming,array'),

('ALGO', 'META', 'MATRIX', 'Maximal Square of Ones', '# Maximal Square of Ones

Given binary matrix, find the largest square containing only 1s and return its area.

**Example:**
```
Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
Output: 4
Explanation: 2×2 square

Input: matrix = [["0","1"],["1","0"]]
Output: 1
```', 'Hint 1: DP where dp[i][j] = side length of largest square with bottom-right at (i,j).
---
Hint 2: If matrix[i][j] = 1, check top, left, and top-left.
---
Hint 3: dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1.', '## Solution: 2D DP

dp[i][j] = max square side ending at (i,j):
- If matrix[i][j] == ''1'':
  - dp[i][j] = min(top, left, top-left) + 1
- Track max side length
- Return side²

Time: O(m*n), Space: O(m*n) or O(n)', 'MEDIUM', 'matrix,dynamic-programming,array'),

('ALGO', 'AMAZON', 'MATRIX', 'Valid Sudoku Checker', '# Valid Sudoku Checker

Determine if a 9×9 Sudoku board is valid. Only filled cells need to be validated according to rules:
1. Each row must contain digits 1-9 without repetition
2. Each column must contain digits 1-9 without repetition
3. Each 3×3 sub-box must contain digits 1-9 without repetition

**Example:**
```
Input: board = [["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]]
Output: true
```', 'Hint 1: Use hash sets to track seen numbers in rows, columns, boxes.
---
Hint 2: Box index can be calculated as (row/3)*3 + col/3.
---
Hint 3: Single pass through matrix.', '## Solution: Hash Set Validation

Use three sets:
- rows[i]: numbers in row i
- cols[j]: numbers in column j
- boxes[k]: numbers in box k

Single pass, check for duplicates.

Time: O(1) - fixed 9×9, Space: O(1)', 'MEDIUM', 'matrix,hash-table,array'),

('ALGO', 'GOOGLE', 'MATRIX', 'Count Islands in Grid', '# Count Islands in Grid

Given 2D grid of ''1''s (land) and ''0''s (water), count the number of islands. An island is surrounded by water and formed by connecting adjacent lands horizontally or vertically.

**Example:**
```
Input: grid = [["1","1","1","1","0"],["1","1","0","1","0"],["1","1","0","0","0"],["0","0","0","0","0"]]
Output: 1

Input: grid = [["1","1","0","0","0"],["1","1","0","0","0"],["0","0","1","0","0"],["0","0","0","1","1"]]
Output: 3
```', 'Hint 1: DFS or BFS to explore each island.
---
Hint 2: Mark visited cells to avoid recounting.
---
Hint 3: Count number of DFS/BFS calls needed.', '## Solution: DFS/BFS

For each unvisited land cell:
- Start DFS/BFS to mark entire island
- Increment island count
- Continue scanning

Time: O(m*n), Space: O(m*n)', 'MEDIUM', 'matrix,dfs,bfs,union-find,graph'),

('ALGO', 'META', 'MATRIX', 'Shortest Bridge Between Islands', '# Shortest Bridge Between Islands

Given binary matrix with exactly two islands (groups of 1s), find the smallest number of 0s you must flip to connect the two islands.

**Example:**
```
Input: grid = [[0,1],[1,0]]
Output: 1

Input: grid = [[0,1,0],[0,0,0],[0,0,1]]
Output: 2

Input: grid = [[1,1,1,1,1],[1,0,0,0,1],[1,0,1,0,1],[1,0,0,0,1],[1,1,1,1,1]]
Output: 1
```', 'Hint 1: Find first island with DFS, mark all cells.
---
Hint 2: BFS from all cells of first island to find second island.
---
Hint 3: Distance traveled is the bridge length.', '## Solution: DFS + BFS

1. DFS to find and mark first island
2. Multi-source BFS from all cells of first island
3. First time we hit second island = shortest distance

Time: O(m*n), Space: O(m*n)', 'MEDIUM', 'matrix,dfs,bfs,shortest-path'),

('ALGO', 'AMAZON', 'MATRIX', 'Diagonal Traverse', '# Diagonal Traverse

Given m×n matrix, return all elements in diagonal order.

**Example:**
```
Input: mat = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,2,4,7,5,3,6,8,9]

Input: mat = [[1,2],[3,4]]
Output: [1,2,3,4]
```', 'Hint 1: Traverse diagonals alternating up-right and down-left.
---
Hint 2: Track direction and boundaries.
---
Hint 3: When hitting boundary, change direction and adjust position.', '## Solution: Diagonal Traversal with Direction

Alternate between:
- Up-right diagonal (decrease row, increase col)
- Down-left diagonal (increase row, decrease col)

Handle boundaries carefully.

Time: O(m*n), Space: O(1)', 'MEDIUM', 'matrix,array,traversal'),

('ALGO', 'GOOGLE', 'MATRIX', 'Lucky Numbers in Matrix', '# Lucky Numbers in Matrix

Given m×n matrix of distinct integers, return all lucky numbers. A lucky number is an element that is minimum in its row and maximum in its column.

**Example:**
```
Input: matrix = [[3,7,8],[9,11,13],[15,16,17]]
Output: [15]
Explanation: 15 is minimum in its row and maximum in its column

Input: matrix = [[1,10,4,2],[9,3,8,7],[15,16,17,12]]
Output: [12]
```', 'Hint 1: Find minimum of each row and maximum of each column.
---
Hint 2: Check if any cell satisfies both conditions.
---
Hint 3: Can optimize with sets or two passes.', '## Solution: Row Min & Column Max

1. Find min of each row → store in array
2. Find max of each column → store in array
3. Check each cell if it equals both its row min and column max

Time: O(m*n), Space: O(m+n)', 'EASY', 'matrix,array'),

('ALGO', 'META', 'MATRIX', 'Dungeon Game Health Calculator', '# Dungeon Game Health Calculator

Given m×n dungeon grid with values (negative = demons, positive = magic orbs), you start at top-left and want to reach bottom-right. What is the minimum initial health needed to reach the end? Health cannot drop to 0 or below.

**Example:**
```
Input: dungeon = [[-2,-3,3],[-5,-10,1],[10,30,-5]]
Output: 7
Explanation: Path -2 → -3 → 3 → 1 → -5 requires starting health of 7

Input: dungeon = [[0]]
Output: 1
```', 'Hint 1: Work backwards from bottom-right.
---
Hint 2: dp[i][j] = minimum health needed when entering cell (i,j).
---
Hint 3: Health needed = max(1, min_health_for_next - dungeon[i][j]).', '## Solution: DP (Reverse Direction)

Work backwards from destination:
- dp[i][j] = min health needed at (i,j)
- dp[i][j] = max(1, min(dp[i+1][j], dp[i][j+1]) - dungeon[i][j])
- Base: dp[m-1][n-1] = max(1, 1 - dungeon[m-1][n-1])

Time: O(m*n), Space: O(m*n) or O(n)', 'HARD', 'matrix,dynamic-programming,array'),

('ALGO', 'LEETCODE', 'MATRIX', 'Kth Smallest Element in Sorted Matrix', '# Kth Smallest Element in Sorted Matrix

Given n×n matrix where each row and column is sorted in ascending order, find the kth smallest element.

**Example:**
```
Input: matrix = [[1,5,9],[10,11,13],[12,13,15]], k = 8
Output: 13

Input: matrix = [[-5]], k = 1
Output: -5
```', 'Hint 1: Binary search on value range.
---
Hint 2: For mid value, count how many elements ≤ mid.
---
Hint 3: Adjust range based on count vs k.', '## Solution: Binary Search on Value

Binary search on answer:
- Low = matrix[0][0], High = matrix[n-1][n-1]
- For mid, count elements ≤ mid
- If count < k, search right; else search left

Time: O(n * log(max-min)), Space: O(1)', 'MEDIUM', 'matrix,binary-search,heap,sorted');
