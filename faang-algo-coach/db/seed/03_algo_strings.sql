-- Strings Arena - 25 Problems (9 with full solutions)

USE faang;

-- Problem 1: Valid Anagram (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'STRINGS',
    'Valid Anagram',
    '# Valid Anagram\n\nGiven two strings `s` and `t`, return `true` if `t` is an anagram of `s`.\n\n**Example:**\n```\nInput: s = "anagram", t = "nagaram"\nOutput: true\n```',
    'Hint 1: Sort both strings and compare.\n---\nHint 2: Use a frequency counter (HashMap or array).\n---\nHint 3: For lowercase only, use int[26] array.',
    'class Solution {\n    public boolean isAnagram(String s, String t) {\n        if (s.length() != t.length()) return false;\n        int[] count = new int[26];\n        for (int i = 0; i < s.length(); i++) {\n            count[s.charAt(i) - ''a'']++;\n            count[t.charAt(i) - ''a'']--;\n        }\n        for (int c : count) {\n            if (c != 0) return false;\n        }\n        return true;\n    }\n}',
    'class Solution {\n    fun isAnagram(s: String, t: String): Boolean {\n        if (s.length != t.length) return false\n        val count = IntArray(26)\n        for (i in s.indices) {\n            count[s[i] - ''a'']++\n            count[t[i] - ''a'']--\n        }\n        return count.all { it == 0 }\n    }\n}',
    '## Solution: Character Frequency Count\n\nTime Complexity: O(n)\nSpace Complexity: O(1)\n\nCount character frequencies and ensure they match.',
    'EASY',
    'string,hash-table,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '"anagram","nagaram"', 'true', FALSE),
    (LAST_INSERT_ID(), '"rat","car"', 'false', FALSE);

-- Problem 2: Valid Palindrome (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'STRINGS',
    'Valid Palindrome',
    '# Valid Palindrome\n\nGiven a string `s`, return `true` if it is a palindrome (considering only alphanumeric characters and ignoring cases).\n\n**Example:**\n```\nInput: s = "A man, a plan, a canal: Panama"\nOutput: true\n```',
    'Hint 1: Use two pointers from both ends.\n---\nHint 2: Skip non-alphanumeric characters.\n---\nHint 3: Convert to lowercase for comparison.',
    'class Solution {\n    public boolean isPalindrome(String s) {\n        int left = 0, right = s.length() - 1;\n        while (left < right) {\n            while (left < right && !Character.isLetterOrDigit(s.charAt(left))) left++;\n            while (left < right && !Character.isLetterOrDigit(s.charAt(right))) right--;\n            if (Character.toLowerCase(s.charAt(left)) != Character.toLowerCase(s.charAt(right))) {\n                return false;\n            }\n            left++;\n            right--;\n        }\n        return true;\n    }\n}',
    'class Solution {\n    fun isPalindrome(s: String): Boolean {\n        var left = 0\n        var right = s.length - 1\n        while (left < right) {\n            while (left < right && !s[left].isLetterOrDigit()) left++\n            while (left < right && !s[right].isLetterOrDigit()) right--\n            if (s[left].lowercaseChar() != s[right].lowercaseChar()) {\n                return false\n            }\n            left++\n            right--\n        }\n        return true\n    }\n}',
    '## Solution: Two Pointers\n\nTime Complexity: O(n)\nSpace Complexity: O(1)\n\nTwo pointers approach, skipping non-alphanumeric characters.',
    'EASY',
    'string,two-pointers'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '"A man, a plan, a canal: Panama"', 'true', FALSE),
    (LAST_INSERT_ID(), '"race a car"', 'false', FALSE);

-- Problem 3: Longest Substring Without Repeating Characters (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'STRINGS',
    'Longest Substring Without Repeating Characters',
    '# Longest Substring Without Repeating Characters\n\nGiven a string `s`, find the length of the longest substring without repeating characters.\n\n**Example:**\n```\nInput: s = "abcabcbb"\nOutput: 3 (substring "abc")\n```',
    'Hint 1: Sliding window technique.\n---\nHint 2: Use a HashSet or HashMap to track characters.\n---\nHint 3: Move left pointer when duplicate found.',
    'class Solution {\n    public int lengthOfLongestSubstring(String s) {\n        Set<Character> set = new HashSet<>();\n        int left = 0, maxLen = 0;\n        for (int right = 0; right < s.length(); right++) {\n            while (set.contains(s.charAt(right))) {\n                set.remove(s.charAt(left));\n                left++;\n            }\n            set.add(s.charAt(right));\n            maxLen = Math.max(maxLen, right - left + 1);\n        }\n        return maxLen;\n    }\n}',
    'class Solution {\n    fun lengthOfLongestSubstring(s: String): Int {\n        val set = mutableSetOf<Char>()\n        var left = 0\n        var maxLen = 0\n        for (right in s.indices) {\n            while (s[right] in set) {\n                set.remove(s[left])\n                left++\n            }\n            set.add(s[right])\n            maxLen = maxOf(maxLen, right - left + 1)\n        }\n        return maxLen\n    }\n}',
    '## Solution: Sliding Window + HashSet\n\nTime Complexity: O(n)\nSpace Complexity: O(min(n, m)) where m is charset size\n\nSliding window with HashSet to track unique characters.',
    'MEDIUM',
    'string,hash-table,sliding-window'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '"abcabcbb"', '3', FALSE),
    (LAST_INSERT_ID(), '"bbbbb"', '1', FALSE),
    (LAST_INSERT_ID(), '"pwwkew"', '3', FALSE);

-- Problem 4: Longest Palindromic Substring (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'META',
    'STRINGS',
    'Longest Palindromic Substring',
    '# Longest Palindromic Substring\n\nGiven a string `s`, return the longest palindromic substring in `s`.\n\n**Example:**\n```\nInput: s = "babad"\nOutput: "bab" (or "aba")\n```',
    'Hint 1: Expand around center for each possible center.\n---\nHint 2: Consider both odd-length and even-length palindromes.\n---\nHint 3: Alternative: Dynamic Programming approach.',
    'class Solution {\n    public String longestPalindrome(String s) {\n        if (s == null || s.length() < 1) return "";\n        int start = 0, end = 0;\n        for (int i = 0; i < s.length(); i++) {\n            int len1 = expandAroundCenter(s, i, i);\n            int len2 = expandAroundCenter(s, i, i + 1);\n            int len = Math.max(len1, len2);\n            if (len > end - start) {\n                start = i - (len - 1) / 2;\n                end = i + len / 2;\n            }\n        }\n        return s.substring(start, end + 1);\n    }\n    \n    private int expandAroundCenter(String s, int left, int right) {\n        while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {\n            left--;\n            right++;\n        }\n        return right - left - 1;\n    }\n}',
    'class Solution {\n    fun longestPalindrome(s: String): String {\n        if (s.isEmpty()) return ""\n        var start = 0\n        var end = 0\n        for (i in s.indices) {\n            val len1 = expandAroundCenter(s, i, i)\n            val len2 = expandAroundCenter(s, i, i + 1)\n            val len = maxOf(len1, len2)\n            if (len > end - start) {\n                start = i - (len - 1) / 2\n                end = i + len / 2\n            }\n        }\n        return s.substring(start, end + 1)\n    }\n    \n    private fun expandAroundCenter(s: String, left: Int, right: Int): Int {\n        var l = left\n        var r = right\n        while (l >= 0 && r < s.length && s[l] == s[r]) {\n            l--\n            r++\n        }\n        return r - l - 1\n    }\n}',
    '## Solution: Expand Around Center\n\nTime Complexity: O(n²)\nSpace Complexity: O(1)\n\nExpand around each possible center (odd and even length).',
    'MEDIUM',
    'string,dynamic-programming'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '"babad"', '"bab"', FALSE),
    (LAST_INSERT_ID(), '"cbbd"', '"bb"', FALSE);

-- Problem 5: Group Anagrams (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'GOOGLE',
    'STRINGS',
    'Group Anagrams',
    '# Group Anagrams\n\nGiven an array of strings `strs`, group the anagrams together.\n\n**Example:**\n```\nInput: strs = ["eat","tea","tan","ate","nat","bat"]\nOutput: [["bat"],["nat","tan"],["ate","eat","tea"]]\n```',
    'Hint 1: Use sorted string as key.\n---\nHint 2: HashMap with sorted string → list of anagrams.\n---\nHint 3: Alternative: Use character count as key.',
    'class Solution {\n    public List<List<String>> groupAnagrams(String[] strs) {\n        Map<String, List<String>> map = new HashMap<>();\n        for (String str : strs) {\n            char[] chars = str.toCharArray();\n            Arrays.sort(chars);\n            String key = new String(chars);\n            map.computeIfAbsent(key, k -> new ArrayList<>()).add(str);\n        }\n        return new ArrayList<>(map.values());\n    }\n}',
    'class Solution {\n    fun groupAnagrams(strs: Array<String>): List<List<String>> {\n        val map = mutableMapOf<String, MutableList<String>>()\n        for (str in strs) {\n            val key = str.toCharArray().sorted().joinToString("")\n            map.getOrPut(key) { mutableListOf() }.add(str)\n        }\n        return map.values.toList()\n    }\n}',
    '## Solution: HashMap with Sorted Key\n\nTime Complexity: O(n * k log k) where k is max string length\nSpace Complexity: O(n * k)\n\nGroup strings by their sorted form.',
    'MEDIUM',
    'string,hash-table,sorting'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '["eat","tea","tan","ate","nat","bat"]', '[["bat"],["nat","tan"],["ate","eat","tea"]]', FALSE);

-- Problem 6: Valid Parentheses (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'STRINGS',
    'Valid Parentheses',
    '# Valid Parentheses\n\nGiven a string `s` containing just the characters ''('', '')'', ''{'', ''}'', ''['' and '']'', determine if the input string is valid.\n\n**Example:**\n```\nInput: s = "()[]{}"\nOutput: true\n```',
    'Hint 1: Use a stack.\n---\nHint 2: Push opening brackets, pop for closing.\n---\nHint 3: Check if popped bracket matches closing bracket.',
    'class Solution {\n    public boolean isValid(String s) {\n        Stack<Character> stack = new Stack<>();\n        for (char c : s.toCharArray()) {\n            if (c == ''('' || c == ''{'' || c == ''['') {\n                stack.push(c);\n            } else {\n                if (stack.isEmpty()) return false;\n                char top = stack.pop();\n                if ((c == '')'' && top != ''('') || \n                    (c == ''}'' && top != ''{'') || \n                    (c == '']'' && top != ''['')) {\n                    return false;\n                }\n            }\n        }\n        return stack.isEmpty();\n    }\n}',
    'class Solution {\n    fun isValid(s: String): Boolean {\n        val stack = mutableListOf<Char>()\n        for (c in s) {\n            when (c) {\n                ''('', ''{'', ''['' -> stack.add(c)\n                else -> {\n                    if (stack.isEmpty()) return false\n                    val top = stack.removeAt(stack.size - 1)\n                    if ((c == '')'' && top != ''('') || \n                        (c == ''}'' && top != ''{'') || \n                        (c == '']'' && top != ''['')) {\n                        return false\n                    }\n                }\n            }\n        }\n        return stack.isEmpty()\n    }\n}',
    '## Solution: Stack\n\nTime Complexity: O(n)\nSpace Complexity: O(n)\n\nUse stack to match opening and closing brackets.',
    'EASY',
    'string,stack'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '"()[]{ }"', 'true', FALSE),
    (LAST_INSERT_ID(), '"(]"', 'false', FALSE),
    (LAST_INSERT_ID(), '"([)]"', 'false', FALSE);

-- Problem 7: Longest Common Prefix (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'STRINGS',
    'Longest Common Prefix',
    '# Longest Common Prefix\n\nWrite a function to find the longest common prefix string amongst an array of strings.\n\n**Example:**\n```\nInput: strs = ["flower","flow","flight"]\nOutput: "fl"\n```',
    'Hint 1: Compare characters vertically.\n---\nHint 2: Stop when mismatch found.\n---\nHint 3: Alternative: Sort array and compare first and last.',
    'class Solution {\n    public String longestCommonPrefix(String[] strs) {\n        if (strs == null || strs.length == 0) return "";\n        String prefix = strs[0];\n        for (int i = 1; i < strs.length; i++) {\n            while (strs[i].indexOf(prefix) != 0) {\n                prefix = prefix.substring(0, prefix.length() - 1);\n                if (prefix.isEmpty()) return "";\n            }\n        }\n        return prefix;\n    }\n}',
    'class Solution {\n    fun longestCommonPrefix(strs: Array<String>): String {\n        if (strs.isEmpty()) return ""\n        var prefix = strs[0]\n        for (i in 1 until strs.size) {\n            while (!strs[i].startsWith(prefix)) {\n                prefix = prefix.substring(0, prefix.length - 1)\n                if (prefix.isEmpty()) return ""\n            }\n        }\n        return prefix\n    }\n}',
    '## Solution: Horizontal Scanning\n\nTime Complexity: O(S) where S is sum of all characters\nSpace Complexity: O(1)\n\nCompare prefix with each string, shortening as needed.',
    'EASY',
    'string,trie'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '["flower","flow","flight"]', '"fl"', FALSE),
    (LAST_INSERT_ID(), '["dog","racecar","car"]', '""', FALSE);

-- Problem 8: String to Integer (atoi) (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'AMAZON',
    'STRINGS',
    'String to Integer (atoi)',
    '# String to Integer (atoi)\n\nImplement the `myAtoi(string s)` function, which converts a string to a 32-bit signed integer.\n\n**Example:**\n```\nInput: s = "42"\nOutput: 42\n```',
    'Hint 1: Skip leading whitespaces.\n---\nHint 2: Handle optional sign.\n---\nHint 3: Check for overflow before adding digit.',
    'class Solution {\n    public int myAtoi(String s) {\n        int i = 0, n = s.length();\n        while (i < n && s.charAt(i) == '' '') i++;\n        if (i == n) return 0;\n        \n        int sign = 1;\n        if (s.charAt(i) == ''+'') {\n            i++;\n        } else if (s.charAt(i) == ''-'') {\n            sign = -1;\n            i++;\n        }\n        \n        long result = 0;\n        while (i < n && Character.isDigit(s.charAt(i))) {\n            result = result * 10 + (s.charAt(i) - ''0'');\n            if (result * sign > Integer.MAX_VALUE) return Integer.MAX_VALUE;\n            if (result * sign < Integer.MIN_VALUE) return Integer.MIN_VALUE;\n            i++;\n        }\n        return (int)(result * sign);\n    }\n}',
    'class Solution {\n    fun myAtoi(s: String): Int {\n        var i = 0\n        val n = s.length\n        while (i < n && s[i] == '' '') i++\n        if (i == n) return 0\n        \n        var sign = 1\n        if (s[i] == ''+'') {\n            i++\n        } else if (s[i] == ''-'') {\n            sign = -1\n            i++\n        }\n        \n        var result = 0L\n        while (i < n && s[i].isDigit()) {\n            result = result * 10 + (s[i] - ''0'')\n            if (result * sign > Int.MAX_VALUE) return Int.MAX_VALUE\n            if (result * sign < Int.MIN_VALUE) return Int.MIN_VALUE\n            i++\n        }\n        return (result * sign).toInt()\n    }\n}',
    '## Solution: State Machine / Careful Parsing\n\nTime Complexity: O(n)\nSpace Complexity: O(1)\n\nHandle whitespace, sign, digits, and overflow carefully.',
    'MEDIUM',
    'string,math'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '"42"', '42', FALSE),
    (LAST_INSERT_ID(), '"   -42"', '-42', FALSE),
    (LAST_INSERT_ID(), '"4193 with words"', '4193', FALSE);

-- Problem 9: Implement strStr() (SOLVED)
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solved_java_code, solved_kotlin_code, solution_explanation_markdown, difficulty, tags)
VALUES (
    'ALGO',
    'LEETCODE',
    'STRINGS',
    'Implement strStr()',
    '# Implement strStr()\n\nReturn the index of the first occurrence of `needle` in `haystack`, or -1 if not present.\n\n**Example:**\n```\nInput: haystack = "hello", needle = "ll"\nOutput: 2\n```',
    'Hint 1: Brute force: check every position.\n---\nHint 2: KMP algorithm for optimal solution.\n---\nHint 3: Built-in indexOf works but implement manually.',
    'class Solution {\n    public int strStr(String haystack, String needle) {\n        if (needle.isEmpty()) return 0;\n        int m = haystack.length(), n = needle.length();\n        for (int i = 0; i <= m - n; i++) {\n            int j = 0;\n            while (j < n && haystack.charAt(i + j) == needle.charAt(j)) {\n                j++;\n            }\n            if (j == n) return i;\n        }\n        return -1;\n    }\n}',
    'class Solution {\n    fun strStr(haystack: String, needle: String): Int {\n        if (needle.isEmpty()) return 0\n        val m = haystack.length\n        val n = needle.length\n        for (i in 0..m - n) {\n            var j = 0\n            while (j < n && haystack[i + j] == needle[j]) {\n                j++\n            }\n            if (j == n) return i\n        }\n        return -1\n    }\n}',
    '## Solution: Brute Force\n\nTime Complexity: O(m * n)\nSpace Complexity: O(1)\n\nCheck every position for needle match.',
    'EASY',
    'string,two-pointers,string-matching'
);

