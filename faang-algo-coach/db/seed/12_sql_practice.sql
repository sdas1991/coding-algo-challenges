-- SQL Practice Problems - 50 Problems

USE faang;

-- SQL Problem 1: SELECT Basics
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'LEETCODE',
    'SQL',
    'Big Countries',
    '# Big Countries\n\nFind countries that are big by area (>= 3,000,000) or by population (>= 25,000,000).\n\n**Table: World**\n```\n+-------------+---------+\n| Column Name | Type    |\n+-------------+---------+\n| name        | varchar |\n| continent   | varchar |\n| area        | int     |\n| population  | int     |\n| gdp         | bigint  |\n+-------------+---------+\n```',
    'Hint 1: Use WHERE clause with OR condition.\n---\nHint 2: Filter by area OR population.\n---\nHint 3: SELECT name, population, area FROM World WHERE...',
    '```sql\nSELECT name, population, area\nFROM World\nWHERE area >= 3000000 OR population >= 25000000;\n```\n\n## Explanation\nSimple filtering with OR condition. Both criteria are checked.',
    'EASY',
    'sql,select,where'
);

-- SQL Problem 2: JOIN Practice
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'AMAZON',
    'SQL',
    'Employees Earning More Than Managers',
    '# Employees Earning More Than Managers\n\nFind employees who earn more than their managers.\n\n**Table: Employee**\n```\n+-------------+---------+\n| Column Name | Type    |\n+-------------+---------+\n| id          | int     |\n| name        | varchar |\n| salary      | int     |\n| managerId   | int     |\n+-------------+---------+\n```',
    'Hint 1: Self join the Employee table.\n---\nHint 2: Join on employee.managerId = manager.id.\n---\nHint 3: Filter WHERE employee.salary > manager.salary.',
    '```sql\nSELECT e.name AS Employee\nFROM Employee e\nJOIN Employee m ON e.managerId = m.id\nWHERE e.salary > m.salary;\n```\n\n## Explanation\nSelf-join to compare employee salaries with their managers.',
    'EASY',
    'sql,join,self-join'
);

-- SQL Problem 3: Aggregation
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'GOOGLE',
    'SQL',
    'Customer Who Visited but Did Not Make Transactions',
    '# Customer Who Visited but Did Not Make Transactions\n\nFind customer IDs who visited but did not make any transactions, and count visits.\n\n**Tables:**\n```\nVisits: visit_id, customer_id\nTransactions: transaction_id, visit_id, amount\n```',
    'Hint 1: LEFT JOIN Visits with Transactions.\n---\nHint 2: Filter where transaction_id IS NULL.\n---\nHint 3: GROUP BY customer_id and COUNT.',
    '```sql\nSELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans\nFROM Visits v\nLEFT JOIN Transactions t ON v.visit_id = t.visit_id\nWHERE t.transaction_id IS NULL\nGROUP BY v.customer_id;\n```\n\n## Explanation\nLEFT JOIN to find visits without transactions, then aggregate by customer.',
    'EASY',
    'sql,left-join,group-by,count'
);

-- SQL Problem 4: DELETE Operation
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'LEETCODE',
    'SQL',
    'Delete Duplicate Emails',
    '# Delete Duplicate Emails\n\nDelete duplicate emails, keeping only the one with smallest id.\n\n**Table: Person**\n```\n+-------------+---------+\n| Column Name | Type    |\n+-------------+---------+\n| id          | int     |\n| email       | varchar |\n+-------------+---------+\n```',
    'Hint 1: Use DELETE with a subquery.\n---\nHint 2: Self join to find duplicates.\n---\nHint 3: Keep the row with MIN(id) for each email.',
    '```sql\nDELETE p1 FROM Person p1\nJOIN Person p2 ON p1.email = p2.email\nWHERE p1.id > p2.id;\n```\n\n## Explanation\nSelf-join to find duplicates and delete rows with higher IDs.',
    'EASY',
    'sql,delete,self-join'
);

