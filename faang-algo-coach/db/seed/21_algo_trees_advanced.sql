-- Advanced Tree Problems - 15 Problems (Pattern Not Obvious)

USE faang;

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags) VALUES

('ALGO', 'GOOGLE', 'TREES', 'Verify Preorder Serialization', '# Verify Preorder Serialization

Given a string representing preorder traversal of a binary tree where # represents null, determine if it is a valid serialization.

**Example:**
```
Input: preorder = "9,3,4,#,#,1,#,#,2,#,6,#,#"
Output: true

Input: preorder = "1,#"
Output: false

Input: preorder = "9,#,#,1"
Output: false
```', 'Hint 1: Think about node capacity - each node provides 2 children slots but consumes 1 slot.
---
Hint 2: Track available slots: start with 1, each non-null adds 2 and uses 1 (net +1), null uses 1 (net -1).
---
Hint 3: Slots should never go negative during traversal and should end at 0.', '## Solution: Slot Counting

Track available slots:
- Start with 1 slot (root)
- Non-null node: -1 (uses slot) +2 (adds children) = +1
- Null node: -1 (uses slot)
- Valid if slots stay ≥ 0 during traversal and end at 0

Time: O(n), Space: O(1)', 'MEDIUM', 'tree,string,stack,serialization'),

('ALGO', 'META', 'TREES', 'Closest Common Manager', '# Closest Common Manager

Given a company org chart (tree) and two employees, find their closest common manager (lowest common ancestor).

**Example:**
```
Input: root = [CEO, [ManagerA, [Emp1, Emp2]], [ManagerB, [Emp3]]], emp1 = Emp1, emp2 = Emp2
Output: ManagerA

Input: root = [CEO, [ManagerA, [Emp1]], [ManagerB, [Emp2]]], emp1 = Emp1, emp2 = Emp2
Output: CEO
```', 'Hint 1: This is the Lowest Common Ancestor (LCA) problem.
---
Hint 2: Recursively search for both employees.
---
Hint 3: First node that has both employees in its subtree is the LCA.', '## Solution: LCA Algorithm

Recursive approach:
- If current node is null or matches either employee, return it
- Recursively search left and right subtrees
- If both return non-null, current node is LCA
- If only one returns non-null, return that one

Time: O(n), Space: O(h)', 'MEDIUM', 'tree,dfs,recursion,lca'),

('ALGO', 'AMAZON', 'TREES', 'Maximum Path Value Sum', '# Maximum Path Value Sum

Given a binary tree, find the maximum sum path between any two nodes. The path must contain at least one node.

**Example:**
```
Input: root = [10, 2, 10, 20, 1, null, -25, null, null, null, null, 3, 4]
Output: 42
Explanation: Path 20→2→10→10

Input: root = [-10]
Output: -10
```', 'Hint 1: At each node, calculate max path sum going through that node.
---
Hint 2: For each node, max path = node.val + max(left_path, 0) + max(right_path, 0).
---
Hint 3: Use post-order traversal, return max single-branch path to parent.', '## Solution: Post-order DFS

For each node:
- Calculate max path ending at this node (for parent)
- Calculate max path through this node (for global answer)
- Return single-branch max to parent

Time: O(n), Space: O(h)', 'HARD', 'tree,dfs,recursion,post-order'),

('ALGO', 'GOOGLE', 'TREES', 'Serialize and Deserialize Binary Tree', '# Serialize and Deserialize Binary Tree

Design an algorithm to serialize and deserialize a binary tree. Serialization converts tree to string, deserialization converts string back to tree.

**Example:**
```
Input: root = [1, 2, 3, null, null, 4, 5]
Output: "1,2,#,#,3,4,#,#,5,#,#" (example format)
Then deserialize should return original tree
```', 'Hint 1: Use preorder or level-order traversal for serialization.
---
Hint 2: Include null markers (#) in serialization.
---
Hint 3: Use queue for level-order or recursion for preorder deserialization.', '## Solution: Preorder Traversal

Serialize:
- Preorder traversal with null markers
- Join with delimiter

Deserialize:
- Split string into tokens
- Recursively build tree using preorder

Time: O(n) for both, Space: O(n)', 'HARD', 'tree,dfs,bfs,string,serialization'),

('ALGO', 'META', 'TREES', 'Count Complete Tree Nodes', '# Count Complete Tree Nodes

Given a complete binary tree, count the number of nodes. A complete binary tree has all levels fully filled except possibly the last level, which is filled from left to right.

**Example:**
```
Input: root = [1, 2, 3, 4, 5, 6]
Output: 6

Input: root = []
Output: 0

Input: root = [1]
Output: 1
```', 'Hint 1: Complete tree property allows binary search.
---
Hint 2: If left height == right height, tree is perfect (2^h - 1 nodes).
---
Hint 3: Otherwise, recursively count left and right subtrees.', '## Solution: Binary Search on Tree Height

Check if subtree is perfect:
- If leftmost depth == rightmost depth, subtree is perfect
- Count = 2^h - 1
- Otherwise, recursively count both subtrees + 1

Time: O(log²n), Space: O(logn)', 'MEDIUM', 'tree,binary-search,complete-tree'),

('ALGO', 'AMAZON', 'TREES', 'Construct Tree from Traversals', '# Construct Tree from Traversals

Given preorder and inorder traversal arrays, construct the binary tree and return its root.

**Example:**
```
Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
Output: [3, 9, 20, null, null, 15, 7]

Input: preorder = [-1], inorder = [-1]
Output: [-1]
```', 'Hint 1: First element of preorder is always root.
---
Hint 2: Find root in inorder to split left and right subtrees.
---
Hint 3: Recursively build left and right subtrees.', '## Solution: Recursive Construction

1. First preorder element is root
2. Find root position in inorder
3. Left subtree: inorder[0..pos-1], corresponding preorder slice
4. Right subtree: inorder[pos+1..], corresponding preorder slice
5. Recursively build both subtrees

Time: O(n), Space: O(n)', 'MEDIUM', 'tree,recursion,hash-table,traversal'),

('ALGO', 'GOOGLE', 'TREES', 'Validate Binary Search Tree', '# Validate Binary Search Tree

Given a binary tree, determine if it is a valid binary search tree (BST).

**Example:**
```
Input: root = [2, 1, 3]
Output: true

Input: root = [5, 1, 4, null, null, 3, 6]
Output: false
Explanation: Root 5''s right child 4 < 5
```', 'Hint 1: Each node must be within a valid range [min, max].
---
Hint 2: For left child, max = parent value. For right child, min = parent value.
---
Hint 3: Or use inorder traversal - should be strictly increasing.', '## Solution: Range Validation or Inorder

Approach 1: Pass valid range to each node
- Left child: (min, node.val)
- Right child: (node.val, max)

Approach 2: Inorder traversal should be strictly increasing

Time: O(n), Space: O(h)', 'MEDIUM', 'tree,dfs,bst,recursion'),

('ALGO', 'META', 'TREES', 'Kth Smallest Element in BST', '# Kth Smallest Element in BST

Given root of BST and integer k, return the kth smallest value (1-indexed).

**Example:**
```
Input: root = [3, 1, 4, null, 2], k = 1
Output: 1

Input: root = [5, 3, 6, 2, 4, null, null, 1], k = 3
Output: 3
```', 'Hint 1: Inorder traversal of BST gives sorted order.
---
Hint 2: Stop at kth element during inorder traversal.
---
Hint 3: Can also use iterative inorder with stack.', '## Solution: Inorder Traversal

Perform inorder traversal:
- Keep counter
- Return kth element

Can be iterative with stack or recursive.

Time: O(h + k), Space: O(h)', 'MEDIUM', 'tree,dfs,bst,inorder'),

('ALGO', 'AMAZON', 'TREES', 'Recover Binary Search Tree', '# Recover Binary Search Tree

Two nodes of a BST are swapped by mistake. Recover the tree without changing its structure. Use O(1) space.

**Example:**
```
Input: root = [1, 3, null, null, 2]
Output: [3, 1, null, null, 2]
Explanation: 3 and 1 are swapped

Input: root = [3, 1, 4, null, null, 2]
Output: [2, 1, 4, null, null, 3]
```', 'Hint 1: Inorder traversal should be sorted.
---
Hint 2: Find two places where order is violated.
---
Hint 3: Use Morris traversal for O(1) space.', '## Solution: Inorder with Morris Traversal

Track two swapped nodes during inorder:
- First violation: prev is first swapped
- Second violation: current is second swapped
- Swap their values

Use Morris for O(1) space.

Time: O(n), Space: O(1) or O(h)', 'MEDIUM', 'tree,dfs,bst,inorder,morris'),

('ALGO', 'GOOGLE', 'TREES', 'Binary Tree Vertical Order Traversal', '# Binary Tree Vertical Order Traversal

Given binary tree, return vertical order traversal as list of lists. Nodes in same column should be ordered top to bottom.

**Example:**
```
Input: root = [3, 9, 20, null, null, 15, 7]
Output: [[9], [3, 15], [20], [7]]

Input: root = [3, 9, 8, 4, 0, 1, 7]
Output: [[4], [9], [3, 0, 1], [8], [7]]
```', 'Hint 1: Use BFS with (node, column) tracking.
---
Hint 2: Use hash map: column → list of nodes.
---
Hint 3: Track min and max columns to maintain order.', '## Solution: BFS with Column Tracking

BFS with queue storing (node, column, level):
- Left child: column - 1
- Right child: column + 1
- Group by column
- Sort by column index

Time: O(n log n), Space: O(n)', 'HARD', 'tree,bfs,hash-table,sorting'),

('ALGO', 'META', 'TREES', 'Flatten Tree to Linked List', '# Flatten Tree to Linked List

Given binary tree, flatten it to a linked list in-place where right pointers point to next node and left pointers are null. Order should be preorder traversal.

**Example:**
```
Input: root = [1, 2, 5, 3, 4, null, 6]
Output: [1, null, 2, null, 3, null, 4, null, 5, null, 6]

Input: root = []
Output: []
```', 'Hint 1: Preorder traversal: root → left → right.
---
Hint 2: Recursively flatten left and right subtrees.
---
Hint 3: Attach flattened left to right, then attach original right.', '## Solution: Recursive Flattening

For each node:
1. Flatten left and right subtrees
2. Store original right
3. Move left subtree to right
4. Attach original right to end of new right
5. Set left to null

Time: O(n), Space: O(h)', 'MEDIUM', 'tree,dfs,recursion,linked-list'),

('ALGO', 'AMAZON', 'TREES', 'Boundary Traversal of Binary Tree', '# Boundary Traversal of Binary Tree

Given binary tree, return boundary traversal: left boundary (top-down) → leaves (left-right) → right boundary (bottom-up). Exclude duplicates.

**Example:**
```
Input: root = [1, 2, 3, 4, 5, 6, null, null, null, 7, 8, 9, 10]
Output: [1, 2, 4, 7, 8, 9, 10, 6, 3]
```', 'Hint 1: Three separate traversals: left boundary, leaves, right boundary.
---
Hint 2: Left boundary: go left, if no left go right (exclude leaves).
---
Hint 3: Right boundary: go right, if no right go left (exclude leaves, reverse order).', '## Solution: Three-part Traversal

1. Add root
2. Add left boundary (top-down, no leaves)
3. Add all leaves (left-right)
4. Add right boundary (bottom-up, no leaves)

Time: O(n), Space: O(h)', 'MEDIUM', 'tree,dfs,traversal'),

('ALGO', 'GOOGLE', 'TREES', 'Distance Between Nodes', '# Distance Between Nodes

Given a binary tree, two nodes p and q, find the distance (number of edges) between them.

**Example:**
```
Input: root = [3, 5, 1, 6, 2, 0, 8, null, null, 7, 4], p = 5, q = 1
Output: 3
Explanation: Path 5→3→1

Input: root = [3, 5, 1, 6, 2, 0, 8, null, null, 7, 4], p = 5, q = 4
Output: 3
Explanation: Path 5→2→4
```', 'Hint 1: Find LCA of p and q.
---
Hint 2: Distance = distance(LCA, p) + distance(LCA, q).
---
Hint 3: Find depths using DFS.', '## Solution: LCA + Depth

1. Find LCA of p and q
2. Find depth of p from LCA
3. Find depth of q from LCA
4. Distance = depth_p + depth_q

Time: O(n), Space: O(h)', 'MEDIUM', 'tree,dfs,lca,recursion'),

('ALGO', 'META', 'TREES', 'All Nodes Distance K', '# All Nodes Distance K

Given binary tree, target node, and integer k, return values of all nodes that are distance k from target.

**Example:**
```
Input: root = [3, 5, 1, 6, 2, 0, 8, null, null, 7, 4], target = 5, k = 2
Output: [7, 4, 1]
Explanation: Nodes 7, 4 are 2 edges down from 5, node 1 is 2 edges up

Input: root = [1], target = 1, k = 3
Output: []
```', 'Hint 1: Build parent pointers or graph representation.
---
Hint 2: BFS from target node treating tree as undirected graph.
---
Hint 3: Track visited to avoid cycles.', '## Solution: BFS with Parent Pointers

1. Build parent pointer map (one DFS pass)
2. BFS from target node
3. Explore children and parent (treat as graph)
4. Track visited
5. Return nodes at distance k

Time: O(n), Space: O(n)', 'MEDIUM', 'tree,bfs,dfs,hash-table,graph'),

('ALGO', 'LEETCODE', 'TREES', 'House Robber on Tree', '# House Robber on Tree

Houses are arranged in a tree structure. A robber cannot rob two directly-linked houses. Given tree where each node has a value, find maximum amount robber can steal.

**Example:**
```
Input: root = [3, 2, 3, null, 3, null, 1]
Output: 7
Explanation: Rob 3 + 3 + 1 = 7

Input: root = [3, 4, 5, 1, 3, null, 1]
Output: 9
Explanation: Rob 4 + 5 = 9
```', 'Hint 1: DP on tree - for each node, track two states: rob or not rob.
---
Hint 2: If rob current, cannot rob children. If not rob, can rob or not rob children.
---
Hint 3: Post-order traversal to compute bottom-up.', '## Solution: Tree DP

For each node, return [rob, not_rob]:
- rob: node.val + sum(not_rob of children)
- not_rob: sum(max(rob, not_rob) of children)

Post-order DFS.

Time: O(n), Space: O(h)', 'MEDIUM', 'tree,dfs,dynamic-programming,recursion');