INSERT INTO test_case (problem_id, input_data, expected_output, is_hidden)
VALUES
    (LAST_INSERT_ID(), '"hello","ll"', '2', FALSE),
    (LAST_INSERT_ID(), '"aaaaa","bba"', '-1', FALSE);

-- Additional 16 string problems without full solutions

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, difficulty, tags) VALUES
('ALGO', 'GOOGLE', 'STRINGS', 'Reverse String', '# Reverse String\n\nWrite a function that reverses a string in-place.\n\n**Example:**\n```\nInput: s = ["h","e","l","l","o"]\nOutput: ["o","l","l","e","h"]\n```', 'Hint 1: Two pointers from both ends.\n---\nHint 2: Swap characters while moving inward.\n---\nHint 3: Stop when pointers meet.', 'EASY', 'string,two-pointers'),

('ALGO', 'LEETCODE', 'STRINGS', 'Reverse Words in a String', '# Reverse Words in a String\n\nGiven string `s`, reverse the order of words.\n\n**Example:**\n```\nInput: s = "the sky is blue"\nOutput: "blue is sky the"\n```', 'Hint 1: Split by spaces.\n---\nHint 2: Reverse the array of words.\n---\nHint 3: Join with space.', 'MEDIUM', 'string,two-pointers'),

('ALGO', 'AMAZON', 'STRINGS', 'Palindrome Permutation', '# Palindrome Permutation\n\nGiven string, check if any permutation forms a palindrome.\n\n**Example:**\n```\nInput: s = "code"\nOutput: false\n```', 'Hint 1: Count character frequencies.\n---\nHint 2: At most one character can have odd count.\n---\nHint 3: Use HashSet to toggle characters.', 'EASY', 'string,hash-table'),