-- SQL Problem 5: Window Functions
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'META',
    'SQL',
    'Department Top Three Salaries',
    '# Department Top Three Salaries\n\nFind employees who are in the top three unique salaries in each department.\n\n**Tables:**\n```\nEmployee: id, name, salary, departmentId\nDepartment: id, name\n```',
    'Hint 1: Use DENSE_RANK() window function.\n---\nHint 2: Partition by departmentId, order by salary DESC.\n---\nHint 3: Filter WHERE rank <= 3.',
    '```sql\nSELECT d.name AS Department, e.name AS Employee, e.salary AS Salary\nFROM (\n    SELECT *,\n           DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rnk\n    FROM Employee\n) e\nJOIN Department d ON e.departmentId = d.id\nWHERE e.rnk <= 3;\n```\n\n## Explanation\nDENSE_RANK window function to find top 3 salaries per department.',
    'HARD',
    'sql,window-functions,dense-rank,join'
);

-- SQL Problem 6: Subquery
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'AMAZON',
    'SQL',
    'Second Highest Salary',
    '# Second Highest Salary\n\nFind the second highest salary. Return null if there is no second highest.\n\n**Table: Employee**\n```\n+-------------+---------+\n| Column Name | Type    |\n+-------------+---------+\n| id          | int     |\n| salary      | int     |\n+-------------+---------+\n```',
    'Hint 1: Use DISTINCT and ORDER BY DESC.\n---\nHint 2: LIMIT 1 OFFSET 1 for second row.\n---\nHint 3: Use IFNULL or COALESCE for null case.',
    '```sql\nSELECT \n    (SELECT DISTINCT salary \n     FROM Employee \n     ORDER BY salary DESC \n     LIMIT 1 OFFSET 1) AS SecondHighestSalary;\n```\n\n## Explanation\nSubquery with LIMIT OFFSET to get second highest, returns null if not exists.',
    'MEDIUM',
    'sql,subquery,limit,offset'
);

-- SQL Problem 7: CASE WHEN
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'GOOGLE',
    'SQL',
    'Swap Salary',
    '# Swap Salary\n\nSwap all ''m'' and ''f'' values in the sex column.\n\n**Table: Salary**\n```\n+-------------+---------+\n| Column Name | Type    |\n+-------------+---------+\n| id          | int     |\n| name        | varchar |\n| sex         | enum    |\n| salary      | int     |\n+-------------+---------+\n```',
    'Hint 1: Use UPDATE with CASE WHEN.\n---\nHint 2: WHEN sex = ''m'' THEN ''f''.\n---\nHint 3: No WHERE clause needed to update all rows.',
    '```sql\nUPDATE Salary\nSET sex = CASE \n    WHEN sex = ''m'' THEN ''f''\n    WHEN sex = ''f'' THEN ''m''\nEND;\n```\n\n## Explanation\nCASE statement to swap values in a single UPDATE.',
    'EASY',
    'sql,update,case-when'
);

-- SQL Problem 8: Date Functions
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'LEETCODE',
    'SQL',
    'Rising Temperature',
    '# Rising Temperature\n\nFind dates with higher temperature compared to previous day.\n\n**Table: Weather**\n```\n+-------------+---------+\n| Column Name | Type    |\n+-------------+---------+\n| id          | int     |\n| recordDate  | date    |\n| temperature | int     |\n+-------------+---------+\n```',
    'Hint 1: Self join on date difference of 1 day.\n---\nHint 2: Use DATEDIFF or DATE_ADD.\n---\nHint 3: Compare w1.temperature > w2.temperature.',
    '```sql\nSELECT w1.id\nFROM Weather w1\nJOIN Weather w2 ON DATEDIFF(w1.recordDate, w2.recordDate) = 1\nWHERE w1.temperature > w2.temperature;\n```\n\n## Explanation\nSelf-join with DATEDIFF to compare consecutive days.',
    'EASY',
    'sql,date-functions,self-join'
);

-- SQL Problem 9: GROUP BY with HAVING
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'META',
    'SQL',
    'Classes More Than 5 Students',
    '# Classes More Than 5 Students\n\nFind all classes that have 5 or more students.\n\n**Table: Courses**\n```\n+-------------+---------+\n| Column Name | Type    |\n+-------------+---------+\n| student     | varchar |\n| class       | varchar |\n+-------------+---------+\n```',
    'Hint 1: GROUP BY class.\n---\nHint 2: Use COUNT to count students.\n---\nHint 3: HAVING COUNT(*) >= 5.',
    '```sql\nSELECT class\nFROM Courses\nGROUP BY class\nHAVING COUNT(DISTINCT student) >= 5;\n```\n\n## Explanation\nGROUP BY with HAVING to filter aggregated results.',
    'EASY',
    'sql,group-by,having,count'
);

