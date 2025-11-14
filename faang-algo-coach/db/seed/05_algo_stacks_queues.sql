-- Stacks/Queues Arena - 25 Problems (10 with full solutions)

USE faang;

-- Problem 1: Valid Parentheses (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'STACKS_QUEUES',
    'Valid Parentheses',
    '# Valid Parentheses

Given a string containing just the characters ''('', '')'', ''{'', ''}'', ''['' and '']'', determine if the input string is valid.

**Example:**
```
Input: s = "()[]{}"
Output: true
```',
    'Hint 1: Use a stack to track opening brackets.
---
Hint 2: Push opening brackets, pop and match closing brackets.
---
Hint 3: String is valid if stack is empty at the end.',
    'class Solution {
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        Map<Character, Character> map = Map.of('')'', ''('', ''}'', ''{'', '']'', ''['');
        for (char c : s.toCharArray()) {
            if (map.containsKey(c)) {
                if (stack.isEmpty() || stack.pop() != map.get(c)) {
                    return false;
                }
            } else {
                stack.push(c);
            }
        }
        return stack.isEmpty();
    }
}',
    'class Solution {
    fun isValid(s: String): Boolean {
        val stack = ArrayDeque<Char>()
        val map = mapOf('')'' to ''('', ''}'' to ''{'', '']'' to ''['')
        for (c in s) {
            if (c in map) {
                if (stack.isEmpty() || stack.removeLast() != map[c]) {
                    return false
                }
            } else {
                stack.addLast(c)
            }
        }
        return stack.isEmpty()
    }
}',
    '## Solution: Stack

Time Complexity: O(n)
Space Complexity: O(n)

Use stack to match opening and closing brackets.',
    'EASY',
    'stack,string'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '()[]{}', 'true', FALSE),
    (LAST_INSERT_ID(), '(]', 'false', FALSE),
    (LAST_INSERT_ID(), '([)]', 'false', FALSE);

-- Problem 2: Min Stack (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'STACKS_QUEUES',
    'Min Stack',
    '# Min Stack

Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

**Example:**
```
Input: ["MinStack","push","push","push","getMin","pop","top","getMin"]
[[],[-2],[0],[-3],[],[],[],[]]
Output: [null,null,null,null,-3,null,0,-2]
```',
    'Hint 1: Use two stacks: one for values, one for minimums.
---
Hint 2: Min stack stores minimum at each level.
---
Hint 3: Alternative: Store pairs (value, current_min) in one stack.',
    'class MinStack {
    private Stack<Integer> stack;
    private Stack<Integer> minStack;

    public MinStack() {
        stack = new Stack<>();
        minStack = new Stack<>();
    }

    public void push(int val) {
        stack.push(val);
        if (minStack.isEmpty() || val <= minStack.peek()) {
            minStack.push(val);
        }
    }

    public void pop() {
        if (stack.pop().equals(minStack.peek())) {
            minStack.pop();
        }
    }

    public int top() {
        return stack.peek();
    }

    public int getMin() {
        return minStack.peek();
    }
}',
    'class MinStack() {
    private val stack = ArrayDeque<Int>()
    private val minStack = ArrayDeque<Int>()

    fun push(`val`: Int) {
        stack.addLast(`val`)
        if (minStack.isEmpty() || `val` <= minStack.last()) {
            minStack.addLast(`val`)
        }
    }

    fun pop() {
        if (stack.removeLast() == minStack.last()) {
            minStack.removeLast()
        }
    }

    fun top(): Int {
        return stack.last()
    }

    fun getMin(): Int {
        return minStack.last()
    }
}',
    '## Solution: Two Stacks

Time Complexity: O(1) for all operations
Space Complexity: O(n)

Maintain a parallel stack tracking minimums.',
    'MEDIUM',
    'stack,design'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'push(-2),push(0),push(-3),getMin()', '-3', FALSE),
    (LAST_INSERT_ID(), 'push(-2),push(0),push(-3),getMin(),pop(),top(),getMin()', '0,-2', FALSE);

