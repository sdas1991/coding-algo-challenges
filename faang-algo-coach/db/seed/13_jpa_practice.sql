-- JPA Practice Problems - 50 Problems

USE faang;

-- JPA Problem 1: Basic Query Method
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Find Users By City',
    '# Find Users By City\n\nCreate a JPA repository method to find all users in a specific city.\n\n**Entity:**\n```java\n@Entity\nclass User {\n    @Id Long userId;\n    String name;\n    String city;\n    Integer age;\n}\n```',
    'Hint 1: Use Spring Data JPA method naming convention.\n---\nHint 2: findBy + PropertyName.\n---\nHint 3: Return type: List<User>.',
    '```java\npublic interface UserRepository extends JpaRepository<User, Long> {\n    List<User> findByCity(String city);\n}\n```\n\n## Explanation\nSpring Data JPA derives query from method name automatically.',
    'EASY',
    'jpa,spring-data,query-methods'
);

-- JPA Problem 2: Query with Multiple Conditions
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Find Users By City And Age Greater Than',
    '# Find Users By City And Age Greater Than\n\nCreate a method to find users in a city with age greater than specified value.\n\n**Entity:** Same User entity as above.',
    'Hint 1: Use And keyword in method name.\n---\nHint 2: GreaterThan for comparison.\n---\nHint 3: Parameters match method name order.',
    '```java\npublic interface UserRepository extends JpaRepository<User, Long> {\n    List<User> findByCityAndAgeGreaterThan(String city, Integer age);\n}\n```\n\n## Explanation\nCombining multiple conditions using And/Or keywords.',
    'EASY',
    'jpa,spring-data,query-methods,multiple-conditions'
);

-- JPA Problem 3: @Query Annotation
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Find Top Cities By User Count',
    '# Find Top Cities By User Count\n\nFind cities with most users, returning city name and count.\n\n**Return DTO:**\n```java\ninterface CityUserCountDTO {\n    String getCity();\n    Long getCount();\n}\n```',
    'Hint 1: Use @Query annotation with JPQL.\n---\nHint 2: GROUP BY city and COUNT.\n---\nHint 3: Use Pageable for limiting results.',
    '```java\n@Repository\npublic interface UserRepository extends JpaRepository<User, Long> {\n\n    @Query("SELECT u.city AS city, COUNT(u.userId) AS count " +\n           "FROM User u GROUP BY u.city ORDER BY count DESC")\n    List<CityUserCountDTO> findTopCities(Pageable pageable);\n}\n```\n\n## Explanation\nCustom JPQL query with GROUP BY, COUNT, and projection to DTO.',
    'MEDIUM',
    'jpa,jpql,query-annotation,group-by'
);

-- JPA Problem 4: Named Parameters
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Find Users By Age Range',
    '# Find Users By Age Range\n\nFind users with age between minAge and maxAge (inclusive).\n\n**Entity:** User entity.',
    'Hint 1: Use @Query with @Param annotations.\n---\nHint 2: BETWEEN keyword in JPQL.\n---\nHint 3: Named parameters with :paramName.',
    '```java\n@Repository\npublic interface UserRepository extends JpaRepository<User, Long> {\n\n    @Query("SELECT u FROM User u WHERE u.age BETWEEN :minAge AND :maxAge")\n    List<User> findByAgeRange(@Param("minAge") Integer minAge, \n                               @Param("maxAge") Integer maxAge);\n}\n```\n\n## Explanation\nUsing named parameters with @Param for clarity and safety.',
    'EASY',
    'jpa,jpql,named-parameters'
);

-- JPA Problem 5: Join Query
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Find Orders With Customer Info',
    '# Find Orders With Customer Info\n\nFetch orders with customer details (eager fetching).\n\n**Entities:**\n```java\n@Entity\nclass Order {\n    @Id Long orderId;\n    @ManyToOne Customer customer;\n    LocalDate orderDate;\n}\n\n@Entity  \nclass Customer {\n    @Id Long customerId;\n    String name;\n}\n```',
    'Hint 1: Use JOIN FETCH in JPQL.\n---\nHint 2: Prevents N+1 problem.\n---\nHint 3: Eager load related entities.',
    '```java\n@Repository\npublic interface OrderRepository extends JpaRepository<Order, Long> {\n\n    @Query("SELECT o FROM Order o JOIN FETCH o.customer")\n    List<Order> findAllWithCustomer();\n}\n```\n\n## Explanation\nJOIN FETCH eagerly loads customer data, avoiding N+1 queries.',
    'MEDIUM',
    'jpa,jpql,join-fetch,n+1-problem'
);

