#!/bin/bash

echo "================================"
echo "FAANG Algo Coach - Fresh Restart"
echo "================================"
echo ""

echo "Step 1: Stopping all containers..."
docker-compose down

echo ""
echo "Step 2: Removing database volume (THIS CLEARS ALL DATA)..."
docker volume rm faang-algo-coach_mysql-data 2>/dev/null || echo "Volume already removed or doesn't exist"

echo ""
echo "Step 3: Rebuilding containers..."
docker-compose build --no-cache

echo ""
echo "Step 4: Starting containers..."
docker-compose up -d

echo ""
echo "Step 5: Waiting for MySQL initialization (60 seconds)..."
sleep 60

echo ""
echo "Step 6: Checking database contents..."
echo "-----------------------------------"

docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SELECT COUNT(*) as total_problems FROM problem;" 2>/dev/null

echo ""
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "
SELECT
    arena,
    COUNT(*) as count
FROM problem
WHERE module_type = 'ALGO'
GROUP BY arena
ORDER BY arena;" 2>/dev/null

echo ""
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "
SELECT
    module_type,
    COUNT(*) as count
FROM problem
GROUP BY module_type;" 2>/dev/null

echo ""
echo "================================"
echo "Setup complete!"
echo "================================"
echo "Access the application at: http://localhost:5173"
echo ""
echo "If you still see issues, check logs with:"
echo "  docker-compose logs backend-service"
echo "  docker-compose logs mysql-db"
