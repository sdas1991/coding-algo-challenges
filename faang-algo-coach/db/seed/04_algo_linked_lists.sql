-- Linked Lists Arena - 25 Problems (10 with full solutions)

USE faang;

-- Problem 1: Reverse Linked List (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'LINKED_LISTS',
    'Reverse Linked List',
    '# Reverse Linked List

Given the head of a singly linked list, reverse the list, and return the reversed list.

**Example:**
```
Input: head = [1,2,3,4,5]
Output: [5,4,3,2,1]
```',
    'Hint 1: Use three pointers: prev, curr, next.
---
Hint 2: Iterate through the list, reversing pointers one at a time.
---
Hint 3: Alternative: Recursive solution exists.',
    'class Solution {
    public ListNode reverseList(ListNode head) {
        ListNode prev = null;
        ListNode curr = head;
        while (curr != null) {
            ListNode next = curr.next;
            curr.next = prev;
            prev = curr;
            curr = next;
        }
        return prev;
    }
}',
    'class Solution {
    fun reverseList(head: ListNode?): ListNode? {
        var prev: ListNode? = null
        var curr = head
        while (curr != null) {
            val next = curr.next
            curr.next = prev
            prev = curr
            curr = next
        }
        return prev
    }
}',
    '## Solution: Iterative Approach

Time Complexity: O(n)
Space Complexity: O(1)

Use three pointers to reverse the links iteratively.',
    'EASY',
    'linked-list,recursion'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3,4,5]', '[5,4,3,2,1]', FALSE),
    (LAST_INSERT_ID(), '[1,2]', '[2,1]', FALSE),
    (LAST_INSERT_ID(), '[]', '[]', FALSE);

-- Problem 2: Merge Two Sorted Lists (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'LINKED_LISTS',
    'Merge Two Sorted Lists',
    '# Merge Two Sorted Lists

Merge two sorted linked lists and return it as a sorted list.

**Example:**
```
Input: list1 = [1,2,4], list2 = [1,3,4]
Output: [1,1,2,3,4,4]
```',
    'Hint 1: Use a dummy head node to simplify edge cases.
---
Hint 2: Compare values and link the smaller node.
---
Hint 3: Don''t forget to handle remaining nodes.',
    'class Solution {
    public ListNode mergeTwoLists(ListNode list1, ListNode list2) {
        ListNode dummy = new ListNode(0);
        ListNode curr = dummy;
        while (list1 != null && list2 != null) {
            if (list1.val <= list2.val) {
                curr.next = list1;
                list1 = list1.next;
            } else {
                curr.next = list2;
                list2 = list2.next;
            }
            curr = curr.next;
        }
        curr.next = (list1 != null) ? list1 : list2;
        return dummy.next;
    }
}',
    'class Solution {
    fun mergeTwoLists(list1: ListNode?, list2: ListNode?): ListNode? {
        val dummy = ListNode(0)
        var curr = dummy
        var l1 = list1
        var l2 = list2
        while (l1 != null && l2 != null) {
            if (l1.`val` <= l2.`val`) {
                curr.next = l1
                l1 = l1.next
            } else {
                curr.next = l2
                l2 = l2.next
            }
            curr = curr.next!!
        }
        curr.next = l1 ?: l2
        return dummy.next
    }
}',
    '## Solution: Dummy Head Approach

Time Complexity: O(n + m)
Space Complexity: O(1)

Use a dummy node to simplify merging logic.',
    'EASY',
    'linked-list,recursion'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,4],[1,3,4]', '[1,1,2,3,4,4]', FALSE),
    (LAST_INSERT_ID(), '[],[]', '[]', FALSE),
    (LAST_INSERT_ID(), '[],[0]', '[0]', FALSE);