-- Problem 3: Evaluate Reverse Polish Notation (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'STACKS_QUEUES',
    'Evaluate Reverse Polish Notation',
    '# Evaluate Reverse Polish Notation

Evaluate the value of an arithmetic expression in Reverse Polish Notation (postfix).

**Example:**
```
Input: tokens = ["2","1","+","3","*"]
Output: 9
Explanation: ((2 + 1) * 3) = 9
```',
    'Hint 1: Use a stack to store operands.
---
Hint 2: When operator found, pop two operands, compute, push result.
---
Hint 3: Final stack should have one element: the result.',
    'class Solution {
    public int evalRPN(String[] tokens) {
        Stack<Integer> stack = new Stack<>();
        for (String token : tokens) {
            if (token.equals("+") || token.equals("-") || token.equals("*") || token.equals("/")) {
                int b = stack.pop();
                int a = stack.pop();
                int result = switch (token) {
                    case "+" -> a + b;
                    case "-" -> a - b;
                    case "*" -> a * b;
                    case "/" -> a / b;
                    default -> 0;
                };
                stack.push(result);
            } else {
                stack.push(Integer.parseInt(token));
            }
        }
        return stack.pop();
    }
}',
    'class Solution {
    fun evalRPN(tokens: Array<String>): Int {
        val stack = ArrayDeque<Int>()
        for (token in tokens) {
            when (token) {
                "+", "-", "*", "/" -> {
                    val b = stack.removeLast()
                    val a = stack.removeLast()
                    val result = when (token) {
                        "+" -> a + b
                        "-" -> a - b
                        "*" -> a * b
                        "/" -> a / b
                        else -> 0
                    }
                    stack.addLast(result)
                }
                else -> stack.addLast(token.toInt())
            }
        }
        return stack.removeLast()
    }
}',
    '## Solution: Stack Evaluation

Time Complexity: O(n)
Space Complexity: O(n)

Stack-based evaluation of postfix notation.',
    'MEDIUM',
    'stack,array,math'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '["2","1","+","3","*"]', '9', FALSE),
    (LAST_INSERT_ID(), '["4","13","5","/","+"]', '6', FALSE);

-- Problem 4: Daily Temperatures (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'STACKS_QUEUES',
    'Daily Temperatures',
    '# Daily Temperatures

Given an array of daily temperatures, return array where answer[i] is the number of days until a warmer temperature. If no future day exists, answer[i] = 0.

**Example:**
```
Input: temperatures = [73,74,75,71,69,72,76,73]
Output: [1,1,4,2,1,1,0,0]
```',
    'Hint 1: Use a monotonic decreasing stack.
---
Hint 2: Stack stores indices of temperatures.
---
Hint 3: Pop indices when warmer temperature found.',
    'class Solution {
    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;
        int[] answer = new int[n];
        Stack<Integer> stack = new Stack<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && temperatures[i] > temperatures[stack.peek()]) {
                int idx = stack.pop();
                answer[idx] = i - idx;
            }
            stack.push(i);
        }
        return answer;
    }
}',
    'class Solution {
    fun dailyTemperatures(temperatures: IntArray): IntArray {
        val n = temperatures.size
        val answer = IntArray(n)
        val stack = ArrayDeque<Int>()
        for (i in temperatures.indices) {
            while (stack.isNotEmpty() && temperatures[i] > temperatures[stack.last()]) {
                val idx = stack.removeLast()
                answer[idx] = i - idx
            }
            stack.addLast(i)
        }
        return answer
    }
}',
    '## Solution: Monotonic Stack

Time Complexity: O(n)
Space Complexity: O(n)

Use monotonic stack to find next greater element efficiently.',
    'MEDIUM',
    'stack,array,monotonic-stack'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[73,74,75,71,69,72,76,73]', '[1,1,4,2,1,1,0,0]', FALSE),
    (LAST_INSERT_ID(), '[30,40,50,60]', '[1,1,1,0]', FALSE);

