-- Trees Arena - 25 Problems (10 with full solutions)

USE faang;

-- Problem 1: Maximum Depth of Binary Tree (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'TREES',
    'Maximum Depth of Binary Tree',
    '# Maximum Depth of Binary Tree

Given the root of a binary tree, return its maximum depth (number of nodes along the longest path from root to farthest leaf).

**Example:**
```
Input: root = [3,9,20,null,null,15,7]
Output: 3
```',
    'Hint 1: Use recursion to traverse the tree.
---
Hint 2: Depth = 1 + max(leftDepth, rightDepth).
---
Hint 3: Base case: null node has depth 0.',
    'class Solution {
    public int maxDepth(TreeNode root) {
        if (root == null) return 0;
        return 1 + Math.max(maxDepth(root.left), maxDepth(root.right));
    }
}',
    'class Solution {
    fun maxDepth(root: TreeNode?): Int {
        if (root == null) return 0
        return 1 + maxOf(maxDepth(root.left), maxDepth(root.right))
    }
}',
    '## Solution: Recursion

Time Complexity: O(n)
Space Complexity: O(h) where h is height (recursion stack)

Simple recursive DFS approach.',
    'EASY',
    'tree,depth-first-search,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[3,9,20,null,null,15,7]', '3', FALSE),
    (LAST_INSERT_ID(), '[1,null,2]', '2', FALSE);

-- Problem 2: Same Tree (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'TREES',
    'Same Tree',
    '# Same Tree

Given roots of two binary trees p and q, check if they are the same (structurally identical with same node values).

**Example:**
```
Input: p = [1,2,3], q = [1,2,3]
Output: true
```',
    'Hint 1: Use recursion to compare nodes.
---
Hint 2: Check if both null, one null, or values differ.
---
Hint 3: Recursively check left and right subtrees.',
    'class Solution {
    public boolean isSameTree(TreeNode p, TreeNode q) {
        if (p == null && q == null) return true;
        if (p == null || q == null) return false;
        if (p.val != q.val) return false;
        return isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
    }
}',
    'class Solution {
    fun isSameTree(p: TreeNode?, q: TreeNode?): Boolean {
        if (p == null && q == null) return true
        if (p == null || q == null) return false
        if (p.`val` != q.`val`) return false
        return isSameTree(p.left, q.left) && isSameTree(p.right, q.right)
    }
}',
    '## Solution: Recursive Comparison

Time Complexity: O(n)
Space Complexity: O(h)

Compare trees recursively node by node.',
    'EASY',
    'tree,depth-first-search,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3],[1,2,3]', 'true', FALSE),
    (LAST_INSERT_ID(), '[1,2],[1,null,2]', 'false', FALSE);

-- Problem 3: Invert Binary Tree (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'TREES',
    'Invert Binary Tree',
    '# Invert Binary Tree

Given the root of a binary tree, invert the tree (mirror it).

**Example:**
```
Input: root = [4,2,7,1,3,6,9]
Output: [4,7,2,9,6,3,1]
```',
    'Hint 1: Swap left and right children for each node.
---
Hint 2: Recursively invert left and right subtrees.
---
Hint 3: Post-order or pre-order traversal works.',
    'class Solution {
    public TreeNode invertTree(TreeNode root) {
        if (root == null) return null;
        TreeNode temp = root.left;
        root.left = invertTree(root.right);
        root.right = invertTree(temp);
        return root;
    }
}',
    'class Solution {
    fun invertTree(root: TreeNode?): TreeNode? {
        if (root == null) return null
        val temp = root.left
        root.left = invertTree(root.right)
        root.right = invertTree(temp)
        return root
    }
}',
    '## Solution: Recursive Swap

Time Complexity: O(n)
Space Complexity: O(h)

Recursively swap left and right subtrees.',
    'EASY',
    'tree,depth-first-search,breadth-first-search,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[4,2,7,1,3,6,9]', '[4,7,2,9,6,3,1]', FALSE),
    (LAST_INSERT_ID(), '[2,1,3]', '[2,3,1]', FALSE);