('ALGO', 'META', 'STRINGS', 'Longest Repeating Character Replacement', '# Longest Repeating Character Replacement\n\nReplace at most k characters to get longest substring of same character.\n\n**Example:**\n```\nInput: s = "ABAB", k = 2\nOutput: 4 (replace both As or both Bs)\n```', 'Hint 1: Sliding window.\n---\nHint 2: Track max frequency character in window.\n---\nHint 3: If window_size - max_freq > k, shrink window.', 'MEDIUM', 'string,hash-table,sliding-window'),

('ALGO', 'GOOGLE', 'STRINGS', 'Minimum Window Substring', '# Minimum Window Substring\n\nFind minimum window in s which contains all characters of t.\n\n**Example:**\n```\nInput: s = "ADOBECODEBANC", t = "ABC"\nOutput: "BANC"\n```', 'Hint 1: Sliding window with two pointers.\n---\nHint 2: HashMap to track required character counts.\n---\nHint 3: Expand right, contract left when valid.', 'HARD', 'string,hash-table,sliding-window'),

('ALGO', 'LEETCODE', 'STRINGS', 'Encode and Decode Strings', '# Encode and Decode Strings\n\nDesign encode/decode algorithm for list of strings.\n\n**Example:**\n```\nInput: ["hello","world"]\nEncoded: "5#hello5#world"\n```', 'Hint 1: Use length + delimiter.\n---\nHint 2: Format: len + # + string.\n---\nHint 3: Decode by reading length first.', 'MEDIUM', 'string,design'),