-- Problem 3: Linked List Cycle (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'LINKED_LISTS',
    'Linked List Cycle',
    '# Linked List Cycle

Given head of a linked list, determine if the linked list has a cycle in it.

**Example:**
```
Input: head = [3,2,0,-4], pos = 1
Output: true
Explanation: There is a cycle, tail connects to node index 1
```',
    'Hint 1: Floyd''s Cycle Detection Algorithm (Tortoise and Hare).
---
Hint 2: Use two pointers: slow (moves 1 step) and fast (moves 2 steps).
---
Hint 3: If they meet, there''s a cycle.',
    'class Solution {
    public boolean hasCycle(ListNode head) {
        if (head == null) return false;
        ListNode slow = head;
        ListNode fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
            if (slow == fast) {
                return true;
            }
        }
        return false;
    }
}',
    'class Solution {
    fun hasCycle(head: ListNode?): Boolean {
        if (head == null) return false
        var slow = head
        var fast = head
        while (fast?.next != null) {
            slow = slow?.next
            fast = fast.next?.next
            if (slow == fast) {
                return true
            }
        }
        return false
    }
}',
    '## Solution: Floyd''s Cycle Detection

Time Complexity: O(n)
Space Complexity: O(1)

Two pointers moving at different speeds will meet if there''s a cycle.',
    'EASY',
    'linked-list,two-pointers,hash-table'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[3,2,0,-4],1', 'true', FALSE),
    (LAST_INSERT_ID(), '[1,2],-1', 'false', FALSE);

-- Problem 4: Remove Nth Node From End (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'LINKED_LISTS',
    'Remove Nth Node From End of List',
    '# Remove Nth Node From End of List

Given the head of a linked list, remove the nth node from the end of the list.

**Example:**
```
Input: head = [1,2,3,4,5], n = 2
Output: [1,2,3,5]
```',
    'Hint 1: Use two pointers with n gap between them.
---
Hint 2: Move both pointers until first reaches end.
---
Hint 3: Use a dummy node to handle edge cases.',
    'class Solution {
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode first = dummy;
        ListNode second = dummy;
        for (int i = 0; i <= n; i++) {
            first = first.next;
        }
        while (first != null) {
            first = first.next;
            second = second.next;
        }
        second.next = second.next.next;
        return dummy.next;
    }
}',
    'class Solution {
    fun removeNthFromEnd(head: ListNode?, n: Int): ListNode? {
        val dummy = ListNode(0)
        dummy.next = head
        var first: ListNode? = dummy
        var second: ListNode? = dummy
        for (i in 0..n) {
            first = first?.next
        }
        while (first != null) {
            first = first.next
            second = second?.next
        }
        second?.next = second?.next?.next
        return dummy.next
    }
}',
    '## Solution: Two Pointers

Time Complexity: O(n)
Space Complexity: O(1)

Maintain n gap between two pointers for one-pass solution.',
    'MEDIUM',
    'linked-list,two-pointers'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3,4,5],2', '[1,2,3,5]', FALSE),
    (LAST_INSERT_ID(), '[1],1', '[]', FALSE);

-- Problem 5: Palindrome Linked List (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'LINKED_LISTS',
    'Palindrome Linked List',
    '# Palindrome Linked List

Given the head of a singly linked list, return true if it is a palindrome.

**Example:**
```
Input: head = [1,2,2,1]
Output: true
```',
    'Hint 1: Find the middle of the list using slow/fast pointers.
---
Hint 2: Reverse the second half.
---
Hint 3: Compare first half with reversed second half.',
    'class Solution {
    public boolean isPalindrome(ListNode head) {
        if (head == null || head.next == null) return true;
        ListNode slow = head, fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }
        ListNode secondHalf = reverse(slow);
        ListNode firstHalf = head;
        while (secondHalf != null) {
            if (firstHalf.val != secondHalf.val) return false;
            firstHalf = firstHalf.next;
            secondHalf = secondHalf.next;
        }
        return true;
    }

    private ListNode reverse(ListNode head) {
        ListNode prev = null;
        while (head != null) {
            ListNode next = head.next;
            head.next = prev;
            prev = head;
            head = next;
        }
        return prev;
    }
}',
    'class Solution {
    fun isPalindrome(head: ListNode?): Boolean {
        if (head?.next == null) return true
        var slow = head
        var fast = head
        while (fast?.next != null) {
            slow = slow?.next
            fast = fast.next?.next
        }
        var secondHalf = reverse(slow)
        var firstHalf = head
        while (secondHalf != null) {
            if (firstHalf?.`val` != secondHalf.`val`) return false
            firstHalf = firstHalf.next
            secondHalf = secondHalf.next
        }
        return true
    }

    private fun reverse(head: ListNode?): ListNode? {
        var prev: ListNode? = null
        var curr = head
        while (curr != null) {
            val next = curr.next
            curr.next = prev
            prev = curr
            curr = next
        }
        return prev
    }
}',
    '## Solution: Reverse Second Half