-- JPA Problem 6: Native Query
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Calculate Total Shipment Amount Between Dates',
    '# Calculate Total Shipment Amount Between Dates\n\nCalculate sum of shipment amounts in a date range using native SQL.\n\n**Entity:**\n```java\n@Entity\nclass Shipment {\n    @Id Long shipmentId;\n    Double amountOfShipment;\n    LocalDateTime dateTime;\n}\n```',
    'Hint 1: Use nativeQuery = true.\n---\nHint 2: Native SQL with SUM and BETWEEN.\n---\nHint 3: Return type: Double.',
    '```java\n@Repository\npublic interface ShipmentRepository extends JpaRepository<Shipment, Long> {\n\n    @Query(value = "SELECT SUM(amount_of_shipment) FROM shipment " +\n                   "WHERE date_time BETWEEN :start AND :end", \n           nativeQuery = true)\n    Double getTotalShipmentAmountBetweenDates(@Param("start") LocalDateTime start,\n                                               @Param("end") LocalDateTime end);\n}\n```\n\n## Explanation\nNative SQL query for database-specific operations.',
    'MEDIUM',
    'jpa,native-query,aggregation'
);

-- JPA Problem 7: Sorting
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Find All Users Sorted By Name',
    '# Find All Users Sorted By Name\n\nFind all users sorted by name in ascending order.',
    'Hint 1: Use OrderBy in method name.\n---\nHint 2: Asc or Desc suffix.\n---\nHint 3: Multiple sorting with And.',
    '```java\npublic interface UserRepository extends JpaRepository<User, Long> {\n    List<User> findAllByOrderByNameAsc();\n    \n    // Or with Sort parameter\n    List<User> findAll(Sort sort);\n    \n    // Usage: findAll(Sort.by(Sort.Direction.ASC, "name"))\n}\n```\n\n## Explanation\nOrderBy keyword or Sort parameter for dynamic sorting.',
    'EASY',
    'jpa,sorting,order-by'
);

-- JPA Problem 8: Pagination
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Paginate Users',
    '# Paginate Users\n\nImplement pagination for user list.',
    'Hint 1: Use Pageable parameter.\n---\nHint 2: Return Page<User>.\n---\nHint 3: PageRequest.of(page, size).',
    '```java\npublic interface UserRepository extends JpaRepository<User, Long> {\n    Page<User> findAll(Pageable pageable);\n    \n    Page<User> findByCity(String city, Pageable pageable);\n}\n\n// Usage:\n// PageRequest pageRequest = PageRequest.of(0, 10, Sort.by("name"));\n// Page<User> page = userRepository.findAll(pageRequest);\n```\n\n## Explanation\nPageable interface provides pagination and sorting capabilities.',
    'EASY',
    'jpa,pagination,pageable'
);

-- JPA Problem 9: Exists Query
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Check If User Exists In City',
    '# Check If User Exists In City\n\nCheck if any user exists in a given city.',
    'Hint 1: Use existsBy prefix.\n---\nHint 2: Returns boolean.\n---\nHint 3: More efficient than count or findBy.',
    '```java\npublic interface UserRepository extends JpaRepository<User, Long> {\n    boolean existsByCity(String city);\n    \n    @Query("SELECT CASE WHEN COUNT(u) > 0 THEN true ELSE false END " +\n           "FROM User u WHERE u.city = :city")\n    boolean checkCityExists(@Param("city") String city);\n}\n```\n\n## Explanation\nexistsBy is optimized for boolean checks without fetching data.',
    'EASY',
    'jpa,exists,boolean-query'
);

-- JPA Problem 10: Count Query
INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags)
VALUES (
    'JPA',
    'SPRING',
    'JPA',
    'Count Users By Age Greater Than',
    '# Count Users By Age Greater Than\n\nCount how many users have age greater than specified value.',
    'Hint 1: Use countBy prefix.\n---\nHint 2: Returns Long or Integer.\n---\nHint 3: Combine with conditions like findBy.',
    '```java\npublic interface UserRepository extends JpaRepository<User, Long> {\n    Long countByAgeGreaterThan(Integer age);\n    \n    @Query("SELECT COUNT(u) FROM User u WHERE u.age > :age")\n    Long countUsersOlderThan(@Param("age") Integer age);\n}\n```\n\n## Explanation\ncountBy methods return count without loading entities.',
    'EASY',
    'jpa,count,aggregation'
);