('ALGO', 'AMAZON', 'STRINGS', 'Letter Combinations of a Phone Number', '# Letter Combinations of a Phone Number\n\nGiven string of digits, return all possible letter combinations.\n\n**Example:**\n```\nInput: digits = "23"\nOutput: ["ad","ae","af","bd","be","bf","cd","ce","cf"]\n```', 'Hint 1: Backtracking.\n---\nHint 2: Map each digit to letters.\n---\nHint 3: Build combinations recursively.', 'MEDIUM', 'string,hash-table,backtracking'),

('ALGO', 'META', 'STRINGS', 'Generate Parentheses', '# Generate Parentheses\n\nGenerate all combinations of n pairs of well-formed parentheses.\n\n**Example:**\n```\nInput: n = 3\nOutput: ["((()))","(()())","(())()","()(())","()()()"]\n```', 'Hint 1: Backtracking.\n---\nHint 2: Track open and close count.\n---\nHint 3: Only add ) when close < open.', 'MEDIUM', 'string,backtracking,dynamic-programming'),

('ALGO', 'GOOGLE', 'STRINGS', 'Multiply Strings', '# Multiply Strings\n\nGiven two non-negative integers as strings, return their product as a string.\n\n**Example:**\n```\nInput: num1 = "2", num2 = "3"\nOutput: "6"\n```', 'Hint 1: Simulate multiplication digit by digit.\n---\nHint 2: Result length is at most len1 + len2.\n---\nHint 3: Handle carry carefully.', 'MEDIUM', 'string,math,simulation'),