-- Problem 5: Largest Rectangle in Histogram (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'STACKS_QUEUES',
    'Largest Rectangle in Histogram',
    '# Largest Rectangle in Histogram

Given an array of integers heights representing the histogram''s bar heights, find the area of the largest rectangle in the histogram.

**Example:**
```
Input: heights = [2,1,5,6,2,3]
Output: 10
Explanation: Rectangle with height 5 and width 2
```',
    'Hint 1: Use a monotonic increasing stack.
---
Hint 2: Stack stores indices of bars.
---
Hint 3: Calculate area when a shorter bar is encountered.',
    'class Solution {
    public int largestRectangleArea(int[] heights) {
        Stack<Integer> stack = new Stack<>();
        int maxArea = 0;
        int n = heights.length;
        for (int i = 0; i <= n; i++) {
            int h = (i == n) ? 0 : heights[i];
            while (!stack.isEmpty() && h < heights[stack.peek()]) {
                int height = heights[stack.pop()];
                int width = stack.isEmpty() ? i : i - stack.peek() - 1;
                maxArea = Math.max(maxArea, height * width);
            }
            stack.push(i);
        }
        return maxArea;
    }
}',
    'class Solution {
    fun largestRectangleArea(heights: IntArray): Int {
        val stack = ArrayDeque<Int>()
        var maxArea = 0
        val n = heights.size
        for (i in 0..n) {
            val h = if (i == n) 0 else heights[i]
            while (stack.isNotEmpty() && h < heights[stack.last()]) {
                val height = heights[stack.removeLast()]
                val width = if (stack.isEmpty()) i else i - stack.last() - 1
                maxArea = maxOf(maxArea, height * width)
            }
            stack.addLast(i)
        }
        return maxArea
    }
}',
    '## Solution: Monotonic Stack

Time Complexity: O(n)
Space Complexity: O(n)

Stack maintains increasing heights, calculates areas on pop.',
    'HARD',
    'stack,array,monotonic-stack'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[2,1,5,6,2,3]', '10', FALSE),
    (LAST_INSERT_ID(), '[2,4]', '4', FALSE);

-- Problem 6: Implement Queue using Stacks (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'STACKS_QUEUES',
    'Implement Queue using Stacks',
    '# Implement Queue using Stacks

Implement a FIFO queue using only two stacks. Support push, pop, peek, and empty operations.

**Example:**
```
Input: ["MyQueue", "push", "push", "peek", "pop", "empty"]
[[], [1], [2], [], [], []]
Output: [null, null, null, 1, 1, false]
```',
    'Hint 1: Use two stacks: input and output.
---
Hint 2: Push to input stack.
---
Hint 3: For pop/peek, transfer from input to output if output empty.',
    'class MyQueue {
    private Stack<Integer> input;
    private Stack<Integer> output;

    public MyQueue() {
        input = new Stack<>();
        output = new Stack<>();
    }

    public void push(int x) {
        input.push(x);
    }

    public int pop() {
        peek();
        return output.pop();
    }

    public int peek() {
        if (output.isEmpty()) {
            while (!input.isEmpty()) {
                output.push(input.pop());
            }
        }
        return output.peek();
    }

    public boolean empty() {
        return input.isEmpty() && output.isEmpty();
    }
}',
    'class MyQueue() {
    private val input = ArrayDeque<Int>()
    private val output = ArrayDeque<Int>()

    fun push(x: Int) {
        input.addLast(x)
    }

    fun pop(): Int {
        peek()
        return output.removeLast()
    }

    fun peek(): Int {
        if (output.isEmpty()) {
            while (input.isNotEmpty()) {
                output.addLast(input.removeLast())
            }
        }
        return output.last()
    }

    fun empty(): Boolean {
        return input.isEmpty() && output.isEmpty()
    }
}',
    '## Solution: Two Stacks

Time Complexity: O(1) amortized for all operations
Space Complexity: O(n)

Use two stacks to reverse order for queue behavior.',
    'EASY',
    'stack,queue,design'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'push(1),push(2),peek(),pop(),empty()', '1,1,false', FALSE);

