#!/bin/bash

echo "========================================="
echo "FAANG Algo Coach - Diagnosis & Fix Script"
echo "========================================="
echo ""

echo "Step 1: Checking current database state..."
echo "-------------------------------------------"

# Check if containers are running
if docker ps | grep -q faang-mysql; then
    echo "✓ MySQL container is running"

    # Check if problem table exists
    echo ""
    echo "Checking problem table structure..."
    docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "DESCRIBE problem;" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo ""
        echo "Checking for required columns..."

        # Check for wp_reward column
        if docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SHOW COLUMNS FROM problem LIKE 'wp_reward';" 2>/dev/null | grep -q wp_reward; then
            echo "✓ wp_reward column exists"
        else
            echo "✗ MISSING: wp_reward column - DATABASE NEEDS REBUILD"
        fi

        # Check for hint_cost column
        if docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SHOW COLUMNS FROM problem LIKE 'hint_cost';" 2>/dev/null | grep -q hint_cost; then
            echo "✓ hint_cost column exists"
        else
            echo "✗ MISSING: hint_cost column - DATABASE NEEDS REBUILD"
        fi

        echo ""
        echo "Checking data..."
        docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SELECT COUNT(*) as total_problems FROM problem;" 2>/dev/null

    else
        echo "✗ Problem table does not exist - DATABASE NEEDS INITIALIZATION"
    fi
else
    echo "✗ MySQL container is not running"
fi

echo ""
echo "Step 2: Checking backend logs for errors..."
echo "--------------------------------------------"
docker logs faang-backend 2>&1 | tail -30

echo ""
echo "========================================="
echo "RECOMMENDED FIX"
echo "========================================="
echo ""
echo "The database needs to be completely rebuilt with the new schema."
echo "Run the following commands:"
echo ""
echo "  cd /mnt/d/Projects/coding-algo-challenges/faang-algo-coach"
echo "  docker-compose down -v"
echo "  docker volume rm faang-algo-coach_mysql-data"
echo "  docker-compose build --no-cache"
echo "  docker-compose up -d"
echo "  sleep 60  # Wait for database initialization"
echo ""
echo "Or simply run: ./fix-database.sh"
echo ""