('ALGO', 'LEETCODE', 'STRINGS', 'Zigzag Conversion', '# Zigzag Conversion\n\nWrite string in zigzag pattern on given number of rows.\n\n**Example:**\n```\nInput: s = "PAYPALISHIRING", numRows = 3\nOutput: "PAHNAPLSIIGYIR"\n```', 'Hint 1: Create array of StringBuilders.\n---\nHint 2: Track current row and direction.\n---\nHint 3: Reverse direction at boundaries.', 'MEDIUM', 'string'),

('ALGO', 'AMAZON', 'STRINGS', 'Count and Say', '# Count and Say\n\nGenerate the nth term of count-and-say sequence.\n\n**Example:**\n```\nInput: n = 4\nOutput: "1211" (sequence: 1, 11, 21, 1211)\n```', 'Hint 1: Iteratively build from "1".\n---\nHint 2: Count consecutive same digits.\n---\nHint 3: Append count + digit.', 'MEDIUM', 'string'),

('ALGO', 'META', 'STRINGS', 'Word Break', '# Word Break\n\nGiven string s and dictionary, determine if s can be segmented into space-separated dictionary words.\n\n**Example:**\n```\nInput: s = "leetcode", wordDict = ["leet","code"]\nOutput: true\n```', 'Hint 1: Dynamic programming.\n---\nHint 2: dp[i] = can we break s[0..i].\n---\nHint 3: Check all substrings ending at i.', 'MEDIUM', 'string,hash-table,dynamic-programming,trie'),