-- Problem 4: Symmetric Tree (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'TREES',
    'Symmetric Tree',
    '# Symmetric Tree

Given root of a binary tree, check whether it is a mirror of itself (symmetric around its center).

**Example:**
```
Input: root = [1,2,2,3,4,4,3]
Output: true
```',
    'Hint 1: Compare left subtree with right subtree.
---
Hint 2: Left.left should equal Right.right.
---
Hint 3: Left.right should equal Right.left.',
    'class Solution {
    public boolean isSymmetric(TreeNode root) {
        return isMirror(root, root);
    }

    private boolean isMirror(TreeNode t1, TreeNode t2) {
        if (t1 == null && t2 == null) return true;
        if (t1 == null || t2 == null) return false;
        return (t1.val == t2.val)
            && isMirror(t1.left, t2.right)
            && isMirror(t1.right, t2.left);
    }
}',
    'class Solution {
    fun isSymmetric(root: TreeNode?): Boolean {
        return isMirror(root, root)
    }

    private fun isMirror(t1: TreeNode?, t2: TreeNode?): Boolean {
        if (t1 == null && t2 == null) return true
        if (t1 == null || t2 == null) return false
        return (t1.`val` == t2.`val`)
            && isMirror(t1.left, t2.right)
            && isMirror(t1.right, t2.left)
    }
}',
    '## Solution: Recursive Mirror Check

Time Complexity: O(n)
Space Complexity: O(h)

Compare tree with itself in mirror fashion.',
    'EASY',
    'tree,depth-first-search,breadth-first-search,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,2,3,4,4,3]', 'true', FALSE),
    (LAST_INSERT_ID(), '[1,2,2,null,3,null,3]', 'false', FALSE);

-- Problem 5: Binary Tree Level Order Traversal (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'TREES',
    'Binary Tree Level Order Traversal',
    '# Binary Tree Level Order Traversal

Given root of a binary tree, return level order traversal of its nodes'' values (left to right, level by level).

**Example:**
```
Input: root = [3,9,20,null,null,15,7]
Output: [[3],[9,20],[15,7]]
```',
    'Hint 1: Use BFS with a queue.
---
Hint 2: Process nodes level by level.
---
Hint 3: Track level size before processing each level.',
    'class Solution {
    public List<List<Integer>> levelOrder(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) return result;
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            List<Integer> level = new ArrayList<>();
            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                level.add(node.val);
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            result.add(level);
        }
        return result;
    }
}',
    'class Solution {
    fun levelOrder(root: TreeNode?): List<List<Int>> {
        val result = mutableListOf<List<Int>>()
        if (root == null) return result
        val queue = ArrayDeque<TreeNode>()
        queue.add(root)
        while (queue.isNotEmpty()) {
            val levelSize = queue.size
            val level = mutableListOf<Int>()
            repeat(levelSize) {
                val node = queue.removeFirst()
                level.add(node.`val`)
                node.left?.let { queue.add(it) }
                node.right?.let { queue.add(it) }
            }
            result.add(level)
        }
        return result
    }
}',
    '## Solution: BFS

Time Complexity: O(n)
Space Complexity: O(n)

Use queue to traverse level by level.',
    'MEDIUM',
    'tree,breadth-first-search,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[3,9,20,null,null,15,7]', '[[3],[9,20],[15,7]]', FALSE),
    (LAST_INSERT_ID(), '[1]', '[[1]]', FALSE);

-- Problem 6: Validate Binary Search Tree (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'TREES',
    'Validate Binary Search Tree',
    '# Validate Binary Search Tree

Given root of a binary tree, determine if it is a valid BST.

**Example:**
```
Input: root = [2,1,3]
Output: true
```',
    'Hint 1: Every node must satisfy: left < node < right.
---
Hint 2: Use min and max bounds for each subtree.
---
Hint 3: Alternative: In-order traversal should be sorted.',
    'class Solution {
    public boolean isValidBST(TreeNode root) {
        return validate(root, null, null);
    }

    private boolean validate(TreeNode node, Integer low, Integer high) {
        if (node == null) return true;
        if ((low != null && node.val <= low) || (high != null && node.val >= high)) {
            return false;
        }
        return validate(node.left, low, node.val) && validate(node.right, node.val, high);
    }
}',
    'class Solution {
    fun isValidBST(root: TreeNode?): Boolean {
        return validate(root, null, null)
    }

    private fun validate(node: TreeNode?, low: Int?, high: Int?): Boolean {
        if (node == null) return true
        if ((low != null && node.`val` <= low) || (high != null && node.`val` >= high)) {
            return false
        }
        return validate(node.left, low, node.`val`) && validate(node.right, node.`val`, high)
    }
}',
    '## Solution: Recursive Bounds