-- SQL Problem 10: UNION
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'SQL',
    'AMAZON',
    'SQL',
    'Combine Two Tables',
    '# Combine Two Tables\n\nReturn first name, last name, city, state for each person, even if there is no address.\n\n**Tables:**\n```\nPerson: personId, firstName, lastName\nAddress: addressId, personId, city, state\n```',
    'Hint 1: Use LEFT JOIN.\n---\nHint 2: Person LEFT JOIN Address.\n---\nHint 3: Join on Person.personId = Address.personId.',
    '```sql\nSELECT p.firstName, p.lastName, a.city, a.state\nFROM Person p\nLEFT JOIN Address a ON p.personId = a.personId;\n```\n\n## Explanation\nLEFT JOIN to include all persons even without addresses.',
    'EASY',
    'sql,left-join'
);

-- Additional 40 SQL problems

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags) VALUES
('SQL', 'GOOGLE', 'SQL', 'Duplicate Emails', '# Duplicate Emails\n\nFind all duplicate emails.\n\n**Table: Person**\n```\nid | email\n```', 'Hint 1: GROUP BY email.\n---\nHint 2: COUNT(*) > 1.\n---\nHint 3: Use HAVING clause.', '```sql\nSELECT email FROM Person GROUP BY email HAVING COUNT(*) > 1;\n```', 'EASY', 'sql,group-by,having'),

('SQL', 'LEETCODE', 'SQL', 'Nth Highest Salary', '# Nth Highest Salary\n\nWrite a function to find nth highest salary.', 'Hint 1: Use LIMIT with OFFSET.\n---\nHint 2: Handle n-1 offset.\n---\nHint 3: Use DISTINCT.', '```sql\nCREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT\nBEGIN\n  SET N = N - 1;\n  RETURN (\n    SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET N\n  );\nEND\n```', 'MEDIUM', 'sql,function,limit-offset'),

('SQL', 'META', 'SQL', 'Consecutive Numbers', '# Consecutive Numbers\n\nFind all numbers that appear at least three times consecutively.\n\n**Table: Logs**\n```\nid | num\n```', 'Hint 1: Self join three times.\n---\nHint 2: l1.id = l2.id - 1 = l3.id - 2.\n---\nHint 3: l1.num = l2.num = l3.num.', '```sql\nSELECT DISTINCT l1.num AS ConsecutiveNums\nFROM Logs l1, Logs l2, Logs l3\nWHERE l1.id = l2.id - 1 AND l2.id = l3.id - 1\n  AND l1.num = l2.num AND l2.num = l3.num;\n```', 'MEDIUM', 'sql,self-join'),

('SQL', 'AMAZON', 'SQL', 'Rank Scores', '# Rank Scores\n\nRank scores with DENSE_RANK (no gaps).\n\n**Table: Scores**\n```\nid | score\n```', 'Hint 1: Use DENSE_RANK().\n---\nHint 2: ORDER BY score DESC.\n---\nHint 3: No PARTITION needed.', '```sql\nSELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank\nFROM Scores;\n```', 'MEDIUM', 'sql,window-functions,dense-rank'),

('SQL', 'GOOGLE', 'SQL', 'Department Highest Salary', '# Department Highest Salary\n\nFind employees with highest salary in each department.\n\n**Tables:**\n```\nEmployee: id, name, salary, departmentId\nDepartment: id, name\n```', 'Hint 1: Find max salary per department.\n---\nHint 2: Join Employee with this result.\n---\nHint 3: Match on both departmentId and salary.', '```sql\nSELECT d.name AS Department, e.name AS Employee, e.salary AS Salary\nFROM Employee e\nJOIN Department d ON e.departmentId = d.id\nWHERE (e.departmentId, e.salary) IN (\n    SELECT departmentId, MAX(salary)\n    FROM Employee\n    GROUP BY departmentId\n);\n```', 'MEDIUM', 'sql,join,subquery,group-by'),