('ALGO', 'GOOGLE', 'STRINGS', 'Word Break II', '# Word Break II\n\nReturn all possible sentences from word break.\n\n**Example:**\n```\nInput: s = "catsanddog", wordDict = ["cat","cats","and","sand","dog"]\nOutput: ["cats and dog","cat sand dog"]\n```', 'Hint 1: Backtracking + memoization.\n---\nHint 2: DFS to build sentences.\n---\nHint 3: Cache results for substrings.', 'HARD', 'string,hash-table,backtracking,trie,memoization'),

('ALGO', 'LEETCODE', 'STRINGS', 'Regular Expression Matching', '# Regular Expression Matching\n\nImplement regular expression matching with . and *.\n\n**Example:**\n```\nInput: s = "aa", p = "a*"\nOutput: true\n```', 'Hint 1: Dynamic programming.\n---\nHint 2: dp[i][j] = s[0..i] matches p[0..j].\n---\nHint 3: Handle . and * cases separately.', 'HARD', 'string,dynamic-programming,recursion'),

('ALGO', 'AMAZON', 'STRINGS', 'Wildcard Matching', '# Wildcard Matching\n\nImplement wildcard pattern matching with ? and *.\n\n**Example:**\n```\nInput: s = "aa", p = "*"\nOutput: true\n```', 'Hint 1: Dynamic programming.\n---\nHint 2: Similar to regex matching.\n---\nHint 3: * can match empty or any sequence.', 'HARD', 'string,dynamic-programming,greedy,recursion'),

('ALGO', 'GOOGLE', 'STRINGS', 'Distinct Subsequences', '# Distinct Subsequences\n\nCount distinct subsequences of s that equal t.\n\n**Example:**\n```\nInput: s = "rabbbit", t = "rabbit"\nOutput: 3\n```', 'Hint 1: Dynamic programming.\n---\nHint 2: dp[i][j] = # of ways to form t[0..j] from s[0..i].\n---\nHint 3: If s[i]==t[j], add dp[i-1][j-1].', 'HARD', 'string,dynamic-programming');
