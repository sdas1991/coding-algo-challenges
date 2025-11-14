-- Arrays Arena - 50 Problems (10 with full solutions)

USE faang;

-- Problem 1: Two Sum (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'ARRAYS',
    'Two Sum',
    '# Two Sum\n\nGiven an array of integers `nums` and an integer `target`, return indices of the two numbers such that they add up to `target`.\n\nYou may assume that each input would have exactly one solution, and you may not use the same element twice.\n\n**Example:**\n```\nInput: nums = [2,7,11,15], target = 9\nOutput: [0,1]\nExplanation: nums[0] + nums[1] == 9, so return [0, 1].\n```',
    'Hint 1: Try the brute force approach first.\n---\nHint 2: Use a HashMap to store numbers you''ve seen and their indices.\n---\nHint 3: For each number x, check if (target - x) exists in the HashMap.',
    'class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        Map<Integer, Integer> map = new HashMap<>();\n        for (int i = 0; i < nums.length; i++) {\n            int complement = target - nums[i];\n            if (map.containsKey(complement)) {\n                return new int[] { map.get(complement), i };\n            }\n            map.put(nums[i], i);\n        }\n        throw new IllegalArgumentException("No solution");\n    }\n}',
    'class Solution {\n    fun twoSum(nums: IntArray, target: Int): IntArray {\n        val map = mutableMapOf<Int, Int>()\n        for (i in nums.indices) {\n            val complement = target - nums[i]\n            if (map.containsKey(complement)) {\n                return intArrayOf(map[complement]!!, i)\n            }\n            map[nums[i]] = i\n        }\n        throw IllegalArgumentException("No solution")\n    }\n}',
    '## Solution: HashMap Approach\n\nTime Complexity: O(n)\nSpace Complexity: O(n)\n\nWe use a HashMap to store each number and its index. For each element, we check if the complement (target - current) exists in the map.',
    'EASY',
    'array,hash-table'
);

-- Test cases for Two Sum
INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[2,7,11,15],9', '[0,1]', FALSE),
    (LAST_INSERT_ID(), '[3,2,4],6', '[1,2]', FALSE),
    (LAST_INSERT_ID(), '[3,3],6', '[0,1]', FALSE);

-- Problem 2: Best Time to Buy and Sell Stock (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'ARRAYS',
    'Best Time to Buy and Sell Stock',
    '# Best Time to Buy and Sell Stock\n\nYou are given an array `prices` where `prices[i]` is the price of a given stock on the `i`th day.\n\nYou want to maximize your profit by choosing a single day to buy one stock and a different day in the future to sell that stock.\n\nReturn the maximum profit. If you cannot achieve any profit, return 0.\n\n**Example:**\n```\nInput: prices = [7,1,5,3,6,4]\nOutput: 5\nExplanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.\n```',
    'Hint 1: Track the minimum price seen so far.\n---\nHint 2: For each price, calculate profit if we sell at this price.\n---\nHint 3: Keep track of the maximum profit found.',
    'class Solution {\n    public int maxProfit(int[] prices) {\n        int minPrice = Integer.MAX_VALUE;\n        int maxProfit = 0;\n        for (int price : prices) {\n            if (price < minPrice) {\n                minPrice = price;\n            } else if (price - minPrice > maxProfit) {\n                maxProfit = price - minPrice;\n            }\n        }\n        return maxProfit;\n    }\n}',
    'class Solution {\n    fun maxProfit(prices: IntArray): Int {\n        var minPrice = Int.MAX_VALUE\n        var maxProfit = 0\n        for (price in prices) {\n            if (price < minPrice) {\n                minPrice = price\n            } else if (price - minPrice > maxProfit) {\n                maxProfit = price - minPrice\n            }\n        }\n        return maxProfit\n    }\n}',
    '## Solution: One Pass\n\nTime Complexity: O(n)\nSpace Complexity: O(1)\n\nTrack the minimum price and maximum profit in a single pass.',
    'EASY',
    'array,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[7,1,5,3,6,4]', '5', FALSE),
    (LAST_INSERT_ID(), '[7,6,4,3,1]', '0', FALSE);

-- Problem 3: Contains Duplicate (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'ARRAYS',
    'Contains Duplicate',
    '# Contains Duplicate\n\nGiven an integer array `nums`, return `true` if any value appears at least twice in the array, and return `false` if every element is distinct.\n\n**Example:**\n```\nInput: nums = [1,2,3,1]\nOutput: true\n```',
    'Hint 1: Use a HashSet to track seen elements.\n---\nHint 2: If an element is already in the set, we found a duplicate.\n---\nHint 3: Alternative: Sort the array and check adjacent elements.',
    'class Solution {\n    public boolean containsDuplicate(int[] nums) {\n        Set<Integer> seen = new HashSet<>();\n        for (int num : nums) {\n            if (!seen.add(num)) {\n                return true;\n            }\n        }\n        return false;\n    }\n}',
    'class Solution {\n    fun containsDuplicate(nums: IntArray): Boolean {\n        val seen = mutableSetOf<Int>()\n        for (num in nums) {\n            if (!seen.add(num)) {\n                return true\n            }\n        }\n        return false\n    }\n}',
    '## Solution: HashSet\n\nTime Complexity: O(n)\nSpace Complexity: O(n)\n\nUse a HashSet to detect duplicates efficiently.',
    'EASY',
    'array,hash-table'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3,1]', 'true', FALSE),
    (LAST_INSERT_ID(), '[1,2,3,4]', 'false', FALSE);