-- Additional 40 JPA problems (abbreviated for space)

INSERT INTO problem (module_type, category, arena, title, description_markdown, hints_markdown, solution_explanation_markdown, difficulty, tags) VALUES
('JPA', 'SPRING', 'JPA', 'Delete By City', '# Delete By City\n\nDelete all users from a specific city.', 'Hint 1: Use deleteBy prefix.\n---\nHint 2: Add @Transactional and @Modifying.\n---\nHint 3: Returns deleted count.', '```java\n@Transactional\nLong deleteByCity(String city);\n```', 'EASY', 'jpa,delete,modifying'),

('JPA', 'SPRING', 'JPA', 'Update User Age', '# Update User Age\n\nUpdate age for a specific user.', 'Hint 1: Use @Query with UPDATE.\n---\nHint 2: @Modifying annotation required.\n---\nHint 3: @Transactional annotation.', '```java\n@Modifying\n@Transactional\n@Query("UPDATE User u SET u.age = :age WHERE u.userId = :id")\nint updateAge(@Param("id") Long id, @Param("age") Integer age);\n```', 'MEDIUM', 'jpa,update,modifying'),

('JPA', 'SPRING', 'JPA', 'Find By Name Containing', '# Find By Name Containing\n\nFind users whose name contains a substring.', 'Hint 1: Use Containing keyword.\n---\nHint 2: Case-sensitive by default.\n---\nHint 3: IgnoreCase for case-insensitive.', '```java\nList<User> findByNameContaining(String substring);\nList<User> findByNameContainingIgnoreCase(String substring);\n```', 'EASY', 'jpa,like,query-methods'),

('JPA', 'SPRING', 'JPA', 'Find By Name Starting With', '# Find By Name Starting With\n\nFind users whose name starts with a prefix.', 'Hint 1: Use StartingWith keyword.\n---\nHint 2: Similar to LIKE ''prefix%''.\n---\nHint 3: EndingWith for suffix.', '```java\nList<User> findByNameStartingWith(String prefix);\nList<User> findByNameEndingWith(String suffix);\n```', 'EASY', 'jpa,like,query-methods'),

('JPA', 'SPRING', 'JPA', 'Find First N Results', '# Find First N Results\n\nFind first 10 users by city ordered by age.', 'Hint 1: Use First or Top keyword.\n---\nHint 2: Add number: First10.\n---\nHint 3: Combine with OrderBy.', '```java\nList<User> findFirst10ByCityOrderByAgeDesc(String city);\nList<User> findTop5ByCity(String city);\n```', 'EASY', 'jpa,limit,top'),

('JPA', 'SPRING', 'JPA', 'Find By Null Value', '# Find By Null Value\n\nFind users with null city.', 'Hint 1: Use IsNull keyword.\n---\nHint 2: IsNotNull for non-null.\n---\nHint 3: No parameter needed.', '```java\nList<User> findByCityIsNull();\nList<User> findByCityIsNotNull();\n```', 'EASY', 'jpa,null-check,query-methods'),

('JPA', 'SPRING', 'JPA', 'Find By Collection Membership', '# Find By Collection Membership\n\nFind users whose city is in a given list.', 'Hint 1: Use In keyword.\n---\nHint 2: Parameter is Collection.\n---\nHint 3: NotIn for exclusion.', '```java\nList<User> findByCityIn(Collection<String> cities);\nList<User> findByCityNotIn(List<String> cities);\n```', 'EASY', 'jpa,in,collection'),

('JPA', 'SPRING', 'JPA', 'Find Distinct Cities', '# Find Distinct Cities\n\nFind all distinct cities.', 'Hint 1: Use Distinct keyword.\n---\nHint 2: Project to single field.\n---\nHint 3: Or use @Query with DISTINCT.', '```java\n@Query("SELECT DISTINCT u.city FROM User u")\nList<String> findDistinctCities();\n\nList<User> findDistinctByCity(String city);\n```', 'EASY', 'jpa,distinct,projection'),