Time Complexity: O(n)
Space Complexity: O(1)

Find middle, reverse second half, then compare.',
    'EASY',
    'linked-list,two-pointers,stack,recursion'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,2,1]', 'true', FALSE),
    (LAST_INSERT_ID(), '[1,2]', 'false', FALSE);

-- Problem 6: Add Two Numbers (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'LINKED_LISTS',
    'Add Two Numbers',
    '# Add Two Numbers

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order. Add the two numbers and return the sum as a linked list.

**Example:**
```
Input: l1 = [2,4,3], l2 = [5,6,4]
Output: [7,0,8]
Explanation: 342 + 465 = 807
```',
    'Hint 1: Handle digit-by-digit addition with carry.
---
Hint 2: Use a dummy head for the result list.
---
Hint 3: Don''t forget to add final carry if it exists.',
    'class Solution {
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode dummy = new ListNode(0);
        ListNode curr = dummy;
        int carry = 0;
        while (l1 != null || l2 != null || carry != 0) {
            int sum = carry;
            if (l1 != null) {
                sum += l1.val;
                l1 = l1.next;
            }
            if (l2 != null) {
                sum += l2.val;
                l2 = l2.next;
            }
            carry = sum / 10;
            curr.next = new ListNode(sum % 10);
            curr = curr.next;
        }
        return dummy.next;
    }
}',
    'class Solution {
    fun addTwoNumbers(l1: ListNode?, l2: ListNode?): ListNode? {
        val dummy = ListNode(0)
        var curr = dummy
        var carry = 0
        var p1 = l1
        var p2 = l2
        while (p1 != null || p2 != null || carry != 0) {
            var sum = carry
            if (p1 != null) {
                sum += p1.`val`
                p1 = p1.next
            }
            if (p2 != null) {
                sum += p2.`val`
                p2 = p2.next
            }
            carry = sum / 10
            curr.next = ListNode(sum % 10)
            curr = curr.next!!
        }
        return dummy.next
    }
}',
    '## Solution: Elementary Math

Time Complexity: O(max(m, n))
Space Complexity: O(max(m, n))

Simulate addition with carry, digit by digit.',
    'MEDIUM',
    'linked-list,math,recursion'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[2,4,3],[5,6,4]', '[7,0,8]', FALSE),
    (LAST_INSERT_ID(), '[0],[0]', '[0]', FALSE),
    (LAST_INSERT_ID(), '[9,9,9,9,9,9,9],[9,9,9,9]', '[8,9,9,9,0,0,0,1]', FALSE);