('SQL', 'LEETCODE', 'SQL', 'Customers Who Never Order', '# Customers Who Never Order\n\nFind customers who never ordered anything.', 'Hint 1: LEFT JOIN Customers with Orders.\n---\nHint 2: Filter WHERE order id IS NULL.\n---\nHint 3: Alternative: NOT IN or NOT EXISTS.', '```sql\nSELECT c.name AS Customers\nFROM Customers c\nLEFT JOIN Orders o ON c.id = o.customerId\nWHERE o.id IS NULL;\n```', 'EASY', 'sql,left-join'),

('SQL', 'META', 'SQL', 'Exchange Seats', '# Exchange Seats\n\nSwap adjacent student seats. If odd number of students, last one stays.\n\n**Table: Seat**\n```\nid | student\n```', 'Hint 1: Use CASE to swap odd/even ids.\n---\nHint 2: Handle last odd id specially.\n---\nHint 3: Use MOD function.', '```sql\nSELECT\n    CASE\n        WHEN id % 2 = 1 AND id < (SELECT COUNT(*) FROM Seat) THEN id + 1\n        WHEN id % 2 = 0 THEN id - 1\n        ELSE id\n    END AS id,\n    student\nFROM Seat\nORDER BY id;\n```', 'MEDIUM', 'sql,case-when'),

('SQL', 'AMAZON', 'SQL', 'Trips and Users', '# Trips and Users\n\nFind cancellation rate for each day (unbanned users only).', 'Hint 1: Filter out banned users.\n---\nHint 2: Calculate cancelled / total per day.\n---\nHint 3: Use ROUND for formatting.', '```sql\nSELECT\n    t.request_at AS Day,\n    ROUND(SUM(CASE WHEN t.status LIKE ''cancelled%'' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ''Cancellation Rate''\nFROM Trips t\nJOIN Users u1 ON t.client_id = u1.users_id AND u1.banned = ''No''\nJOIN Users u2 ON t.driver_id = u2.users_id AND u2.banned = ''No''\nGROUP BY t.request_at;\n```', 'HARD', 'sql,join,group-by,aggregation'),

('SQL', 'GOOGLE', 'SQL', 'Human Traffic of Stadium', '# Human Traffic of Stadium\n\nFind rows with 3+ consecutive days of 100+ people.', 'Hint 1: Self join three times for consecutive rows.\n---\nHint 2: Check id sequence.\n---\nHint 3: Check people >= 100 for all three.', '```sql\nSELECT DISTINCT s1.*\nFROM Stadium s1, Stadium s2, Stadium s3\nWHERE s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100\n  AND ((s1.id = s2.id - 1 AND s2.id = s3.id - 1)\n    OR (s1.id = s2.id + 1 AND s1.id = s3.id - 1)\n    OR (s1.id = s2.id + 1 AND s2.id = s3.id + 1))\nORDER BY s1.visit_date;\n```', 'HARD', 'sql,self-join'),

('SQL', 'LEETCODE', 'SQL', 'Game Play Analysis I', '# Game Play Analysis I\n\nFind first login date for each player.', 'Hint 1: GROUP BY player_id.\n---\nHint 2: Use MIN(event_date).\n---\nHint 3: Simple aggregation.', '```sql\nSELECT player_id, MIN(event_date) AS first_login\nFROM Activity\nGROUP BY player_id;\n```', 'EASY', 'sql,group-by,min'),

('SQL', 'META', 'SQL', 'Reformat Department Table', '# Reformat Department Table\n\nPivot month column to create columns for Jan, Feb, Mar, etc.', 'Hint 1: Use CASE WHEN for each month.\n---\nHint 2: SUM with CASE to aggregate.\n---\nHint 3: GROUP BY id.', '```sql\nSELECT id,\n    SUM(CASE WHEN month = ''Jan'' THEN revenue ELSE NULL END) AS Jan_Revenue,\n    SUM(CASE WHEN month = ''Feb'' THEN revenue ELSE NULL END) AS Feb_Revenue,\n    SUM(CASE WHEN month = ''Mar'' THEN revenue ELSE NULL END) AS Mar_Revenue\nFROM Department\nGROUP BY id;\n```', 'EASY', 'sql,pivot,case-when,group-by'),

('SQL', 'AMAZON', 'SQL', 'Friend Requests I', '# Friend Requests I\n\nFind overall acceptance rate of friend requests.', 'Hint 1: Count accepted / total requested.\n---\nHint 2: Use DISTINCT for unique pairs.\n---\nHint 3: ROUND result to 2 decimals.', '```sql\nSELECT\n    ROUND(\n        IFNULL(\n            (SELECT COUNT(DISTINCT requester_id, accepter_id) FROM RequestAccepted) /\n            (SELECT COUNT(DISTINCT sender_id, send_to_id) FROM FriendRequest),\n        0), 2\n    ) AS accept_rate;\n```', 'EASY', 'sql,aggregation'),