Time Complexity: O(n)
Space Complexity: O(h)

Validate each node is within valid range.',
    'MEDIUM',
    'tree,depth-first-search,binary-search-tree,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[2,1,3]', 'true', FALSE),
    (LAST_INSERT_ID(), '[5,1,4,null,null,3,6]', 'false', FALSE);

-- Problem 7: Lowest Common Ancestor of BST (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'TREES',
    'Lowest Common Ancestor of a Binary Search Tree',
    '# Lowest Common Ancestor of a Binary Search Tree

Given a BST, find the lowest common ancestor (LCA) of two given nodes.

**Example:**
```
Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
Output: 6
```',
    'Hint 1: Use BST property: left < root < right.
---
Hint 2: If both nodes < root, LCA is in left subtree.
---
Hint 3: If both nodes > root, LCA is in right subtree.',
    'class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if (root.val > p.val && root.val > q.val) {
            return lowestCommonAncestor(root.left, p, q);
        } else if (root.val < p.val && root.val < q.val) {
            return lowestCommonAncestor(root.right, p, q);
        } else {
            return root;
        }
    }
}',
    'class Solution {
    fun lowestCommonAncestor(root: TreeNode?, p: TreeNode?, q: TreeNode?): TreeNode? {
        if (root!!.`val` > p!!.`val` && root.`val` > q!!.`val`) {
            return lowestCommonAncestor(root.left, p, q)
        } else if (root.`val` < p.`val` && root.`val` < q.`val`) {
            return lowestCommonAncestor(root.right, p, q)
        } else {
            return root
        }
    }
}',
    '## Solution: BST Properties

Time Complexity: O(h)
Space Complexity: O(h)

Use BST ordering to find split point.',
    'MEDIUM',
    'tree,depth-first-search,binary-search-tree,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[6,2,8,0,4,7,9,null,null,3,5],2,8', '6', FALSE),
    (LAST_INSERT_ID(), '[6,2,8,0,4,7,9,null,null,3,5],2,4', '2', FALSE);

-- Problem 8: Binary Tree Zigzag Level Order (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'TREES',
    'Binary Tree Zigzag Level Order Traversal',
    '# Binary Tree Zigzag Level Order Traversal

Given root, return zigzag level order traversal (left to right, then right to left alternating).

**Example:**
```
Input: root = [3,9,20,null,null,15,7]
Output: [[3],[20,9],[15,7]]
```',
    'Hint 1: Use BFS like level order traversal.
---
Hint 2: Toggle direction flag for each level.
---
Hint 3: Reverse list for right-to-left levels.',
    'class Solution {
    public List<List<Integer>> zigzagLevelOrder(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) return result;
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        boolean leftToRight = true;
        while (!queue.isEmpty()) {
            int size = queue.size();
            List<Integer> level = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                level.add(node.val);
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            if (!leftToRight) Collections.reverse(level);
            result.add(level);
            leftToRight = !leftToRight;
        }
        return result;
    }
}',
    'class Solution {
    fun zigzagLevelOrder(root: TreeNode?): List<List<Int>> {
        val result = mutableListOf<List<Int>>()
        if (root == null) return result
        val queue = ArrayDeque<TreeNode>()
        queue.add(root)
        var leftToRight = true
        while (queue.isNotEmpty()) {
            val size = queue.size
            val level = mutableListOf<Int>()
            repeat(size) {
                val node = queue.removeFirst()
                level.add(node.`val`)
                node.left?.let { queue.add(it) }
                node.right?.let { queue.add(it) }
            }
            if (!leftToRight) level.reverse()
            result.add(level)
            leftToRight = !leftToRight
        }
        return result
    }
}',
    '## Solution: BFS with Direction Toggle

Time Complexity: O(n)
Space Complexity: O(n)

Toggle traversal direction for each level.',
    'MEDIUM',
    'tree,breadth-first-search,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[3,9,20,null,null,15,7]', '[[3],[20,9],[15,7]]', FALSE),
    (LAST_INSERT_ID(), '[1]', '[[1]]', FALSE);