-- Problem 7: Sliding Window Maximum (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'STACKS_QUEUES',
    'Sliding Window Maximum',
    '# Sliding Window Maximum

Given an array and sliding window size k, find the maximum for each window position.

**Example:**
```
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]
```',
    'Hint 1: Use a deque to maintain indices of useful elements.
---
Hint 2: Keep deque decreasing: remove smaller elements from back.
---
Hint 3: Remove elements outside window from front.',
    'class Solution {
    public int[] maxSlidingWindow(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[n - k + 1];
        Deque<Integer> deque = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            while (!deque.isEmpty() && deque.peek() < i - k + 1) {
                deque.poll();
            }
            while (!deque.isEmpty() && nums[deque.peekLast()] < nums[i]) {
                deque.pollLast();
            }
            deque.offer(i);
            if (i >= k - 1) {
                result[i - k + 1] = nums[deque.peek()];
            }
        }
        return result;
    }
}',
    'class Solution {
    fun maxSlidingWindow(nums: IntArray, k: Int): IntArray {
        val n = nums.size
        val result = IntArray(n - k + 1)
        val deque = ArrayDeque<Int>()
        for (i in nums.indices) {
            while (deque.isNotEmpty() && deque.first() < i - k + 1) {
                deque.removeFirst()
            }
            while (deque.isNotEmpty() && nums[deque.last()] < nums[i]) {
                deque.removeLast()
            }
            deque.addLast(i)
            if (i >= k - 1) {
                result[i - k + 1] = nums[deque.first()]
            }
        }
        return result
    }
}',
    '## Solution: Monotonic Deque

Time Complexity: O(n)
Space Complexity: O(k)

Deque maintains indices of potential maximums in decreasing order.',
    'HARD',
    'queue,array,sliding-window,heap,monotonic-queue'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,3,-1,-3,5,3,6,7],3', '[3,3,5,5,6,7]', FALSE),
    (LAST_INSERT_ID(), '[1],1', '[1]', FALSE);

-- Problem 8: Implement Stack using Queues (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'STACKS_QUEUES',
    'Implement Stack using Queues',
    '# Implement Stack using Queues

Implement a LIFO stack using only queues. Support push, pop, top, and empty operations.

**Example:**
```
Input: ["MyStack", "push", "push", "top", "pop", "empty"]
[[], [1], [2], [], [], []]
Output: [null, null, null, 2, 2, false]
```',
    'Hint 1: Use one queue, rotate on push.
---
Hint 2: After adding element, rotate queue to move it to front.
---
Hint 3: Rotate n-1 times where n is queue size.',
    'class MyStack {
    private Queue<Integer> queue;

    public MyStack() {
        queue = new LinkedList<>();
    }

    public void push(int x) {
        queue.offer(x);
        int size = queue.size();
        for (int i = 1; i < size; i++) {
            queue.offer(queue.poll());
        }
    }

    public int pop() {
        return queue.poll();
    }

    public int top() {
        return queue.peek();
    }

    public boolean empty() {
        return queue.isEmpty();
    }
}',
    'class MyStack() {
    private val queue = ArrayDeque<Int>()

    fun push(x: Int) {
        queue.addLast(x)
        repeat(queue.size - 1) {
            queue.addLast(queue.removeFirst())
        }
    }

    fun pop(): Int {
        return queue.removeFirst()
    }

    fun top(): Int {
        return queue.first()
    }

    fun empty(): Boolean {
        return queue.isEmpty()
    }
}',
    '## Solution: Single Queue

Time Complexity: O(n) for push, O(1) for others
Space Complexity: O(n)

Rotate queue on each push to maintain stack order.',
    'EASY',
    'stack,queue,design'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), 'push(1),push(2),top(),pop(),empty()', '2,2,false', FALSE);