-- Problem 4: Product of Array Except Self (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'ARRAYS',
    'Product of Array Except Self',
    '# Product of Array Except Self\n\nGiven an integer array `nums`, return an array `answer` such that `answer[i]` is equal to the product of all the elements of `nums` except `nums[i]`.\n\nYou must write an algorithm that runs in O(n) time and without using the division operation.\n\n**Example:**\n```\nInput: nums = [1,2,3,4]\nOutput: [24,12,8,6]\n```',
    'Hint 1: Think about the product from the left and from the right.\n---\nHint 2: Create two passes: one for left products, one for right products.\n---\nHint 3: Can you do it in one output array with O(1) extra space?',
    'class Solution {\n    public int[] productExceptSelf(int[] nums) {\n        int n = nums.length;\n        int[] result = new int[n];\n        result[0] = 1;\n        for (int i = 1; i < n; i++) {\n            result[i] = result[i - 1] * nums[i - 1];\n        }\n        int right = 1;\n        for (int i = n - 1; i >= 0; i--) {\n            result[i] *= right;\n            right *= nums[i];\n        }\n        return result;\n    }\n}',
    'class Solution {\n    fun productExceptSelf(nums: IntArray): IntArray {\n        val n = nums.size\n        val result = IntArray(n)\n        result[0] = 1\n        for (i in 1 until n) {\n            result[i] = result[i - 1] * nums[i - 1]\n        }\n        var right = 1\n        for (i in n - 1 downTo 0) {\n            result[i] *= right\n            right *= nums[i]\n        }\n        return result\n    }\n}',
    '## Solution: Left and Right Products\n\nTime Complexity: O(n)\nSpace Complexity: O(1) (output array doesn''t count)\n\nCalculate left products going forward, then multiply by right products going backward.',
    'MEDIUM',
    'array,prefix-sum'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,2,3,4]', '[24,12,8,6]', FALSE),
    (LAST_INSERT_ID(), '[-1,1,0,-3,3]', '[0,0,9,0,0]', FALSE);