-- Problem 9: Serialize and Deserialize Binary Tree (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'TREES',
    'Serialize and Deserialize Binary Tree',
    '# Serialize and Deserialize Binary Tree

Design algorithm to serialize and deserialize a binary tree.

**Example:**
```
Input: root = [1,2,3,null,null,4,5]
Output: [1,2,3,null,null,4,5]
```',
    'Hint 1: Use pre-order traversal for serialization.
---
Hint 2: Use delimiter (comma) and null marker (N).
---
Hint 3: Use queue or index pointer for deserialization.',
    'public class Codec {
    public String serialize(TreeNode root) {
        StringBuilder sb = new StringBuilder();
        serializeHelper(root, sb);
        return sb.toString();
    }

    private void serializeHelper(TreeNode node, StringBuilder sb) {
        if (node == null) {
            sb.append("N,");
            return;
        }
        sb.append(node.val).append(",");
        serializeHelper(node.left, sb);
        serializeHelper(node.right, sb);
    }

    public TreeNode deserialize(String data) {
        Queue<String> queue = new LinkedList<>(Arrays.asList(data.split(",")));
        return deserializeHelper(queue);
    }

    private TreeNode deserializeHelper(Queue<String> queue) {
        String val = queue.poll();
        if (val.equals("N")) return null;
        TreeNode node = new TreeNode(Integer.parseInt(val));
        node.left = deserializeHelper(queue);
        node.right = deserializeHelper(queue);
        return node;
    }
}',
    'class Codec() {
    fun serialize(root: TreeNode?): String {
        val sb = StringBuilder()
        serializeHelper(root, sb)
        return sb.toString()
    }

    private fun serializeHelper(node: TreeNode?, sb: StringBuilder) {
        if (node == null) {
            sb.append("N,")
            return
        }
        sb.append(node.`val`).append(",")
        serializeHelper(node.left, sb)
        serializeHelper(node.right, sb)
    }

    fun deserialize(data: String): TreeNode? {
        val queue = ArrayDeque(data.split(","))
        return deserializeHelper(queue)
    }

    private fun deserializeHelper(queue: ArrayDeque<String>): TreeNode? {
        val `val` = queue.removeFirst()
        if (`val` == "N") return null
        val node = TreeNode(`val`.toInt())
        node.left = deserializeHelper(queue)
        node.right = deserializeHelper(queue)
        return node
    }
}',
    '## Solution: Pre-order Traversal

Time Complexity: O(n) for both operations
Space Complexity: O(n)

Use pre-order DFS with null markers.',
    'HARD',
    'tree,depth-first-search,breadth-first-search,design,string,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3,null,null,4,5]', '[1,2,3,null,null,4,5]', FALSE),
    (LAST_INSERT_ID(), '[]', '[]', FALSE);

-- Problem 10: Kth Smallest Element in BST (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'TREES',
    'Kth Smallest Element in a BST',
    '# Kth Smallest Element in a BST

Given root of a BST and integer k, return the kth smallest value (1-indexed).

**Example:**
```
Input: root = [3,1,4,null,2], k = 1
Output: 1
```',
    'Hint 1: In-order traversal of BST yields sorted values.
---
Hint 2: Keep counter and return when counter reaches k.
---
Hint 3: Iterative with stack or recursive approach.',
    'class Solution {
    private int count = 0;
    private int result = 0;

    public int kthSmallest(TreeNode root, int k) {
        inorder(root, k);
        return result;
    }

    private void inorder(TreeNode node, int k) {
        if (node == null) return;
        inorder(node.left, k);
        count++;
        if (count == k) {
            result = node.val;
            return;
        }
        inorder(node.right, k);
    }
}',
    'class Solution {
    private var count = 0
    private var result = 0

    fun kthSmallest(root: TreeNode?, k: Int): Int {
        inorder(root, k)
        return result
    }

    private fun inorder(node: TreeNode?, k: Int) {
        if (node == null) return
        inorder(node.left, k)
        count++
        if (count == k) {
            result = node.`val`
            return
        }
        inorder(node.right, k)
    }
}',
    '## Solution: In-order Traversal