('SQL', 'GOOGLE', 'SQL', 'Tree Node', '# Tree Node\n\nClassify each node as Root, Inner, or Leaf.', 'Hint 1: Root: p_id IS NULL.\n---\nHint 2: Leaf: not in parent column.\n---\nHint 3: Inner: everything else.', '```sql\nSELECT id,\n    CASE\n        WHEN p_id IS NULL THEN ''Root''\n        WHEN id IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL) THEN ''Inner''\n        ELSE ''Leaf''\n    END AS type\nFROM Tree;\n```', 'MEDIUM', 'sql,case-when,subquery'),

('SQL', 'LEETCODE', 'SQL', 'Not Boring Movies', '# Not Boring Movies\n\nFind movies with odd ID and description not boring, ordered by rating.', 'Hint 1: WHERE id % 2 = 1.\n---\nHint 2: AND description != ''boring''.\n---\nHint 3: ORDER BY rating DESC.', '```sql\nSELECT * FROM Cinema\nWHERE id % 2 = 1 AND description != ''boring''\nORDER BY rating DESC;\n```', 'EASY', 'sql,where,order-by'),

('SQL', 'META', 'SQL', 'Top Travellers', '# Top Travellers\n\nFind total distance travelled by each user, including 0.', 'Hint 1: LEFT JOIN Users with Rides.\n---\nHint 2: GROUP BY user.\n---\nHint 3: COALESCE for null distances.', '```sql\nSELECT u.name, COALESCE(SUM(r.distance), 0) AS travelled_distance\nFROM Users u\nLEFT JOIN Rides r ON u.id = r.user_id\nGROUP BY u.id, u.name\nORDER BY travelled_distance DESC, u.name ASC;\n```', 'EASY', 'sql,left-join,group-by,coalesce'),

('SQL', 'AMAZON', 'SQL', 'Product Sales Analysis I', '# Product Sales Analysis I\n\nReport product name, year, and price for each sale.', 'Hint 1: JOIN Sales with Product.\n---\nHint 2: ON product_id.\n---\nHint 3: Select required columns.', '```sql\nSELECT p.product_name, s.year, s.price\nFROM Sales s\nJOIN Product p ON s.product_id = p.product_id;\n```', 'EASY', 'sql,join'),

('SQL', 'GOOGLE', 'SQL', 'Article Views I', '# Article Views I\n\nFind authors who viewed their own articles.', 'Hint 1: WHERE author_id = viewer_id.\n---\nHint 2: SELECT DISTINCT.\n---\nHint 3: ORDER BY id.', '```sql\nSELECT DISTINCT author_id AS id\nFROM Views\nWHERE author_id = viewer_id\nORDER BY id;\n```', 'EASY', 'sql,where,distinct'),

('SQL', 'LEETCODE', 'SQL', 'Students and Examinations', '# Students and Examinations\n\nFind number of times each student attended each exam.', 'Hint 1: CROSS JOIN Students with Subjects.\n---\nHint 2: LEFT JOIN with Examinations.\n---\nHint 3: COUNT and GROUP BY.', '```sql\nSELECT s.student_id, s.student_name, sub.subject_name,\n       COUNT(e.subject_name) AS attended_exams\nFROM Students s\nCROSS JOIN Subjects sub\nLEFT JOIN Examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name\nGROUP BY s.student_id, s.student_name, sub.subject_name\nORDER BY s.student_id, sub.subject_name;\n```', 'EASY', 'sql,cross-join,left-join,group-by'),

('SQL', 'META', 'SQL', 'Immediate Food Delivery I', '# Immediate Food Delivery I\n\nFind percentage of immediate orders (order_date = customer_pref_delivery_date).', 'Hint 1: COUNT with CASE for immediate.\n---\nHint 2: Divide by total COUNT.\n---\nHint 3: ROUND to 2 decimals.', '```sql\nSELECT\n    ROUND(\n        100 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(*),\n    2) AS immediate_percentage\nFROM Delivery;\n```', 'EASY', 'sql,aggregation,case-when'),