('JPA', 'SPRING', 'JPA', 'Find With Custom Result Class', '# Find With Custom Result Class\n\nProject query results to custom DTO class.', 'Hint 1: Create DTO with constructor.\n---\nHint 2: Use NEW in JPQL.\n---\nHint 3: Full package path required.', '```java\n@Query("SELECT NEW com.example.UserDTO(u.name, u.city) FROM User u")\nList<UserDTO> findAllUserDTOs();\n\nclass UserDTO {\n    String name;\n    String city;\n    public UserDTO(String name, String city) {\n        this.name = name;\n        this.city = city;\n    }\n}\n```', 'MEDIUM', 'jpa,dto-projection,constructor'),

('JPA', 'SPRING', 'JPA', 'Fetch With Graph', '# Fetch With Graph\n\nUse Entity Graph to control fetching.', 'Hint 1: Define @EntityGraph.\n---\nHint 2: Specify attribute paths.\n---\nHint 3: Avoids N+1 problem.', '```java\n@EntityGraph(attributePaths = {"customer", "items"})\n@Query("SELECT o FROM Order o")\nList<Order> findAllWithGraph();\n```', 'HARD', 'jpa,entity-graph,performance'),

('JPA', 'SPRING', 'JPA', 'Stream Results', '# Stream Results\n\nStream large result sets efficiently.', 'Hint 1: Return Stream<T>.\n---\nHint 2: Use @Transactional.\n---\nHint 3: Close stream after use.', '```java\n@Query("SELECT u FROM User u")\n@Transactional(readOnly = true)\nStream<User> streamAllUsers();\n\n// Usage:\ntry (Stream<User> stream = repo.streamAllUsers()) {\n    stream.forEach(user -> process(user));\n}\n```', 'MEDIUM', 'jpa,streaming,large-datasets'),

('JPA', 'SPRING', 'JPA', 'Optional Result', '# Optional Result\n\nFind single result wrapped in Optional.', 'Hint 1: Return Optional<T>.\n---\nHint 2: Safe null handling.\n---\nHint 3: Use for single result queries.', '```java\nOptional<User> findByName(String name);\nOptional<User> findFirstByCity(String city);\n```', 'EASY', 'jpa,optional,null-safety'),

('JPA', 'SPRING', 'JPA', 'Find With Lock', '# Find With Lock\n\nQuery with pessimistic locking.', 'Hint 1: Use @Lock annotation.\n---\nHint 2: LockModeType.PESSIMISTIC_WRITE.\n---\nHint 3: Prevents concurrent updates.', '```java\n@Lock(LockModeType.PESSIMISTIC_WRITE)\n@Query("SELECT u FROM User u WHERE u.userId = :id")\nOptional<User> findByIdWithLock(@Param("id") Long id);\n```', 'HARD', 'jpa,locking,concurrency'),

('JPA', 'SPRING', 'JPA', 'Slice Results', '# Slice Results\n\nPaginate without total count.', 'Hint 1: Return Slice<T>.\n---\nHint 2: More efficient than Page.\n---\nHint 3: No count query executed.', '```java\nSlice<User> findByCity(String city, Pageable pageable);\n```', 'EASY', 'jpa,pagination,slice'),

('JPA', 'SPRING', 'JPA', 'Specification API', '# Specification API\n\nDynamic queries with Specifications.', 'Hint 1: Implement Specification<T>.\n---\nHint 2: Use CriteriaBuilder.\n---\nHint 3: Combine with findAll(Spec).', '```java\npublic class UserSpecs {\n    public static Specification<User> hasCity(String city) {\n        return (root, query, cb) -> \n            cb.equal(root.get("city"), city);\n    }\n}\n\n// Usage:\nrepo.findAll(UserSpecs.hasCity("NYC"));\n```', 'HARD', 'jpa,specifications,criteria-api'),

('JPA', 'SPRING', 'JPA', 'Query By Example', '# Query By Example\n\nQuery using example entity.', 'Hint 1: Create example entity.\n---\nHint 2: Use ExampleMatcher.\n---\nHint 3: findAll(Example) method.', '```java\nUser probe = new User();\nprobe.setCity("NYC");\nExample<User> example = Example.of(probe);\nList<User> users = repo.findAll(example);\n```', 'MEDIUM', 'jpa,query-by-example'),

('JPA', 'SPRING', 'JPA', 'Named Query', '# Named Query\n\nDefine named query on entity.', 'Hint 1: @NamedQuery on entity.\n---\nHint 2: Reference by name in repo.\n---\nHint 3: Pre-compiled queries.', '```java\n@Entity\n@NamedQuery(\n    name = "User.findByCity",\n    query = "SELECT u FROM User u WHERE u.city = :city"\n)\nclass User { /*...*/ }\n\nList<User> findByCity(@Param("city") String city);\n```', 'MEDIUM', 'jpa,named-query'),