-- Problem 9: Basic Calculator II (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'STACKS_QUEUES',
    'Basic Calculator II',
    '# Basic Calculator II

Implement a basic calculator to evaluate a string expression containing +, -, *, / and spaces.

**Example:**
```
Input: s = "3+2*2"
Output: 7
```',
    'Hint 1: Use a stack to handle operator precedence.
---
Hint 2: For + and -, push to stack. For * and /, compute immediately.
---
Hint 3: Sum the stack at the end.',
    'class Solution {
    public int calculate(String s) {
        Stack<Integer> stack = new Stack<>();
        int num = 0;
        char op = ''+'';
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                num = num * 10 + (c - ''0'');
            }
            if ((!Character.isDigit(c) && c != '' '') || i == s.length() - 1) {
                if (op == ''+'') stack.push(num);
                else if (op == ''-'') stack.push(-num);
                else if (op == ''*'') stack.push(stack.pop() * num);
                else if (op == ''/'') stack.push(stack.pop() / num);
                op = c;
                num = 0;
            }
        }
        int result = 0;
        for (int n : stack) result += n;
        return result;
    }
}',
    'class Solution {
    fun calculate(s: String): Int {
        val stack = ArrayDeque<Int>()
        var num = 0
        var op = ''+''
        for (i in s.indices) {
            val c = s[i]
            if (c.isDigit()) {
                num = num * 10 + (c - ''0'')
            }
            if ((!c.isDigit() && c != '' '') || i == s.length - 1) {
                when (op) {
                    ''+'' -> stack.addLast(num)
                    ''-'' -> stack.addLast(-num)
                    ''*'' -> stack.addLast(stack.removeLast() * num)
                    ''/'' -> stack.addLast(stack.removeLast() / num)
                }
                op = c
                num = 0
            }
        }
        return stack.sum()
    }
}',
    '## Solution: Stack for Precedence

Time Complexity: O(n)
Space Complexity: O(n)

Stack handles operator precedence, sum at end.',
    'MEDIUM',
    'stack,string,math'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '3+2*2', '7', FALSE),
    (LAST_INSERT_ID(), ' 3/2 ', '1', FALSE),
    (LAST_INSERT_ID(), ' 3+5 / 2 ', '5', FALSE);

-- Problem 10: Decode String (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'STACKS_QUEUES',
    'Decode String',
    '# Decode String

Given an encoded string, return its decoded string. The encoding rule is: k[encoded_string].

**Example:**
```
Input: s = "3[a]2[bc]"
Output: "aaabcbc"
```',
    'Hint 1: Use two stacks: one for counts, one for strings.
---
Hint 2: Push current string and count when [ is found.
---
Hint 3: Pop and repeat when ] is found.',
    'class Solution {
    public String decodeString(String s) {
        Stack<Integer> countStack = new Stack<>();
        Stack<StringBuilder> stringStack = new Stack<>();
        StringBuilder current = new StringBuilder();
        int k = 0;
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                k = k * 10 + (c - ''0'');
            } else if (c == ''['') {
                countStack.push(k);
                stringStack.push(current);
                current = new StringBuilder();
                k = 0;
            } else if (c == '']'') {
                StringBuilder temp = current;
                current = stringStack.pop();
                int repeatTimes = countStack.pop();
                for (int i = 0; i < repeatTimes; i++) {
                    current.append(temp);
                }
            } else {
                current.append(c);
            }
        }
        return current.toString();
    }
}',
    'class Solution {
    fun decodeString(s: String): String {
        val countStack = ArrayDeque<Int>()
        val stringStack = ArrayDeque<StringBuilder>()
        var current = StringBuilder()
        var k = 0
        for (c in s) {
            when {
                c.isDigit() -> k = k * 10 + (c - ''0'')
                c == ''['' -> {
                    countStack.addLast(k)
                    stringStack.addLast(current)
                    current = StringBuilder()
                    k = 0
                }
                c == '']'' -> {
                    val temp = current
                    current = stringStack.removeLast()
                    val repeatTimes = countStack.removeLast()
                    repeat(repeatTimes) {
                        current.append(temp)
                    }
                }
                else -> current.append(c)
            }
        }
        return current.toString()
    }
}',
    '## Solution: Two Stacks