('SQL', 'AMAZON', 'SQL', 'Average Selling Price', '# Average Selling Price\n\nFind average selling price for each product.', 'Hint 1: JOIN Prices with UnitsSold on product and date range.\n---\nHint 2: SUM(price * units) / SUM(units).\n---\nHint 3: ROUND to 2 decimals.', '```sql\nSELECT p.product_id,\n       ROUND(SUM(p.price * u.units) / SUM(u.units), 2) AS average_price\nFROM Prices p\nJOIN UnitsSold u ON p.product_id = u.product_id\n    AND u.purchase_date BETWEEN p.start_date AND p.end_date\nGROUP BY p.product_id;\n```', 'EASY', 'sql,join,aggregation'),

('SQL', 'GOOGLE', 'SQL', 'Project Employees I', '# Project Employees I\n\nFind average experience years for each project, rounded to 2 decimals.', 'Hint 1: JOIN Project with Employee.\n---\nHint 2: GROUP BY project_id.\n---\nHint 3: AVG(experience_years).', '```sql\nSELECT p.project_id, ROUND(AVG(e.experience_years), 2) AS average_years\nFROM Project p\nJOIN Employee e ON p.employee_id = e.employee_id\nGROUP BY p.project_id;\n```', 'EASY', 'sql,join,group-by,avg'),

('SQL', 'LEETCODE', 'SQL', 'Queries Quality and Percentage', '# Queries Quality and Percentage\n\nCalculate quality and poor_query_percentage for each query.', 'Hint 1: quality = AVG(rating / position).\n---\nHint 2: poor_query = rating < 3.\n---\nHint 3: GROUP BY query_name.', '```sql\nSELECT query_name,\n       ROUND(AVG(rating / position), 2) AS quality,\n       ROUND(100 * SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) / COUNT(*), 2) AS poor_query_percentage\nFROM Queries\nGROUP BY query_name;\n```', 'EASY', 'sql,group-by,aggregation'),

('SQL', 'META', 'SQL', 'Monthly Transactions I', '# Monthly Transactions I\n\nFind transaction count and amounts by month and country.', 'Hint 1: GROUP BY month, country.\n---\nHint 2: Use DATE_FORMAT for month.\n---\nHint 3: SUM for approved transactions.', '```sql\nSELECT\n    DATE_FORMAT(trans_date, ''%Y-%m'') AS month,\n    country,\n    COUNT(*) AS trans_count,\n    SUM(CASE WHEN state = ''approved'' THEN 1 ELSE 0 END) AS approved_count,\n    SUM(amount) AS trans_total_amount,\n    SUM(CASE WHEN state = ''approved'' THEN amount ELSE 0 END) AS approved_total_amount\nFROM Transactions\nGROUP BY month, country;\n```', 'MEDIUM', 'sql,date-functions,group-by,aggregation'),

('SQL', 'AMAZON', 'SQL', 'Last Person to Fit in Bus', '# Last Person to Fit in Bus\n\nFind last person who can board without exceeding 1000 kg limit.', 'Hint 1: Use window function for running sum.\n---\nHint 2: SUM() OVER (ORDER BY turn).\n---\nHint 3: Filter WHERE total <= 1000, get MAX turn.', '```sql\nSELECT person_name\nFROM (\n    SELECT person_name, SUM(weight) OVER (ORDER BY turn) AS total_weight\n    FROM Queue\n) AS t\nWHERE total_weight <= 1000\nORDER BY total_weight DESC\nLIMIT 1;\n```', 'MEDIUM', 'sql,window-functions,sum-over'),

('SQL', 'GOOGLE', 'SQL', 'Count Student Number in Departments', '# Count Student Number in Departments\n\nCount students in each department (including 0).', 'Hint 1: LEFT JOIN Department with Student.\n---\nHint 2: COUNT students.\n---\nHint 3: GROUP BY department.', '```sql\nSELECT d.dept_name, COUNT(s.student_id) AS student_number\nFROM Department d\nLEFT JOIN Student s ON d.dept_id = s.dept_id\nGROUP BY d.dept_id, d.dept_name\nORDER BY student_number DESC, d.dept_name;\n```', 'MEDIUM', 'sql,left-join,group-by,count'),