-- Problem 7: Copy List with Random Pointer (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'LINKED_LISTS',
    'Copy List with Random Pointer',
    '# Copy List with Random Pointer

A linked list is given such that each node has an additional random pointer. Construct a deep copy of the list.

**Example:**
```
Input: head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
Output: [[7,null],[13,0],[11,4],[10,2],[1,0]]
```',
    'Hint 1: Use a HashMap to map old nodes to new nodes.
---
Hint 2: First pass: create all nodes and map them.
---
Hint 3: Second pass: set next and random pointers.',
    'class Solution {
    public Node copyRandomList(Node head) {
        if (head == null) return null;
        Map<Node, Node> map = new HashMap<>();
        Node curr = head;
        while (curr != null) {
            map.put(curr, new Node(curr.val));
            curr = curr.next;
        }
        curr = head;
        while (curr != null) {
            map.get(curr).next = map.get(curr.next);
            map.get(curr).random = map.get(curr.random);
            curr = curr.next;
        }
        return map.get(head);
    }
}',
    'class Solution {
    fun copyRandomList(head: Node?): Node? {
        if (head == null) return null
        val map = mutableMapOf<Node, Node>()
        var curr = head
        while (curr != null) {
            map[curr] = Node(curr.`val`)
            curr = curr.next
        }
        curr = head
        while (curr != null) {
            map[curr]?.next = map[curr.next]
            map[curr]?.random = map[curr.random]
            curr = curr.next
        }
        return map[head]
    }
}',
    '## Solution: HashMap

Time Complexity: O(n)
Space Complexity: O(n)

Use HashMap to track old→new node mapping.',
    'MEDIUM',
    'linked-list,hash-table'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[7,null],[13,0],[11,4],[10,2],[1,0]]', '[[7,null],[13,0],[11,4],[10,2],[1,0]]', FALSE),
    (LAST_INSERT_ID(), '[[1,1],[2,1]]', '[[1,1],[2,1]]', FALSE);

-- Problem 8: LRU Cache (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'LINKED_LISTS',
    'LRU Cache',
    '# LRU Cache

Design a data structure that follows the constraints of a Least Recently Used (LRU) cache. Implement get and put in O(1).

**Example:**
```
Input: ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
Output: [null, null, null, 1, null, -1, null, -1, 3, 4]
```',
    'Hint 1: Use HashMap + Doubly Linked List.
---
Hint 2: HashMap for O(1) lookup, DLL for O(1) removal/insertion.
---
Hint 3: Move to head on access, remove from tail when at capacity.',
    'class LRUCache {
    class Node {
        int key, value;
        Node prev, next;
        Node(int k, int v) { key = k; value = v; }
    }

    private Map<Integer, Node> cache = new HashMap<>();
    private Node head = new Node(0, 0);
    private Node tail = new Node(0, 0);
    private int capacity;

    public LRUCache(int capacity) {
        this.capacity = capacity;
        head.next = tail;
        tail.prev = head;
    }

    public int get(int key) {
        if (!cache.containsKey(key)) return -1;
        Node node = cache.get(key);
        remove(node);
        insert(node);
        return node.value;
    }

    public void put(int key, int value) {
        if (cache.containsKey(key)) {
            remove(cache.get(key));
        }
        if (cache.size() == capacity) {
            remove(tail.prev);
        }
        insert(new Node(key, value));
    }

    private void remove(Node node) {
        cache.remove(node.key);
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }

    private void insert(Node node) {
        cache.put(node.key, node);
        node.next = head.next;
        node.next.prev = node;
        head.next = node;
        node.prev = head;
    }
}',
    'class LRUCache(private val capacity: Int) {
    private class Node(val key: Int, var value: Int) {
        var prev: Node? = null
        var next: Node? = null
    }

    private val cache = mutableMapOf<Int, Node>()
    private val head = Node(0, 0)
    private val tail = Node(0, 0)

    init {
        head.next = tail
        tail.prev = head
    }

    fun get(key: Int): Int {
        if (!cache.containsKey(key)) return -1
        val node = cache[key]!!
        remove(node)
        insert(node)
        return node.value
    }

    fun put(key: Int, value: Int) {
        if (cache.containsKey(key)) {
            remove(cache[key]!!)
        }
        if (cache.size == capacity) {
            remove(tail.prev!!)
        }
        insert(Node(key, value))
    }

    private fun remove(node: Node) {
        cache.remove(node.key)
        node.prev?.next = node.next
        node.next?.prev = node.prev
    }

    private fun insert(node: Node) {
        cache[node.key] = node
        node.next = head.next
        node.next?.prev = node
        head.next = node
        node.prev = head
    }
}',
    '## Solution: HashMap + DLL