-- Problem 5: Maximum Subarray (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'ARRAYS',
    'Maximum Subarray (Kadane''s Algorithm)',
    '# Maximum Subarray\n\nGiven an integer array `nums`, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.\n\n**Example:**\n```\nInput: nums = [-2,1,-3,4,-1,2,1,-5,4]\nOutput: 6\nExplanation: [4,-1,2,1] has the largest sum = 6.\n```',
    'Hint 1: Consider dynamic programming - what is the maximum subarray ending at index i?\n---\nHint 2: Kadane''s Algorithm: Track current sum and reset if it goes negative.\n---\nHint 3: Keep a running maximum of all subarray sums seen.',
    'class Solution {\n    public int maxSubArray(int[] nums) {\n        int maxSum = nums[0];\n        int currentSum = nums[0];\n        for (int i = 1; i < nums.length; i++) {\n            currentSum = Math.max(nums[i], currentSum + nums[i]);\n            maxSum = Math.max(maxSum, currentSum);\n        }\n        return maxSum;\n    }\n}',
    'class Solution {\n    fun maxSubArray(nums: IntArray): Int {\n        var maxSum = nums[0]\n        var currentSum = nums[0]\n        for (i in 1 until nums.size) {\n            currentSum = maxOf(nums[i], currentSum + nums[i])\n            maxSum = maxOf(maxSum, currentSum)\n        }\n        return maxSum\n    }\n}',
    '## Solution: Kadane''s Algorithm\n\nTime Complexity: O(n)\nSpace Complexity: O(1)\n\nClassic dynamic programming problem solved with Kadane''s algorithm.',
    'MEDIUM',
    'array,dynamic-programming,divide-and-conquer'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[-2,1,-3,4,-1,2,1,-5,4]', '6', FALSE),
    (LAST_INSERT_ID(), '[1]', '1', FALSE),
    (LAST_INSERT_ID(), '[5,4,-1,7,8]', '23', FALSE);

-- Problem 6: Maximum Product Subarray (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'ARRAYS',
    'Maximum Product Subarray',
    '# Maximum Product Subarray\n\nGiven an integer array `nums`, find a contiguous non-empty subarray within the array that has the largest product, and return the product.\n\n**Example:**\n```\nInput: nums = [2,3,-2,4]\nOutput: 6\nExplanation: [2,3] has the largest product 6.\n```',
    'Hint 1: Track both maximum and minimum products (negatives can become positive).\n---\nHint 2: A negative number can make a small (negative) product become large.\n---\nHint 3: At each step, update max and min considering current number, max*current, min*current.',
    'class Solution {\n    public int maxProduct(int[] nums) {\n        int maxProd = nums[0];\n        int minProd = nums[0];\n        int result = nums[0];\n        for (int i = 1; i < nums.length; i++) {\n            int temp = maxProd;\n            maxProd = Math.max(nums[i], Math.max(maxProd * nums[i], minProd * nums[i]));\n            minProd = Math.min(nums[i], Math.min(temp * nums[i], minProd * nums[i]));\n            result = Math.max(result, maxProd);\n        }\n        return result;\n    }\n}',
    'class Solution {\n    fun maxProduct(nums: IntArray): Int {\n        var maxProd = nums[0]\n        var minProd = nums[0]\n        var result = nums[0]\n        for (i in 1 until nums.size) {\n            val temp = maxProd\n            maxProd = maxOf(nums[i], maxOf(maxProd * nums[i], minProd * nums[i]))\n            minProd = minOf(nums[i], minOf(temp * nums[i], minProd * nums[i]))\n            result = maxOf(result, maxProd)\n        }\n        return result\n    }\n}',
    '## Solution: Track Min and Max\n\nTime Complexity: O(n)\nSpace Complexity: O(1)\n\nTrack both max and min products because negatives can flip the values.',
    'MEDIUM',
    'array,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[2,3,-2,4]', '6', FALSE),
    (LAST_INSERT_ID(), '[-2,0,-1]', '0', FALSE);

-- Problem 7: Find Minimum in Rotated Sorted Array (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'ARRAYS',
    'Find Minimum in Rotated Sorted Array',
    '# Find Minimum in Rotated Sorted Array\n\nSuppose an array of length n sorted in ascending order is rotated between 1 and n times. Given the sorted rotated array `nums` of unique elements, return the minimum element.\n\n**Example:**\n```\nInput: nums = [3,4,5,1,2]\nOutput: 1\nExplanation: The original array was [1,2,3,4,5] rotated 3 times.\n```',
    'Hint 1: Use binary search - O(log n) is achievable.\n---\nHint 2: Compare mid element with the right boundary.\n---\nHint 3: If mid > right, minimum is in the right half; otherwise, in the left half.',
    'class Solution {\n    public int findMin(int[] nums) {\n        int left = 0, right = nums.length - 1;\n        while (left < right) {\n            int mid = left + (right - left) / 2;\n            if (nums[mid] > nums[right]) {\n                left = mid + 1;\n            } else {\n                right = mid;\n            }\n        }\n        return nums[left];\n    }\n}',
    'class Solution {\n    fun findMin(nums: IntArray): Int {\n        var left = 0\n        var right = nums.size - 1\n        while (left < right) {\n            val mid = left + (right - left) / 2\n            if (nums[mid] > nums[right]) {\n                left = mid + 1\n            } else {\n                right = mid\n            }\n        }\n        return nums[left]\n    }\n}',
    '## Solution: Binary Search\n\nTime Complexity: O(log n)\nSpace Complexity: O(1)\n\nModified binary search to find the rotation point.',
    'MEDIUM',
    'array,binary-search'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[3,4,5,1,2]', '1', FALSE),
    (LAST_INSERT_ID(), '[4,5,6,7,0,1,2]', '0', FALSE),
    (LAST_INSERT_ID(), '[11,13,15,17]', '11', FALSE);

-- Problem 8: Search in Rotated Sorted Array (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'ARRAYS',
    'Search in Rotated Sorted Array',
    '# Search in Rotated Sorted Array\n\nThere is an integer array `nums` sorted in ascending order (with distinct values). `nums` is rotated at an unknown pivot index. Given the array after rotation and a target value, return the index of target if it is in `nums`, or -1 if it is not.\n\n**Example:**\n```\nInput: nums = [4,5,6,7,0,1,2], target = 0\nOutput: 4\n```',
    'Hint 1: Modified binary search is the key.\n---\nHint 2: Determine which half is sorted, then check if target is in that range.\n---\nHint 3: Compare mid with left to find which half is properly sorted.',
    'class Solution {\n    public int search(int[] nums, int target) {\n        int left = 0, right = nums.length - 1;\n        while (left <= right) {\n            int mid = left + (right - left) / 2;\n            if (nums[mid] == target) return mid;\n            if (nums[left] <= nums[mid]) {\n                if (target >= nums[left] && target < nums[mid]) {\n                    right = mid - 1;\n                } else {\n                    left = mid + 1;\n                }\n            } else {\n                if (target > nums[mid] && target <= nums[right]) {\n                    left = mid + 1;\n                } else {\n                    right = mid - 1;\n                }\n            }\n        }\n        return -1;\n    }\n}',
    'class Solution {\n    fun search(nums: IntArray, target: Int): Int {\n        var left = 0\n        var right = nums.size - 1\n        while (left <= right) {\n            val mid = left + (right - left) / 2\n            if (nums[mid] == target) return mid\n            if (nums[left] <= nums[mid]) {\n                if (target >= nums[left] && target < nums[mid]) {\n                    right = mid - 1\n                } else {\n                    left = mid + 1\n                }\n            } else {\n                if (target > nums[mid] && target <= nums[right]) {\n                    left = mid + 1\n                } else {\n                    right = mid - 1\n                }\n            }\n        }\n        return -1\n    }\n}',
    '## Solution: Modified Binary Search\n\nTime Complexity: O(log n)\nSpace Complexity: O(1)\n\nBinary search with logic to handle rotation.',
    'MEDIUM',
    'array,binary-search'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[4,5,6,7,0,1,2],0', '4', FALSE),
    (LAST_INSERT_ID(), '[4,5,6,7,0,1,2],3', '-1', FALSE);

-- Problem 9: 3Sum (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'ARRAYS',
    '3Sum',
    '# 3Sum\n\nGiven an integer array `nums`, return all the triplets `[nums[i], nums[j], nums[k]]` such that `i != j`, `i != k`, and `j != k`, and `nums[i] + nums[j] + nums[k] == 0`.\n\nNotice that the solution set must not contain duplicate triplets.\n\n**Example:**\n```\nInput: nums = [-1,0,1,2,-1,-4]\nOutput: [[-1,-1,2],[-1,0,1]]\n```',
    'Hint 1: Sort the array first.\n---\nHint 2: Fix one element and use two pointers for the remaining two.\n---\nHint 3: Skip duplicates to avoid repeated triplets.',
    'class Solution {\n    public List<List<Integer>> threeSum(int[] nums) {\n        Arrays.sort(nums);\n        List<List<Integer>> result = new ArrayList<>();\n        for (int i = 0; i < nums.length - 2; i++) {\n            if (i > 0 && nums[i] == nums[i - 1]) continue;\n            int left = i + 1, right = nums.length - 1;\n            while (left < right) {\n                int sum = nums[i] + nums[left] + nums[right];\n                if (sum == 0) {\n                    result.add(Arrays.asList(nums[i], nums[left], nums[right]));\n                    while (left < right && nums[left] == nums[left + 1]) left++;\n                    while (left < right && nums[right] == nums[right - 1]) right--;\n                    left++;\n                    right--;\n                } else if (sum < 0) {\n                    left++;\n                } else {\n                    right--;\n                }\n            }\n        }\n        return result;\n    }\n}',
    'class Solution {\n    fun threeSum(nums: IntArray): List<List<Int>> {\n        nums.sort()\n        val result = mutableListOf<List<Int>>()\n        for (i in 0 until nums.size - 2) {\n            if (i > 0 && nums[i] == nums[i - 1]) continue\n            var left = i + 1\n            var right = nums.size - 1\n            while (left < right) {\n                val sum = nums[i] + nums[left] + nums[right]\n                when {\n                    sum == 0 -> {\n                        result.add(listOf(nums[i], nums[left], nums[right]))\n                        while (left < right && nums[left] == nums[left + 1]) left++\n                        while (left < right && nums[right] == nums[right - 1]) right--\n                        left++\n                        right--\n                    }\n                    sum < 0 -> left++\n                    else -> right--\n                }\n            }\n        }\n        return result\n    }\n}',
    '## Solution: Sort + Two Pointers\n\nTime Complexity: O(n²)\nSpace Complexity: O(1) excluding output\n\nSort array, fix one element, use two pointers for remaining pair.',
    'MEDIUM',
    'array,two-pointers,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[-1,0,1,2,-1,-4]', '[[-1,-1,2],[-1,0,1]]', FALSE),
    (LAST_INSERT_ID(), '[0,1,1]', '[]', FALSE),
    (LAST_INSERT_ID(), '[0,0,0]', '[[0,0,0]]', FALSE);

-- Problem 10: Container With Most Water (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'ARRAYS',
    'Container With Most Water',
    '# Container With Most Water\n\nGiven n non-negative integers `height` where each represents a point at coordinate `(i, height[i])`. Find two lines that together with the x-axis form a container that holds the most water.\n\n**Example:**\n```\nInput: height = [1,8,6,2,5,4,8,3,7]\nOutput: 49\nExplanation: The vertical lines at index 1 and 8 form the container.\n```',
    'Hint 1: Use two pointers starting from both ends.\n---\nHint 2: Area = min(height[left], height[right]) * (right - left).\n---\nHint 3: Move the pointer with the smaller height inward.',
    'class Solution {\n    public int maxArea(int[] height) {\n        int left = 0, right = height.length - 1;\n        int maxArea = 0;\n        while (left < right) {\n            int area = Math.min(height[left], height[right]) * (right - left);\n            maxArea = Math.max(maxArea, area);\n            if (height[left] < height[right]) {\n                left++;\n            } else {\n                right--;\n            }\n        }\n        return maxArea;\n    }\n}',
    'class Solution {\n    fun maxArea(height: IntArray): Int {\n        var left = 0\n        var right = height.size - 1\n        var maxArea = 0\n        while (left < right) {\n            val area = minOf(height[left], height[right]) * (right - left)\n            maxArea = maxOf(maxArea, area)\n            if (height[left] < height[right]) {\n                left++\n            } else {\n                right--\n            }\n        }\n        return maxArea\n    }\n}',
    '## Solution: Two Pointers\n\nTime Complexity: O(n)\nSpace Complexity: O(1)\n\nGreedy approach using two pointers from both ends.',
    'MEDIUM',
    'array,two-pointers,greedy'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '[1,8,6,2,5,4,8,3,7]', '49', FALSE),
    (LAST_INSERT_ID(), '[1,1]', '1', FALSE);

-- Additional 40 array problems (without full solutions)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'LEETCODE', 'ARRAYS', 'Missing Number', '# Missing Number\n\nGiven an array `nums` containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.\n\n**Example:**\n```\nInput: nums = [3,0,1]\nOutput: 2\n```', 'Hint 1: Sum of 0 to n is n*(n+1)/2.\n---\nHint 2: Subtract sum of array from expected sum.\n---\nHint 3: Alternative: Use XOR properties.', 'EASY', 'array,math,bit-manipulation'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Move Zeroes', '# Move Zeroes\n\nGiven an integer array `nums`, move all 0''s to the end while maintaining the relative order of the non-zero elements.\n\n**Example:**\n```\nInput: nums = [0,1,0,3,12]\nOutput: [1,3,12,0,0]\n```', 'Hint 1: Use two pointers.\n---\nHint 2: One pointer tracks non-zero position.\n---\nHint 3: Swap non-zero elements to the front.', 'EASY', 'array,two-pointers'),

('ALGO', 'AMAZON', 'ARRAYS', 'Majority Element', '# Majority Element\n\nGiven an array `nums` of size n, return the majority element (appears more than ⌊n / 2⌋ times).\n\n**Example:**\n```\nInput: nums = [3,2,3]\nOutput: 3\n```', 'Hint 1: Boyer-Moore Voting Algorithm.\n---\nHint 2: Keep a candidate and counter.\n---\nHint 3: Increment counter for same element, decrement for different.', 'EASY', 'array,hash-table,divide-and-conquer'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Rotate Array', '# Rotate Array\n\nGiven an array, rotate the array to the right by k steps.\n\n**Example:**\n```\nInput: nums = [1,2,3,4,5,6,7], k = 3\nOutput: [5,6,7,1,2,3,4]\n```', 'Hint 1: Reverse the entire array.\n---\nHint 2: Reverse first k elements.\n---\nHint 3: Reverse remaining elements.', 'MEDIUM', 'array,math,two-pointers'),

('ALGO', 'GOOGLE', 'ARRAYS', 'Plus One', '# Plus One\n\nGiven a non-empty array of decimal digits representing a non-negative integer, increment one to the integer.\n\n**Example:**\n```\nInput: digits = [1,2,3]\nOutput: [1,2,4]\n```', 'Hint 1: Start from the last digit.\n---\nHint 2: Handle carry propagation.\n---\nHint 3: Edge case: all 9s (e.g., [9,9,9]).', 'EASY', 'array,math'),

('ALGO', 'META', 'ARRAYS', 'Merge Sorted Array', '# Merge Sorted Array\n\nYou are given two sorted arrays `nums1` and `nums2`. Merge `nums2` into `nums1` as one sorted array.\n\n**Example:**\n```\nInput: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3\nOutput: [1,2,2,3,5,6]\n```', 'Hint 1: Start merging from the end.\n---\nHint 2: Use three pointers.\n---\nHint 3: Compare from largest elements.', 'EASY', 'array,two-pointers,sorting'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Intersection of Two Arrays II', '# Intersection of Two Arrays II\n\nGiven two integer arrays `nums1` and `nums2`, return an array of their intersection.\n\n**Example:**\n```\nInput: nums1 = [1,2,2,1], nums2 = [2,2]\nOutput: [2,2]\n```', 'Hint 1: Use HashMap to count frequencies.\n---\nHint 2: Alternative: Sort both arrays and use two pointers.\n---\nHint 3: Handle duplicate elements correctly.', 'EASY', 'array,hash-table,two-pointers'),

('ALGO', 'AMAZON', 'ARRAYS', 'Single Number', '# Single Number\n\nGiven a non-empty array where every element appears twice except one. Find that single one.\n\n**Example:**\n```\nInput: nums = [2,2,1]\nOutput: 1\n```', 'Hint 1: XOR has special properties.\n---\nHint 2: a XOR a = 0.\n---\nHint 3: a XOR 0 = a.', 'EASY', 'array,bit-manipulation'),

('ALGO', 'GOOGLE', 'ARRAYS', 'Find All Numbers Disappeared', '# Find All Numbers Disappeared in an Array\n\nGiven an array of integers where 1 ≤ a[i] ≤ n, some elements appear twice and others once. Find all elements that do not appear.\n\n**Example:**\n```\nInput: nums = [4,3,2,7,8,2,3,1]\nOutput: [5,6]\n```', 'Hint 1: Use array indices as markers.\n---\nHint 2: Mark visited indices by negating values.\n---\nHint 3: Positive indices indicate missing numbers.', 'EASY', 'array,hash-table'),

('ALGO', 'META', 'ARRAYS', 'Third Maximum Number', '# Third Maximum Number\n\nGiven integer array `nums`, return the third distinct maximum number. If it does not exist, return the maximum.\n\n**Example:**\n```\nInput: nums = [3,2,1]\nOutput: 1\n```', 'Hint 1: Track top 3 maximums.\n---\nHint 2: Use three variables or a set.\n---\nHint 3: Handle duplicates and nulls.', 'EASY', 'array,sorting'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Height Checker', '# Height Checker\n\nReturn the number of indices where heights[i] != expected[i], where expected is heights sorted.\n\n**Example:**\n```\nInput: heights = [1,1,4,2,1,3]\nOutput: 3\n```', 'Hint 1: Sort a copy of the array.\n---\nHint 2: Compare with original.\n---\nHint 3: Count differences.', 'EASY', 'array,sorting'),

('ALGO', 'AMAZON', 'ARRAYS', 'Sort Array By Parity', '# Sort Array By Parity\n\nGiven array `nums`, return array with all even integers followed by odd integers.\n\n**Example:**\n```\nInput: nums = [3,1,2,4]\nOutput: [2,4,3,1]\n```', 'Hint 1: Two pointers approach.\n---\nHint 2: One pointer for even position.\n---\nHint 3: Swap when odd found at even position.', 'EASY', 'array,two-pointers,sorting'),

('ALGO', 'GOOGLE', 'ARRAYS', 'Valid Mountain Array', '# Valid Mountain Array\n\nGiven array, determine if it is a valid mountain (strictly increasing then strictly decreasing).\n\n**Example:**\n```\nInput: arr = [0,3,2,1]\nOutput: true\n```', 'Hint 1: Find the peak.\n---\nHint 2: Check strict increase before peak.\n---\nHint 3: Check strict decrease after peak.', 'EASY', 'array'),

('ALGO', 'META', 'ARRAYS', 'Replace Elements with Greatest', '# Replace Elements with Greatest Element on Right Side\n\nReplace every element with the greatest element among the elements to its right.\n\n**Example:**\n```\nInput: arr = [17,18,5,4,6,1]\nOutput: [18,6,6,6,1,-1]\n```', 'Hint 1: Traverse from right to left.\n---\nHint 2: Track maximum seen so far.\n---\nHint 3: Last element becomes -1.', 'EASY', 'array'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Remove Duplicates from Sorted Array', '# Remove Duplicates from Sorted Array\n\nGiven sorted array, remove duplicates in-place and return new length.\n\n**Example:**\n```\nInput: nums = [1,1,2]\nOutput: 2, nums = [1,2,_]\n```', 'Hint 1: Two pointers.\n---\nHint 2: One for unique position.\n---\nHint 3: Compare with previous unique element.', 'EASY', 'array,two-pointers'),

('ALGO', 'AMAZON', 'ARRAYS', 'Remove Element', '# Remove Element\n\nGiven array `nums` and value `val`, remove all instances of `val` in-place.\n\n**Example:**\n```\nInput: nums = [3,2,2,3], val = 3\nOutput: 2, nums = [2,2,_,_]\n```', 'Hint 1: Two pointers approach.\n---\nHint 2: Overwrite elements equal to val.\n---\nHint 3: Track count of valid elements.', 'EASY', 'array,two-pointers'),

('ALGO', 'GOOGLE', 'ARRAYS', 'Squares of a Sorted Array', '# Squares of a Sorted Array\n\nGiven sorted array `nums`, return array of squares in sorted order.\n\n**Example:**\n```\nInput: nums = [-4,-1,0,3,10]\nOutput: [0,1,9,16,100]\n```', 'Hint 1: Two pointers from both ends.\n---\nHint 2: Compare absolute values.\n---\nHint 3: Fill result array from end.', 'EASY', 'array,two-pointers,sorting'),

('ALGO', 'META', 'ARRAYS', 'Sort Colors', '# Sort Colors (Dutch National Flag)\n\nGiven array with values 0, 1, 2, sort them in-place.\n\n**Example:**\n```\nInput: nums = [2,0,2,1,1,0]\nOutput: [0,0,1,1,2,2]\n```', 'Hint 1: Three-way partitioning.\n---\nHint 2: Use three pointers for 0s, 1s, and 2s.\n---\nHint 3: Single pass solution exists.', 'MEDIUM', 'array,two-pointers,sorting'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Kth Largest Element', '# Kth Largest Element in an Array\n\nFind the kth largest element in an unsorted array.\n\n**Example:**\n```\nInput: nums = [3,2,1,5,6,4], k = 2\nOutput: 5\n```', 'Hint 1: QuickSelect algorithm.\n---\nHint 2: Alternative: Use a min-heap of size k.\n---\nHint 3: Partition around pivot like QuickSort.', 'MEDIUM', 'array,divide-and-conquer,heap'),

('ALGO', 'AMAZON', 'ARRAYS', 'Top K Frequent Elements', '# Top K Frequent Elements\n\nGiven array, return the k most frequent elements.\n\n**Example:**\n```\nInput: nums = [1,1,1,2,2,3], k = 2\nOutput: [1,2]\n```', 'Hint 1: HashMap to count frequencies.\n---\nHint 2: Use bucket sort or heap.\n---\nHint 3: Bucket sort: index = frequency.', 'MEDIUM', 'array,hash-table,heap,bucket-sort'),

('ALGO', 'GOOGLE', 'ARRAYS', 'Subarray Sum Equals K', '# Subarray Sum Equals K\n\nGiven array and integer k, find total number of continuous subarrays whose sum equals k.\n\n**Example:**\n```\nInput: nums = [1,1,1], k = 2\nOutput: 2\n```', 'Hint 1: Use prefix sum.\n---\nHint 2: HashMap to store prefix sums.\n---\nHint 3: Check if (currentSum - k) exists in map.', 'MEDIUM', 'array,hash-table,prefix-sum'),

('ALGO', 'META', 'ARRAYS', 'Longest Consecutive Sequence', '# Longest Consecutive Sequence\n\nGiven unsorted array, find length of longest consecutive elements sequence.\n\n**Example:**\n```\nInput: nums = [100,4,200,1,3,2]\nOutput: 4 (sequence: [1,2,3,4])\n```', 'Hint 1: Use HashSet for O(1) lookup.\n---\nHint 2: Only start counting from sequence beginnings.\n---\nHint 3: A number is a start if (num-1) doesn''t exist.', 'MEDIUM', 'array,hash-table,union-find'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Game of Life', '# Game of Life\n\nGiven board, compute next state (simultaneous updates).\n\n**Example:**\n```\nInput: board = [[0,1,0],[0,0,1],[1,1,1],[0,0,0]]\nOutput: [[0,0,0],[1,0,1],[0,1,1],[0,1,0]]\n```', 'Hint 1: Use extra bits to encode next state.\n---\nHint 2: 2 bits: [next state][current state].\n---\nHint 3: Count live neighbors for each cell.', 'MEDIUM', 'array,matrix,simulation'),

('ALGO', 'AMAZON', 'ARRAYS', 'Set Matrix Zeroes', '# Set Matrix Zeroes\n\nGiven m×n matrix, if element is 0, set its entire row and column to 0s in-place.\n\n**Example:**\n```\nInput: matrix = [[1,1,1],[1,0,1],[1,1,1]]\nOutput: [[1,0,1],[0,0,0],[1,0,1]]\n```', 'Hint 1: Use first row and column as markers.\n---\nHint 2: Need extra variable for first column.\n---\nHint 3: Process markers last to avoid overwriting.', 'MEDIUM', 'array,matrix,hash-table'),

('ALGO', 'GOOGLE', 'ARRAYS', 'Spiral Matrix', '# Spiral Matrix\n\nGiven m×n matrix, return all elements in spiral order.\n\n**Example:**\n```\nInput: matrix = [[1,2,3],[4,5,6],[7,8,9]]\nOutput: [1,2,3,6,9,8,7,4,5]\n```', 'Hint 1: Track boundaries: top, bottom, left, right.\n---\nHint 2: Move right, down, left, up in order.\n---\nHint 3: Update boundaries after each direction.', 'MEDIUM', 'array,matrix,simulation'),

('ALGO', 'META', 'ARRAYS', 'Rotate Image', '# Rotate Image\n\nRotate n×n matrix by 90 degrees clockwise in-place.\n\n**Example:**\n```\nInput: matrix = [[1,2,3],[4,5,6],[7,8,9]]\nOutput: [[7,4,1],[8,5,2],[9,6,3]]\n```', 'Hint 1: Transpose the matrix first.\n---\nHint 2: Then reverse each row.\n---\nHint 3: Alternative: Rotate layer by layer.', 'MEDIUM', 'array,matrix,math'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Jump Game', '# Jump Game\n\nGiven array where nums[i] is max jump length, determine if you can reach the last index.\n\n**Example:**\n```\nInput: nums = [2,3,1,1,4]\nOutput: true\n```', 'Hint 1: Greedy approach.\n---\nHint 2: Track furthest reachable index.\n---\nHint 3: Update max reach at each position.', 'MEDIUM', 'array,dynamic-programming,greedy'),

('ALGO', 'AMAZON', 'ARRAYS', 'Jump Game II', '# Jump Game II\n\nGiven array, return minimum number of jumps to reach last index.\n\n**Example:**\n```\nInput: nums = [2,3,1,1,4]\nOutput: 2 (jump from index 0→1→4)\n```', 'Hint 1: BFS-like approach.\n---\nHint 2: Track current jump end and furthest reach.\n---\nHint 3: Increment jumps when reaching current end.', 'MEDIUM', 'array,dynamic-programming,greedy'),

('ALGO', 'GOOGLE', 'ARRAYS', 'Gas Station', '# Gas Station\n\nGiven gas and cost arrays, find starting station index to complete circuit, or -1.\n\n**Example:**\n```\nInput: gas = [1,2,3,4,5], cost = [3,4,5,1,2]\nOutput: 3\n```', 'Hint 1: If total gas < total cost, impossible.\n---\nHint 2: Track current tank balance.\n---\nHint 3: If tank goes negative, start from next station.', 'MEDIUM', 'array,greedy'),

('ALGO', 'META', 'ARRAYS', 'H-Index', '# H-Index\n\nGiven citations array, compute researcher''s h-index.\n\n**Example:**\n```\nInput: citations = [3,0,6,1,5]\nOutput: 3 (3 papers with ≥3 citations)\n```', 'Hint 1: Sort in descending order.\n---\nHint 2: h is max value where citations[i] >= i+1.\n---\nHint 3: Alternative: Counting sort approach.', 'MEDIUM', 'array,sorting,counting-sort'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Insert Delete GetRandom O(1)', '# Insert Delete GetRandom O(1)\n\nDesign data structure supporting insert, delete, getRandom in O(1).\n\n**Example:**\n```\nInput: ["insert", "remove", "getRandom"]\nOutput: [true, false, 2]\n```', 'Hint 1: Use ArrayList + HashMap.\n---\nHint 2: HashMap stores value→index.\n---\nHint 3: For delete, swap with last element.', 'MEDIUM', 'array,hash-table,math,design'),

('ALGO', 'AMAZON', 'ARRAYS', 'Next Permutation', '# Next Permutation\n\nRearrange array into lexicographically next greater permutation in-place.\n\n**Example:**\n```\nInput: nums = [1,2,3]\nOutput: [1,3,2]\n```', 'Hint 1: Find first decreasing element from right.\n---\nHint 2: Swap with next larger element.\n---\nHint 3: Reverse the suffix.', 'MEDIUM', 'array,two-pointers'),

('ALGO', 'GOOGLE', 'ARRAYS', 'Increasing Triplet Subsequence', '# Increasing Triplet Subsequence\n\nDetermine if there exists i, j, k such that i<j<k and nums[i]<nums[j]<nums[k].\n\n**Example:**\n```\nInput: nums = [1,2,3,4,5]\nOutput: true\n```', 'Hint 1: Track two minimums: first and second.\n---\nHint 2: Update first if smaller found.\n---\nHint 3: Update second if between first and current.', 'MEDIUM', 'array,greedy'),

('ALGO', 'META', 'ARRAYS', 'Count of Smaller Numbers After Self', '# Count of Smaller Numbers After Self\n\nFor each element, count how many smaller elements are to the right.\n\n**Example:**\n```\nInput: nums = [5,2,6,1]\nOutput: [2,1,1,0]\n```', 'Hint 1: Modified merge sort.\n---\nHint 2: Binary Indexed Tree (Fenwick Tree).\n---\nHint 3: Count inversions during merge.', 'HARD', 'array,binary-indexed-tree,divide-and-conquer,merge-sort'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Longest Increasing Subsequence', '# Longest Increasing Subsequence\n\nFind length of longest strictly increasing subsequence.\n\n**Example:**\n```\nInput: nums = [10,9,2,5,3,7,101,18]\nOutput: 4 (subsequence: [2,3,7,101])\n```', 'Hint 1: DP approach: dp[i] = LIS ending at i.\n---\nHint 2: Binary search approach exists for O(n log n).\n---\nHint 3: Maintain array of smallest tails.', 'MEDIUM', 'array,binary-search,dynamic-programming'),

('ALGO', 'AMAZON', 'ARRAYS', 'Russian Doll Envelopes', '# Russian Doll Envelopes\n\nGiven envelopes with widths and heights, find max number you can nest.\n\n**Example:**\n```\nInput: envelopes = [[5,4],[6,4],[6,7],[2,3]]\nOutput: 3\n```', 'Hint 1: Sort by width, then apply LIS on heights.\n---\nHint 2: For same width, sort heights descending.\n---\nHint 3: Use binary search for LIS.', 'HARD', 'array,binary-search,dynamic-programming,sorting'),

('ALGO', 'GOOGLE', 'ARRAYS', 'Count of Range Sum', '# Count of Range Sum\n\nCount number of range sums that lie in [lower, upper].\n\n**Example:**\n```\nInput: nums = [-2,5,-1], lower = -2, upper = 2\nOutput: 3\n```', 'Hint 1: Prefix sums.\n---\nHint 2: Modified merge sort to count.\n---\nHint 3: Count inversions in range.', 'HARD', 'array,binary-search,divide-and-conquer,merge-sort'),

('ALGO', 'META', 'ARRAYS', 'Create Maximum Number', '# Create Maximum Number\n\nGiven two arrays and k, create max number of length k with relative order preserved.\n\n**Example:**\n```\nInput: nums1 = [3,4,6,5], nums2 = [9,1,2,5,8,3], k = 5\nOutput: [9,8,6,5,3]\n```', 'Hint 1: Try all combinations: i from nums1, k-i from nums2.\n---\nHint 2: Find max subsequence of length i.\n---\nHint 3: Merge two subsequences optimally.', 'HARD', 'array,two-pointers,greedy,stack,monotonic-stack'),

('ALGO', 'LEETCODE', 'ARRAYS', 'Shortest Unsorted Continuous Subarray', '# Shortest Unsorted Continuous Subarray\n\nFind shortest subarray such that sorting it makes the whole array sorted.\n\n**Example:**\n```\nInput: nums = [2,6,4,8,10,9,15]\nOutput: 5 (subarray [6,4,8,10,9])\n```', 'Hint 1: Find boundaries where order breaks.\n---\nHint 2: From left, find first element > next minimum.\n---\nHint 3: From right, find first element < previous maximum.', 'MEDIUM', 'array,two-pointers,sorting'),

('ALGO', 'AMAZON', 'ARRAYS', 'Task Scheduler', '# Task Scheduler\n\nGiven tasks and cooldown period n, find minimum intervals to complete all tasks.\n\n**Example:**\n```\nInput: tasks = ["A","A","A","B","B","B"], n = 2\nOutput: 8\n```', 'Hint 1: Count frequency of each task.\n---\nHint 2: Most frequent task determines minimum time.\n---\nHint 3: Calculate idle slots based on max frequency.', 'MEDIUM', 'array,hash-table,greedy,heap,counting');