('SQL', 'LEETCODE', 'SQL', 'Find Median Given Frequency', '# Find Median Given Frequency\n\nFind median value considering frequencies.', 'Hint 1: Calculate cumulative frequency.\n---\nHint 2: Find middle position.\n---\nHint 3: Use window functions.', '```sql\nSELECT AVG(number) AS median\nFROM (\n    SELECT number,\n           SUM(frequency) OVER (ORDER BY number) AS cumulative,\n           SUM(frequency) OVER () AS total\n    FROM Numbers\n) AS t\nWHERE cumulative >= total / 2 AND cumulative - frequency <= total / 2;\n```', 'HARD', 'sql,window-functions,median'),

('SQL', 'META', 'SQL', 'Market Analysis I', '# Market Analysis I\n\nFind number of orders each user made in 2019.', 'Hint 1: LEFT JOIN Users with Orders.\n---\nHint 2: Filter YEAR(order_date) = 2019.\n---\nHint 3: COUNT orders per user.', '```sql\nSELECT u.user_id AS buyer_id, u.join_date,\n       COUNT(o.order_id) AS orders_in_2019\nFROM Users u\nLEFT JOIN Orders o ON u.user_id = o.buyer_id AND YEAR(o.order_date) = 2019\nGROUP BY u.user_id, u.join_date;\n```', 'MEDIUM', 'sql,left-join,date-functions,group-by'),

('SQL', 'AMAZON', 'SQL', 'Capital Gain/Loss', '# Capital Gain/Loss\n\nCalculate capital gain/loss for each stock.', 'Hint 1: SUM(CASE WHEN operation = ''Buy'' THEN -price ELSE price END).\n---\nHint 2: GROUP BY stock_name.\n---\nHint 3: Buy is negative, Sell is positive.', '```sql\nSELECT stock_name,\n       SUM(CASE WHEN operation = ''Buy'' THEN -price ELSE price END) AS capital_gain_loss\nFROM Stocks\nGROUP BY stock_name;\n```', 'MEDIUM', 'sql,group-by,case-when,aggregation'),

('SQL', 'GOOGLE', 'SQL', 'Customer Placing Largest Orders', '# Customer Placing Largest Orders\n\nFind customer who placed the largest number of orders.', 'Hint 1: GROUP BY customer_number.\n---\nHint 2: COUNT orders.\n---\nHint 3: ORDER BY count DESC LIMIT 1.', '```sql\nSELECT customer_number\nFROM Orders\nGROUP BY customer_number\nORDER BY COUNT(*) DESC\nLIMIT 1;\n```', 'EASY', 'sql,group-by,order-by,limit'),

('SQL', 'LEETCODE', 'SQL', 'Investments in 2016', '# Investments in 2016\n\nSum investments for policyholders meeting specific criteria.', 'Hint 1: Find duplicate tiv_2015 values.\n---\nHint 2: Find unique (lat, lon) pairs.\n---\nHint 3: Combine both conditions.', '```sql\nSELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016\nFROM Insurance\nWHERE tiv_2015 IN (\n    SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1\n)\nAND (lat, lon) IN (\n    SELECT lat, lon FROM Insurance GROUP BY lat, lon HAVING COUNT(*) = 1\n);\n```', 'MEDIUM', 'sql,group-by,having,subquery'),

('SQL', 'META', 'SQL', 'List Products Ordered in Period', '# List Products Ordered in Period\n\nFind products with >= 100 units ordered in February 2020.', 'Hint 1: Filter by date range.\n---\nHint 2: GROUP BY product.\n---\nHint 3: HAVING SUM(unit) >= 100.', '```sql\nSELECT p.product_name, SUM(o.unit) AS unit\nFROM Products p\nJOIN Orders o ON p.product_id = o.product_id\nWHERE o.order_date BETWEEN ''2020-02-01'' AND ''2020-02-29''\nGROUP BY p.product_id, p.product_name\nHAVING SUM(o.unit) >= 100;\n```', 'EASY', 'sql,join,date-filter,group-by,having'),

('SQL', 'AMAZON', 'SQL', 'Find Users With Valid Emails', '# Find Users With Valid Emails\n\nFind users with valid email format (prefix@leetcode.com).', 'Hint 1: Use REGEXP or LIKE.\n---\nHint 2: Check email pattern.\n---\nHint 3: Prefix starts with letter, contains letters/numbers/dots.', '```sql\nSELECT *\nFROM Users\nWHERE mail REGEXP ''^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\\\.com$'';\n```', 'EASY', 'sql,regexp,pattern-matching'),

