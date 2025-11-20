#!/bin/bash

echo "Checking database contents..."
echo "================================"

# Wait for MySQL to be ready
sleep 5

# Check problem counts
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "
SELECT
    arena,
    COUNT(*) as problem_count
FROM problem
GROUP BY arena
ORDER BY arena;
" 2>/dev/null

echo ""
echo "Total problems in database:"
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SELECT COUNT(*) as total FROM problem;" 2>/dev/null

echo ""
echo "Module type breakdown:"
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "
SELECT
    module_type,
    COUNT(*) as count
FROM problem
GROUP BY module_type;
" 2>/dev/null
