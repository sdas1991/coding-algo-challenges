#!/bin/bash

echo "========================================="
echo "FAANG Algo Coach - Database Fix Script"
echo "========================================="
echo ""
echo "This will completely rebuild the database with the correct schema."
echo ""

read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 1
fi

echo ""
echo "Step 1: Stopping containers..."
docker-compose down

echo ""
echo "Step 2: Removing database volume..."
docker volume rm faang-algo-coach_mysql-data 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✓ Volume removed successfully"
else
    echo "⚠ Volume may not exist (this is OK for first run)"
fi

echo ""
echo "Step 3: Removing any orphaned volumes..."
docker volume prune -f

echo ""
echo "Step 4: Rebuilding containers (no cache)..."
docker-compose build --no-cache

echo ""
echo "Step 5: Starting containers..."
docker-compose up -d

echo ""
echo "Step 6: Waiting for MySQL initialization..."
echo "(This takes about 60 seconds while seed data loads)"

for i in {1..60}; do
    echo -n "."
    sleep 1
done
echo ""

echo ""
echo "Step 7: Verifying database..."
echo "------------------------------"

# Wait a bit more for MySQL to be ready
sleep 5

# Check table structure
echo ""
echo "Problem table structure:"
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "DESCRIBE problem;" 2>/dev/null

# Check problem count
echo ""
echo "Total problems loaded:"
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SELECT COUNT(*) as total FROM problem;" 2>/dev/null

# Check arena breakdown
echo ""
echo "Problems by arena:"
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "
SELECT
    COALESCE(arena, 'NULL') as arena,
    COUNT(*) as count
FROM problem
WHERE module_type = 'ALGO'
GROUP BY arena
ORDER BY arena;" 2>/dev/null

# Check module types
echo ""
echo "Problems by module type:"
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "
SELECT
    module_type,
    COUNT(*) as count
FROM problem
GROUP BY module_type;" 2>/dev/null

echo ""
echo "========================================="
echo "Fix Complete!"
echo "========================================="
echo ""
echo "If you see 400+ total problems above, the database is working correctly."
echo ""
echo "Now:"
echo "1. Open http://localhost:5173 in your browser"
echo "2. Hard refresh (Ctrl+Shift+R or Cmd+Shift+R)"
echo "3. All dropdowns should now show all problems"
echo ""
echo "If you still have issues, check backend logs:"
echo "  docker logs faang-backend"
echo ""