('SQL', 'GOOGLE', 'SQL', 'Patients With Condition', '# Patients With Condition\n\nFind patients with diabetes (Type I, code DIAB1).', 'Hint 1: Check if conditions contains DIAB1.\n---\nHint 2: Use LIKE with wildcards.\n---\nHint 3: Handle word boundaries.', '```sql\nSELECT *\nFROM Patients\nWHERE conditions LIKE ''DIAB1%'' OR conditions LIKE ''% DIAB1%'';\n```', 'EASY', 'sql,like,pattern-matching'),

('SQL', 'LEETCODE', 'SQL', 'Group Sold Products By Date', '# Group Sold Products By Date\n\nFind number of different products sold and their names for each date.', 'Hint 1: GROUP BY sell_date.\n---\nHint 2: COUNT DISTINCT products.\n---\nHint 3: Use GROUP_CONCAT for product names.', '```sql\nSELECT sell_date,\n       COUNT(DISTINCT product) AS num_sold,\n       GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR '','') AS products\nFROM Activities\nGROUP BY sell_date\nORDER BY sell_date;\n```', 'EASY', 'sql,group-by,group-concat,distinct'),

('SQL', 'META', 'SQL', 'Daily Leads and Partners', '# Daily Leads and Partners\n\nFind unique lead_id and partner_id count for each date_id and make_name.', 'Hint 1: GROUP BY date_id, make_name.\n---\nHint 2: COUNT DISTINCT for both.\n---\nHint 3: Simple aggregation.', '```sql\nSELECT date_id, make_name,\n       COUNT(DISTINCT lead_id) AS unique_leads,\n       COUNT(DISTINCT partner_id) AS unique_partners\nFROM DailySales\nGROUP BY date_id, make_name;\n```', 'EASY', 'sql,group-by,count-distinct'),

('SQL', 'AMAZON', 'SQL', 'Recyclable and Low Fat Products', '# Recyclable and Low Fat Products\n\nFind products that are both low fat and recyclable.', 'Hint 1: WHERE low_fats = ''Y''.\n---\nHint 2: AND recyclable = ''Y''.\n---\nHint 3: Simple filtering.', '```sql\nSELECT product_id\nFROM Products\nWHERE low_fats = ''Y'' AND recyclable = ''Y'';\n```', 'EASY', 'sql,where'),

('SQL', 'GOOGLE', 'SQL', 'Fix Names in a Table', '# Fix Names in a Table\n\nFix names: first letter uppercase, rest lowercase.', 'Hint 1: Use CONCAT and UPPER/LOWER.\n---\nHint 2: UPPER(SUBSTRING(name, 1, 1)).\n---\nHint 3: LOWER(SUBSTRING(name, 2)).', '```sql\nSELECT user_id,\n       CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS name\nFROM Users\nORDER BY user_id;\n```', 'EASY', 'sql,string-functions'),

('SQL', 'LEETCODE', 'SQL', 'Sales Person', '# Sales Person\n\nFind salespeople who did not have sales to company RED.', 'Hint 1: Find salespeople who sold to RED.\n---\nHint 2: Use NOT IN to exclude them.\n---\nHint 3: Multiple JOIN levels.', '```sql\nSELECT name\nFROM SalesPerson\nWHERE sales_id NOT IN (\n    SELECT o.sales_id\n    FROM Orders o\n    JOIN Company c ON o.com_id = c.com_id\n    WHERE c.name = ''RED''\n);\n```', 'EASY', 'sql,not-in,subquery,join'),

('SQL', 'META', 'SQL', 'Calculate Special Bonus', '# Calculate Special Bonus\n\nCalculate bonus: 100% salary if employee_id is odd and name doesn''t start with M.', 'Hint 1: Use CASE WHEN.\n---\nHint 2: Check id % 2 = 1.\n---\nHint 3: Check name NOT LIKE ''M%''.', '```sql\nSELECT employee_id,\n       CASE\n           WHEN employee_id % 2 = 1 AND name NOT LIKE ''M%'' THEN salary\n           ELSE 0\n       END AS bonus\nFROM Employees\nORDER BY employee_id;\n```', 'EASY', 'sql,case-when,modulo');