Time Complexity: O(n)
Space Complexity: O(h)

In-order traversal gives sorted order in BST.',
    'MEDIUM',
    'tree,depth-first-search,binary-search-tree,binary-tree'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[3,1,4,null,2],1', '1', FALSE),
    (LAST_INSERT_ID(), '[5,3,6,2,4,null,null,1],3', '3', FALSE);

-- Additional 15 tree problems (without full solutions)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'LEETCODE', 'TREES', 'Minimum Depth of Binary Tree', '# Minimum Depth of Binary Tree

Find the minimum depth (shortest path from root to any leaf).

**Example:**
```
Input: root = [3,9,20,null,null,15,7]
Output: 2
```', 'Hint 1: Use BFS to find first leaf node.
---
Hint 2: Alternatively, recursion with min of children.
---
Hint 3: Be careful with nodes having only one child.', 'EASY', 'tree,depth-first-search,breadth-first-search,binary-tree'),

('ALGO', 'AMAZON', 'TREES', 'Subtree of Another Tree', '# Subtree of Another Tree

Check if subRoot is a subtree of root.

**Example:**
```
Input: root = [3,4,5,1,2], subRoot = [4,1,2]
Output: true
```', 'Hint 1: For each node in root, check if tree matches subRoot.
---
Hint 2: Use isSameTree helper function.
---
Hint 3: Recursively check all nodes.', 'EASY', 'tree,depth-first-search,string-matching,binary-tree'),

('ALGO', 'GOOGLE', 'TREES', 'Path Sum', '# Path Sum

Determine if tree has root-to-leaf path summing to targetSum.

**Example:**
```
Input: root = [5,4,8,11,null,13,4,7,2,null,null,null,1], targetSum = 22
Output: true
```', 'Hint 1: DFS with running sum.
---
Hint 2: Check if leaf node and sum equals target.
---
Hint 3: Subtract node value from target as you go.', 'EASY', 'tree,depth-first-search,breadth-first-search,binary-tree'),

('ALGO', 'META', 'TREES', 'Balanced Binary Tree', '# Balanced Binary Tree

Determine if binary tree is height-balanced (left and right subtree heights differ by at most 1).

**Example:**
```
Input: root = [3,9,20,null,null,15,7]
Output: true
```', 'Hint 1: Calculate height of each subtree.
---
Hint 2: Check height difference at each node.
---
Hint 3: Return -1 to indicate unbalanced subtree.', 'EASY', 'tree,depth-first-search,binary-tree'),

('ALGO', 'LEETCODE', 'TREES', 'Diameter of Binary Tree', '# Diameter of Binary Tree

Find the length of the diameter (longest path between any two nodes).

**Example:**
```
Input: root = [1,2,3,4,5]
Output: 3
```', 'Hint 1: Diameter may not pass through root.
---
Hint 2: At each node, diameter = leftHeight + rightHeight.
---
Hint 3: Track maximum diameter while computing heights.', 'EASY', 'tree,depth-first-search,binary-tree'),

('ALGO', 'AMAZON', 'TREES', 'Binary Tree Right Side View', '# Binary Tree Right Side View

Return values of nodes visible from right side (rightmost node at each level).

**Example:**
```
Input: root = [1,2,3,null,5,null,4]
Output: [1,3,4]
```', 'Hint 1: Level order traversal, take last node of each level.
---
Hint 2: Alternative: DFS with level tracking.
---
Hint 3: Process right child before left in DFS.', 'MEDIUM', 'tree,depth-first-search,breadth-first-search,binary-tree'),

('ALGO', 'GOOGLE', 'TREES', 'Count Good Nodes in Binary Tree', '# Count Good Nodes in Binary Tree

Count nodes where no node in path from root has greater value.

**Example:**
```
Input: root = [3,1,4,3,null,1,5]
Output: 4
```', 'Hint 1: DFS tracking maximum value seen in path.
---
Hint 2: Node is good if value >= max in path.
---
Hint 3: Update max as you traverse down.', 'MEDIUM', 'tree,depth-first-search,breadth-first-search,binary-tree'),

('ALGO', 'META', 'TREES', 'Construct Binary Tree from Preorder and Inorder', '# Construct Binary Tree from Preorder and Inorder Traversal

Build tree from preorder and inorder arrays.

**Example:**
```
Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
Output: [3,9,20,null,null,15,7]
```', 'Hint 1: First element of preorder is root.
---
Hint 2: Find root in inorder to split left/right subtrees.
---
Hint 3: Recursively build subtrees.', 'MEDIUM', 'tree,array,hash-table,divide-and-conquer,binary-tree'),

('ALGO', 'LEETCODE', 'TREES', 'Flatten Binary Tree to Linked List', '# Flatten Binary Tree to Linked List

Flatten tree to linked list in-place using preorder traversal.

**Example:**
```
Input: root = [1,2,5,3,4,null,6]
Output: [1,null,2,null,3,null,4,null,5,null,6]
```', 'Hint 1: Process right subtree first (reverse preorder).
---
Hint 2: Keep track of previous node.
---
Hint 3: Set right to prev, left to null.', 'MEDIUM', 'tree,depth-first-search,linked-list,stack,binary-tree'),

('ALGO', 'AMAZON', 'TREES', 'Lowest Common Ancestor of Binary Tree', '# Lowest Common Ancestor of Binary Tree

Find LCA of two nodes in a binary tree (not BST).

**Example:**
```
Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
Output: 3
```', 'Hint 1: If node is p or q, return it.
---
Hint 2: Recursively search left and right.
---
Hint 3: If both return non-null, current node is LCA.', 'MEDIUM', 'tree,depth-first-search,binary-tree'),

('ALGO', 'GOOGLE', 'TREES', 'Binary Tree Maximum Path Sum', '# Binary Tree Maximum Path Sum

Find maximum path sum (path can start and end at any node).

**Example:**
```
Input: root = [1,2,3]
Output: 6
```', 'Hint 1: At each node, calculate max gain from left and right.
---
Hint 2: Update global max with current path sum.
---
Hint 3: Return max gain through current node.', 'HARD', 'tree,depth-first-search,dynamic-programming,binary-tree'),

('ALGO', 'META', 'TREES', 'Sum Root to Leaf Numbers', '# Sum Root to Leaf Numbers

Sum all numbers formed by root-to-leaf paths.

**Example:**
```
Input: root = [1,2,3]
Output: 25 (12 + 13)
```', 'Hint 1: DFS with current number as parameter.
---
Hint 2: Current number = parent * 10 + node.val.
---
Hint 3: Add to sum when reaching leaf.', 'MEDIUM', 'tree,depth-first-search,binary-tree'),

('ALGO', 'LEETCODE', 'TREES', 'Populating Next Right Pointers', '# Populating Next Right Pointers in Each Node

Populate next pointer to point to next right node.

**Example:**
```
Input: root = [1,2,3,4,5,6,7]
Output: [1,#,2,3,#,4,5,6,7,#]
```', 'Hint 1: Level order traversal.
---
Hint 2: Connect nodes within same level.
---
Hint 3: Use existing next pointers for O(1) space.', 'MEDIUM', 'tree,depth-first-search,breadth-first-search,linked-list,binary-tree'),

('ALGO', 'AMAZON', 'TREES', 'Binary Tree Vertical Order Traversal', '# Binary Tree Vertical Order Traversal

Return vertical order traversal (nodes at same column, top to bottom).

**Example:**
```
Input: root = [3,9,20,null,null,15,7]
Output: [[9],[3,15],[20],[7]]
```', 'Hint 1: BFS with column tracking.
---
Hint 2: Use HashMap to group nodes by column.
---
Hint 3: Left child: col-1, right child: col+1.', 'MEDIUM', 'tree,depth-first-search,breadth-first-search,hash-table,binary-tree'),

('ALGO', 'GOOGLE', 'TREES', 'All Nodes Distance K in Binary Tree', '# All Nodes Distance K in Binary Tree

Find all nodes at distance K from target node.

**Example:**
```
Input: root = [3,5,1,6,2,0,8,null,null,7,4], target = 5, k = 2
Output: [7,4,1]
```', 'Hint 1: Build parent pointers or graph representation.
---
Hint 2: BFS from target node.
---
Hint 3: Track visited nodes to avoid cycles.', 'MEDIUM', 'tree,depth-first-search,breadth-first-search,binary-tree');