Time Complexity: O(1) for both operations
Space Complexity: O(capacity)

Combine HashMap and doubly linked list for efficient LRU.',
    'MEDIUM',
    'linked-list,hash-table,design'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '2,[put,1,1],[put,2,2],[get,1]', '1', FALSE),
    (LAST_INSERT_ID(), '2,[put,1,1],[put,2,2],[get,1],[put,3,3],[get,2]', '-1', FALSE);

-- Problem 9: Intersection of Two Linked Lists (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'LINKED_LISTS',
    'Intersection of Two Linked Lists',
    '# Intersection of Two Linked Lists

Given the heads of two singly linked-lists, return the node at which they intersect, or null if they don''t.

**Example:**
```
Input: intersectVal = 8, listA = [4,1,8,4,5], listB = [5,6,1,8,4,5]
Output: 8
```',
    'Hint 1: Two pointers switching to other list when reaching end.
---
Hint 2: They will meet at intersection or both be null.
---
Hint 3: Alternative: Use HashSet to track visited nodes.',
    'class Solution {
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        if (headA == null || headB == null) return null;
        ListNode a = headA;
        ListNode b = headB;
        while (a != b) {
            a = (a == null) ? headB : a.next;
            b = (b == null) ? headA : b.next;
        }
        return a;
    }
}',
    'class Solution {
    fun getIntersectionNode(headA: ListNode?, headB: ListNode?): ListNode? {
        if (headA == null || headB == null) return null
        var a = headA
        var b = headB
        while (a != b) {
            a = if (a == null) headB else a.next
            b = if (b == null) headA else b.next
        }
        return a
    }
}',
    '## Solution: Two Pointers

Time Complexity: O(m + n)
Space Complexity: O(1)

Smart pointer switching eliminates length difference.',
    'EASY',
    'linked-list,two-pointers,hash-table'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '8,[4,1,8,4,5],[5,6,1,8,4,5]', '8', FALSE),
    (LAST_INSERT_ID(), '0,[2,6,4],[1,5]', 'null', FALSE);