Time Complexity: O(maxK * n), where maxK is max repeat count
Space Complexity: O(n)

Use stacks to handle nested encoding.',
    'MEDIUM',
    'stack,string,recursion'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '3[a]2[bc]', 'aaabcbc', FALSE),
    (LAST_INSERT_ID(), '3[a2[c]]', 'accaccacc', FALSE),
    (LAST_INSERT_ID(), '2[abc]3[cd]ef', 'abcabccdcdcdef', FALSE);

-- Additional 15 stack/queue problems (without full solutions)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'LEETCODE', 'STACKS_QUEUES', 'Remove All Adjacent Duplicates In String', '# Remove All Adjacent Duplicates In String

Given a string, repeatedly remove adjacent duplicates.

**Example:**
```
Input: s = "abbaca"
Output: "ca"
```', 'Hint 1: Use a stack to track characters.
---
Hint 2: Pop if top equals current character.
---
Hint 3: Otherwise push current character.', 'EASY', 'stack,string'),

('ALGO', 'AMAZON', 'STACKS_QUEUES', 'Backspace String Compare', '# Backspace String Compare

Given two strings with # representing backspace, determine if they are equal.

**Example:**
```
Input: s = "ab#c", t = "ad#c"
Output: true
```', 'Hint 1: Use stack to process each string.
---
Hint 2: Push characters, pop on #.
---
Hint 3: Compare final stacks.', 'EASY', 'stack,string,two-pointers'),

('ALGO', 'GOOGLE', 'STACKS_QUEUES', 'Next Greater Element I', '# Next Greater Element I

Find next greater element for each element in nums1 (subset of nums2).

**Example:**
```
Input: nums1 = [4,1,2], nums2 = [1,3,4,2]
Output: [-1,3,-1]
```', 'Hint 1: Use monotonic stack on nums2.
---
Hint 2: Store results in HashMap.
---
Hint 3: Lookup results for nums1 elements.', 'EASY', 'stack,array,hash-table,monotonic-stack'),

('ALGO', 'META', 'STACKS_QUEUES', 'Next Greater Element II', '# Next Greater Element II

Find next greater element in circular array.

**Example:**
```
Input: nums = [1,2,1]
Output: [2,-1,2]
```', 'Hint 1: Process array twice to handle circular nature.
---
Hint 2: Use monotonic decreasing stack.
---
Hint 3: Use modulo for circular indexing.', 'MEDIUM', 'stack,array,monotonic-stack'),

('ALGO', 'LEETCODE', 'STACKS_QUEUES', 'Simplify Path', '# Simplify Path

Simplify Unix-style absolute path.

**Example:**
```
Input: path = "/home//foo/"
Output: "/home/foo"
```', 'Hint 1: Split by / and process each component.
---
Hint 2: Use stack: push directories, pop on "..".
---
Hint 3: Ignore "." and empty strings.', 'MEDIUM', 'stack,string'),

('ALGO', 'AMAZON', 'STACKS_QUEUES', 'Remove K Digits', '# Remove K Digits

Remove k digits from number to make it smallest.

**Example:**
```
Input: num = "1432219", k = 3
Output: "1219"
```', 'Hint 1: Use monotonic increasing stack.
---
Hint 2: Remove larger digits from left.
---
Hint 3: Handle remaining k and leading zeros.', 'MEDIUM', 'stack,string,greedy,monotonic-stack'),

('ALGO', 'GOOGLE', 'STACKS_QUEUES', 'Asteroid Collision', '# Asteroid Collision

Asteroids moving right (+) or left (-) collide. Find final state.

**Example:**
```
Input: asteroids = [5,10,-5]
Output: [5,10]
```', 'Hint 1: Use stack to track surviving asteroids.
---
Hint 2: Handle collision when stack top is + and current is -.
---
Hint 3: Compare absolute values to determine winner.', 'MEDIUM', 'stack,array'),

('ALGO', 'META', 'STACKS_QUEUES', 'Maximal Rectangle', '# Maximal Rectangle

Given binary matrix, find area of largest rectangle containing only 1s.

**Example:**
```
Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"]]
Output: 6
```', 'Hint 1: Convert to histogram problem for each row.
---
Hint 2: Use largest rectangle in histogram algorithm.
---
Hint 3: Maintain heights array, reset to 0 for ''0'' cells.', 'HARD', 'stack,array,dynamic-programming,matrix,monotonic-stack'),

('ALGO', 'LEETCODE', 'STACKS_QUEUES', 'Trapping Rain Water', '# Trapping Rain Water

Given elevation map, compute how much water can be trapped.

**Example:**
```
Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6
```', 'Hint 1: Water at position = min(maxLeft, maxRight) - height.
---
Hint 2: Use two pointers or stack.
---
Hint 3: Stack tracks indices of potential water boundaries.', 'HARD', 'stack,array,two-pointers,dynamic-programming'),

('ALGO', 'AMAZON', 'STACKS_QUEUES', 'Validate Stack Sequences', '# Validate Stack Sequences

Given push and pop sequences, determine if they are valid.

**Example:**
```
Input: pushed = [1,2,3,4,5], popped = [4,5,3,2,1]
Output: true
```', 'Hint 1: Simulate stack operations.
---
Hint 2: Push from pushed array.
---
Hint 3: Pop when top matches current in popped.', 'MEDIUM', 'stack,array,simulation'),

('ALGO', 'GOOGLE', 'STACKS_QUEUES', 'Score of Parentheses', '# Score of Parentheses

Compute score: () = 1, AB = A+B, (A) = 2*A.

**Example:**
```
Input: s = "(()(()))"
Output: 6
```', 'Hint 1: Use stack to track nested scores.
---
Hint 2: Push 0 on (, pop and calculate on ).
---
Hint 3: Score = max(2*score, 1).', 'MEDIUM', 'stack,string'),

('ALGO', 'META', 'STACKS_QUEUES', 'Online Stock Span', '# Online Stock Span

Design algorithm to calculate stock span (consecutive days with price ≤ today).

**Example:**
```
Input: [100,80,60,70,60,75,85]
Output: [1,1,1,2,1,4,6]
```', 'Hint 1: Use monotonic decreasing stack.
---
Hint 2: Stack stores (price, span) pairs.
---
Hint 3: Pop smaller prices and add their spans.', 'MEDIUM', 'stack,design,monotonic-stack'),

('ALGO', 'LEETCODE', 'STACKS_QUEUES', 'Basic Calculator', '# Basic Calculator

Implement calculator with +, -, (, ) and spaces.

**Example:**
```
Input: s = "(1+(4+5+2)-3)+(6+8)"
Output: 23
```', 'Hint 1: Use stack to handle parentheses.
---
Hint 2: Track current number, result, and sign.
---
Hint 3: Push result and sign on (, pop on ).', 'HARD', 'stack,string,math,recursion'),

('ALGO', 'AMAZON', 'STACKS_QUEUES', 'Longest Valid Parentheses', '# Longest Valid Parentheses

Find length of longest valid parentheses substring.

**Example:**
```
Input: s = "(()"
Output: 2
```', 'Hint 1: Use stack to track indices of unmatched (.
---
Hint 2: Push -1 initially as base.
---
Hint 3: Calculate length using current index - stack top.', 'HARD', 'stack,string,dynamic-programming'),

('ALGO', 'GOOGLE', 'STACKS_QUEUES', 'Number of Atoms', '# Number of Atoms

Parse chemical formula and return count of each atom.

**Example:**
```
Input: formula = "K4(ON(SO3)2)2"
Output: "K4N2O14S4"
```', 'Hint 1: Use stack to handle nested parentheses.
---
Hint 2: Parse atoms, counts, and multipliers.
---
Hint 3: On ), pop and multiply counts, push back.', 'HARD', 'stack,string,hash-table,sorting');