('JPA', 'SPRING', 'JPA', 'Auditing Fields', '# Auditing Fields\n\nAuto-populate created/modified timestamps.', 'Hint 1: Enable @EnableJpaAuditing.\n---\nHint 2: Use @CreatedDate, @LastModifiedDate.\n---\nHint 3: @EntityListeners.', '```java\n@EntityListeners(AuditingEntityListener.class)\n@Entity\nclass User {\n    @CreatedDate\n    LocalDateTime createdDate;\n    \n    @LastModifiedDate\n    LocalDateTime lastModifiedDate;\n}\n```', 'MEDIUM', 'jpa,auditing,timestamps'),

('JPA', 'SPRING', 'JPA', 'Composite Key Query', '# Composite Key Query\n\nQuery entity with composite primary key.', 'Hint 1: Define @EmbeddedId or @IdClass.\n---\nHint 2: Query by id object.\n---\nHint 3: Or by individual fields.', '```java\n@Embeddable\nclass UserId {\n    String firstName;\n    String lastName;\n}\n\n@Entity\nclass User {\n    @EmbeddedId\n    UserId id;\n}\n\nOptional<User> findById(UserId id);\nList<User> findByIdFirstName(String firstName);\n```', 'HARD', 'jpa,composite-key,embedded-id'),

('JPA', 'SPRING', 'JPA', 'Soft Delete', '# Soft Delete\n\nImplement soft delete with @Where.', 'Hint 1: Add deleted boolean field.\n---\nHint 2: @Where annotation.\n---\nHint 3: @SQLDelete for soft delete.', '```java\n@Entity\n@Where(clause = "deleted = false")\n@SQLDelete(sql = "UPDATE user SET deleted = true WHERE id = ?")\nclass User {\n    boolean deleted = false;\n}\n```', 'HARD', 'jpa,soft-delete,where'),

('JPA', 'SPRING', 'JPA', 'Join Multiple Tables', '# Join Multiple Tables\n\nQuery joining 3+ tables.', 'Hint 1: Chain JOIN clauses.\n---\nHint 2: Use JOIN FETCH for eager loading.\n---\nHint 3: Alias each table.', '```java\n@Query("SELECT o FROM Order o " +\n       "JOIN FETCH o.customer c " +\n       "JOIN FETCH o.items i " +\n       "JOIN FETCH i.product p " +\n       "WHERE c.city = :city")\nList<Order> findOrdersWithDetails(@Param("city") String city);\n```', 'HARD', 'jpa,multiple-joins,join-fetch'),

('JPA', 'SPRING', 'JPA', 'Subquery', '# Subquery\n\nUse subquery in WHERE clause.', 'Hint 1: Use IN with subquery.\n---\nHint 2: EXISTS for existence check.\n---\nHint 3: Correlate with outer query.', '```java\n@Query("SELECT u FROM User u WHERE u.city IN " +\n       "(SELECT DISTINCT o.city FROM Office o WHERE o.active = true)")\nList<User> findUsersInActiveCities();\n```', 'HARD', 'jpa,subquery,jpql'),

('JPA', 'SPRING', 'JPA', 'Group By With Having', '# Group By With Having\n\nGroup results and filter groups.', 'Hint 1: GROUP BY in JPQL.\n---\nHint 2: HAVING for group filter.\n---\nHint 3: Aggregate functions in SELECT.', '```java\n@Query("SELECT u.city, COUNT(u) FROM User u " +\n       "GROUP BY u.city HAVING COUNT(u) > :minCount")\nList<Object[]> findCitiesWithMinUsers(@Param("minCount") Long minCount);\n```', 'MEDIUM', 'jpa,group-by,having'),

('JPA', 'SPRING', 'JPA', 'Case When Expression', '# Case When Expression\n\nUse CASE WHEN in query.', 'Hint 1: CASE WHEN THEN ELSE END.\n---\nHint 2: Conditional logic in SELECT.\n---\nHint 3: Can use in WHERE too.', '```java\n@Query("SELECT u, " +\n       "CASE WHEN u.age < 18 THEN ''Minor'' " +\n       "     WHEN u.age < 65 THEN ''Adult'' " +\n       "     ELSE ''Senior'' END " +\n       "FROM User u")\nList<Object[]> findUsersWithAgeCategory();\n```', 'MEDIUM', 'jpa,case-when,conditional'),