-- Problem 10: Merge K Sorted Lists (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'LINKED_LISTS',
    'Merge K Sorted Lists',
    '# Merge K Sorted Lists

You are given an array of k linked-lists, each sorted in ascending order. Merge all the linked-lists into one sorted linked-list.

**Example:**
```
Input: lists = [[1,4,5],[1,3,4],[2,6]]
Output: [1,1,2,3,4,4,5,6]
```',
    'Hint 1: Use a Min Heap (PriorityQueue) to track smallest elements.
---
Hint 2: Add head of each list to heap initially.
---
Hint 3: Always extract min and add its next node to heap.',
    'class Solution {
    public ListNode mergeKLists(ListNode[] lists) {
        if (lists == null || lists.length == 0) return null;
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
        if (lists.isEmpty()) return null
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

Time Complexity: O(N log k), N = total nodes, k = number of lists
Space Complexity: O(k)

Use heap to efficiently find minimum among k lists.',
    'HARD',
    'linked-list,heap,divide-and-conquer,merge-sort'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[[1,4,5],[1,3,4],[2,6]]', '[1,1,2,3,4,4,5,6]', FALSE),
    (LAST_INSERT_ID(), '[]', '[]', FALSE),
    (LAST_INSERT_ID(), '[[]]', '[]', FALSE);

-- Additional 15 linked list problems (without full solutions)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'LEETCODE', 'LINKED_LISTS', 'Middle of the Linked List', '# Middle of the Linked List

Given a non-empty, singly linked list with head, return a middle node. If there are two middle nodes, return the second.

**Example:**
```
Input: [1,2,3,4,5]
Output: [3,4,5]
```', 'Hint 1: Use slow and fast pointers.
---
Hint 2: Fast moves twice as fast as slow.
---
Hint 3: When fast reaches end, slow is at middle.', 'EASY', 'linked-list,two-pointers'),

('ALGO', 'AMAZON', 'LINKED_LISTS', 'Delete Node in a Linked List', '# Delete Node in a Linked List

Write a function to delete a node (except tail) in a singly linked list, given only access to that node.

**Example:**
```
Input: head = [4,5,1,9], node = 5
Output: [4,1,9]
```', 'Hint 1: You don''t have access to previous node.
---
Hint 2: Copy next node''s value to current node.
---
Hint 3: Delete the next node instead.', 'EASY', 'linked-list'),

('ALGO', 'GOOGLE', 'LINKED_LISTS', 'Odd Even Linked List', '# Odd Even Linked List

Group all odd nodes together followed by even nodes. Maintain relative order within groups.

**Example:**
```
Input: head = [1,2,3,4,5]
Output: [1,3,5,2,4]
```', 'Hint 1: Use two pointers for odd and even lists.
---
Hint 2: Build two separate lists then connect.
---
Hint 3: Be careful with last node connections.', 'MEDIUM', 'linked-list'),

('ALGO', 'META', 'LINKED_LISTS', 'Reorder List', '# Reorder List

Reorder list L0→L1→...→Ln-1→Ln to L0→Ln→L1→Ln-1→L2→Ln-2...

**Example:**
```
Input: head = [1,2,3,4]
Output: [1,4,2,3]
```', 'Hint 1: Find middle, reverse second half, merge alternately.
---
Hint 2: Break into three steps: find middle, reverse, merge.
---
Hint 3: Use slow/fast pointers to find middle.', 'MEDIUM', 'linked-list,two-pointers,recursion'),

('ALGO', 'LEETCODE', 'LINKED_LISTS', 'Remove Duplicates from Sorted List', '# Remove Duplicates from Sorted List

Given head of a sorted linked list, delete all duplicates such that each element appears only once.

**Example:**
```
Input: head = [1,1,2]
Output: [1,2]
```', 'Hint 1: Compare current with next node.
---
Hint 2: Skip next if values are equal.
---
Hint 3: Single pass solution.', 'EASY', 'linked-list'),

('ALGO', 'AMAZON', 'LINKED_LISTS', 'Remove Duplicates from Sorted List II', '# Remove Duplicates from Sorted List II

Delete all nodes that have duplicate numbers, leaving only distinct numbers.

**Example:**
```
Input: head = [1,2,3,3,4,4,5]
Output: [1,2,5]
```', 'Hint 1: Use dummy node for edge cases.
---
Hint 2: Skip all nodes with duplicate values.
---
Hint 3: Compare current.next with current.next.next.', 'MEDIUM', 'linked-list,two-pointers'),

('ALGO', 'GOOGLE', 'LINKED_LISTS', 'Rotate List', '# Rotate List

Given head of a linked list, rotate the list to the right by k places.

**Example:**
```
Input: head = [1,2,3,4,5], k = 2
Output: [4,5,1,2,3]
```', 'Hint 1: Connect tail to head to form a cycle.
---
Hint 2: Find new tail at (length - k % length - 1).
---
Hint 3: Break the cycle at new tail.', 'MEDIUM', 'linked-list,two-pointers'),

('ALGO', 'META', 'LINKED_LISTS', 'Partition List', '# Partition List

Partition list such that all nodes < x come before nodes >= x. Preserve original relative order.

**Example:**
```
Input: head = [1,4,3,2,5,2], x = 3
Output: [1,2,2,4,3,5]
```', 'Hint 1: Create two separate lists: before and after.
---
Hint 2: Traverse once, adding nodes to appropriate list.
---
Hint 3: Connect before list tail to after list head.', 'MEDIUM', 'linked-list,two-pointers'),

('ALGO', 'LEETCODE', 'LINKED_LISTS', 'Swap Nodes in Pairs', '# Swap Nodes in Pairs

Swap every two adjacent nodes and return its head. You must solve without modifying values.

**Example:**
```
Input: head = [1,2,3,4]
Output: [2,1,4,3]
```', 'Hint 1: Use dummy node to handle head swap.
---
Hint 2: Track prev, first, second, next nodes.
---
Hint 3: Carefully rearrange pointers.', 'MEDIUM', 'linked-list,recursion'),

('ALGO', 'AMAZON', 'LINKED_LISTS', 'Reverse Nodes in k-Group', '# Reverse Nodes in k-Group

Reverse nodes of a linked list k at a time. If nodes < k remain, leave them as is.

**Example:**
```
Input: head = [1,2,3,4,5], k = 2
Output: [2,1,4,3,5]
```', 'Hint 1: Check if k nodes remain before reversing.
---
Hint 2: Reverse k nodes, connect to previous group.
---
Hint 3: Recursion can simplify the solution.', 'HARD', 'linked-list,recursion'),

('ALGO', 'GOOGLE', 'LINKED_LISTS', 'Flatten a Multilevel Doubly Linked List', '# Flatten a Multilevel Doubly Linked List

Flatten a multilevel doubly linked list where nodes may have a child pointer.

**Example:**
```
Input: head = [1,2,3,4,5,6,null,null,null,7,8,9,10]
Output: [1,2,3,7,8,9,10,4,5,6]
```', 'Hint 1: DFS approach using stack or recursion.
---
Hint 2: Process child before next node.
---
Hint 3: Maintain prev pointer for doubly linked connections.', 'MEDIUM', 'linked-list,depth-first-search,doubly-linked-list'),

('ALGO', 'META', 'LINKED_LISTS', 'Add Two Numbers II', '# Add Two Numbers II

Add two numbers represented by linked lists where most significant digit comes first.

**Example:**
```
Input: l1 = [7,2,4,3], l2 = [5,6,4]
Output: [7,8,0,7]
```', 'Hint 1: Reverse both lists, add, then reverse result.
---
Hint 2: Alternative: Use stacks to process from end.
---
Hint 3: Handle final carry carefully.', 'MEDIUM', 'linked-list,math,stack'),

('ALGO', 'LEETCODE', 'LINKED_LISTS', 'Linked List Cycle II', '# Linked List Cycle II

Given head of a linked list, return the node where the cycle begins, or null if no cycle.

**Example:**
```
Input: head = [3,2,0,-4], pos = 1
Output: tail connects to node index 1
```', 'Hint 1: Use Floyd''s algorithm to detect cycle first.
---
Hint 2: After meeting, reset one pointer to head.
---
Hint 3: Move both one step at a time until they meet.', 'MEDIUM', 'linked-list,two-pointers,hash-table'),

('ALGO', 'AMAZON', 'LINKED_LISTS', 'Sort List', '# Sort List

Sort a linked list in O(n log n) time and O(1) space.

**Example:**
```
Input: head = [4,2,1,3]
Output: [1,2,3,4]
```', 'Hint 1: Merge sort works well for linked lists.
---
Hint 2: Find middle using slow/fast pointers.
---
Hint 3: Recursively sort halves then merge.', 'MEDIUM', 'linked-list,two-pointers,divide-and-conquer,sorting,merge-sort'),

('ALGO', 'GOOGLE', 'LINKED_LISTS', 'Reverse Linked List II', '# Reverse Linked List II

Reverse nodes from position left to right in a linked list.

**Example:**
```
Input: head = [1,2,3,4,5], left = 2, right = 4
Output: [1,4,3,2,5]
```', 'Hint 1: Find node before left position.
---
Hint 2: Reverse from left to right.
---
Hint 3: Reconnect reversed portion to rest of list.', 'MEDIUM', 'linked-list');