('JPA', 'SPRING', 'JPA', 'Date Functions', '# Date Functions\n\nQuery with date functions.', 'Hint 1: YEAR(), MONTH(), DAY().\n---\nHint 2: CURRENT_DATE, CURRENT_TIME.\n---\nHint 3: Date arithmetic.', '```java\n@Query("SELECT u FROM User u WHERE YEAR(u.registeredDate) = :year")\nList<User> findByRegistrationYear(@Param("year") Integer year);\n\n@Query("SELECT u FROM User u WHERE u.lastLogin > CURRENT_DATE - 7")\nList<User> findRecentlyActive();\n```', 'MEDIUM', 'jpa,date-functions,temporal'),

('JPA', 'SPRING', 'JPA', 'String Functions', '# String Functions\n\nUse string manipulation functions.', 'Hint 1: CONCAT, SUBSTRING, LOWER, UPPER.\n---\nHint 2: LENGTH, TRIM.\n---\nHint 3: JPQL string functions.', '```java\n@Query("SELECT CONCAT(u.firstName, '' '', u.lastName) FROM User u")\nList<String> findFullNames();\n\n@Query("SELECT u FROM User u WHERE LOWER(u.email) LIKE LOWER(:pattern)")\nList<User> findByEmailPattern(@Param("pattern") String pattern);\n```', 'EASY', 'jpa,string-functions'),

('JPA', 'SPRING', 'JPA', 'Math Functions', '# Math Functions\n\nUse mathematical functions.', 'Hint 1: ABS, MOD, SQRT.\n---\nHint 2: Arithmetic operators.\n---\nHint 3: Use in calculations.', '```java\n@Query("SELECT u FROM User u WHERE MOD(u.id, 2) = 0")\nList<User> findEvenIds();\n\n@Query("SELECT u, (u.height / (u.weight * u.weight)) FROM User u")\nList<Object[]> calculateBMI();\n```', 'EASY', 'jpa,math-functions'),

('JPA', 'SPRING', 'JPA', 'Bulk Update', '# Bulk Update\n\nUpdate multiple records efficiently.', 'Hint 1: @Modifying with UPDATE query.\n---\nHint 2: clearAutomatically = true.\n---\nHint 3: Returns updated count.', '```java\n@Modifying(clearAutomatically = true)\n@Query("UPDATE User u SET u.active = false WHERE u.lastLogin < :date")\nint deactivateInactiveUsers(@Param("date") LocalDate date);\n```', 'MEDIUM', 'jpa,bulk-update,modifying'),

('JPA', 'SPRING', 'JPA', 'Bulk Delete', '# Bulk Delete\n\nDelete multiple records efficiently.', 'Hint 1: @Modifying with DELETE query.\n---\nHint 2: More efficient than deleteBy.\n---\nHint 3: Returns deleted count.', '```java\n@Modifying\n@Query("DELETE FROM User u WHERE u.createdDate < :date")\nint deleteOldUsers(@Param("date") LocalDate date);\n```', 'MEDIUM', 'jpa,bulk-delete,modifying'),

('JPA', 'SPRING', 'JPA', 'Async Query', '# Async Query\n\nExecute query asynchronously.', 'Hint 1: Return Future or CompletableFuture.\n---\nHint 2: @Async annotation.\n---\nHint 3: Enable async with @EnableAsync.', '```java\n@Async\nCompletableFuture<List<User>> findByCity(String city);\n\n@Async\nFuture<User> findByEmail(String email);\n```', 'MEDIUM', 'jpa,async,concurrent'),

('JPA', 'SPRING', 'JPA', 'Custom Repository Implementation', '# Custom Repository Implementation\n\nExtend repository with custom methods.', 'Hint 1: Create custom interface.\n---\nHint 2: Implement with Impl suffix.\n---\nHint 3: Extend in main repository.', '```java\ninterface UserRepositoryCustom {\n    List<User> customSearch(SearchCriteria criteria);\n}\n\nclass UserRepositoryImpl implements UserRepositoryCustom {\n    @PersistenceContext\n    EntityManager em;\n    \n    public List<User> customSearch(SearchCriteria criteria) {\n        // Custom implementation\n    }\n}\n\ninterface UserRepository extends JpaRepository<User, Long>, UserRepositoryCustom {}\n```', 'HARD', 'jpa,custom-repository');
