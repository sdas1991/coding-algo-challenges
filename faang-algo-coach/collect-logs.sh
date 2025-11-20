#!/bin/bash

echo "=============================================="
echo "FAANG Algo Coach - Complete Diagnostic Report"
echo "=============================================="
echo ""
echo "Collecting logs and system state..."
echo ""

OUTPUT_FILE="diagnostic-report-$(date +%Y%m%d-%H%M%S).txt"

{
    echo "=========================================="
    echo "1. CONTAINER STATUS"
    echo "=========================================="
    docker ps -a | grep faang
    echo ""

    echo "=========================================="
    echo "2. BACKEND LOGS (Last 100 lines)"
    echo "=========================================="
    docker logs faang-backend --tail 100 2>&1
    echo ""

    echo "=========================================="
    echo "3. MYSQL LOGS (Last 50 lines)"
    echo "=========================================="
    docker logs faang-mysql --tail 50 2>&1
    echo ""

    echo "=========================================="
    echo "4. DATABASE TABLE STRUCTURE"
    echo "=========================================="
    echo "Problem table structure:"
    docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "DESCRIBE problem;" 2>&1
    echo ""

    echo "Checking for required columns:"
    docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SHOW COLUMNS FROM problem WHERE Field IN ('wp_reward', 'hint_cost', 'teach_cost', 'time_limit_ms', 'memory_limit_mb');" 2>&1
    echo ""

    echo "=========================================="
    echo "5. DATABASE CONTENT"
    echo "=========================================="
    echo "Total problems:"
    docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SELECT COUNT(*) as total FROM problem;" 2>&1
    echo ""

    echo "Problems by arena:"
    docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "
    SELECT
        COALESCE(arena, 'NULL/EMPTY') as arena,
        COUNT(*) as count
    FROM problem
    WHERE module_type = 'ALGO'
    GROUP BY arena
    ORDER BY arena;" 2>&1
    echo ""

    echo "Problems by module type:"
    docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "
    SELECT
        module_type,
        COUNT(*) as count
    FROM problem
    GROUP BY module_type;" 2>&1
    echo ""

    echo "Sample problems (first 5):"
    docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "
    SELECT
        id,
        module_type,
        arena,
        title,
        difficulty
    FROM problem
    LIMIT 5;" 2>&1
    echo ""

    echo "=========================================="
    echo "6. API ENDPOINT TEST"
    echo "=========================================="
    echo "Testing backend API directly..."
    echo ""
    echo "Test 1: GET /api/problems/arena/arrays?userId=1"
    curl -s -w "\nHTTP Status: %{http_code}\n" http://localhost:8080/api/problems/arena/arrays?userId=1 2>&1 | head -50
    echo ""

    echo "Test 2: GET /api/problems/module/SQL?userId=1"
    curl -s -w "\nHTTP Status: %{http_code}\n" http://localhost:8080/api/problems/module/SQL?userId=1 2>&1 | head -50
    echo ""

    echo "=========================================="
    echo "7. DOCKER VOLUMES"
    echo "=========================================="
    docker volume ls | grep faang
    echo ""

    echo "=========================================="
    echo "8. DOCKER NETWORK"
    echo "=========================================="
    docker network inspect faang-network 2>&1 | grep -A 5 "Containers"
    echo ""

    echo "=========================================="
    echo "9. FILE CHECKSUMS (to verify latest code)"
    echo "=========================================="
    echo "Schema file:"
    md5sum db/schema.sql
    echo ""
    echo "Problem.java file:"
    md5sum backend/src/main/java/com/faang/coach/domain/Problem.java
    echo ""
    echo "API client file:"
    md5sum frontend/src/api/client.js
    echo ""

    echo "=========================================="
    echo "10. GIT STATUS"
    echo "=========================================="
    git log --oneline -5
    echo ""
    git status
    echo ""

} > "$OUTPUT_FILE" 2>&1

echo ""
echo "=============================================="
echo "Diagnostic report saved to: $OUTPUT_FILE"
echo "=============================================="
echo ""
echo "Please share this file for analysis."
echo ""

# Also display the most critical info immediately
echo "Quick Summary:"
echo "--------------"
echo ""
echo "Backend container status:"
docker ps | grep faang-backend | awk '{print $7}'

echo ""
echo "Database problem count:"
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SELECT COUNT(*) as total FROM problem;" 2>&1 | grep -v total | tail -1

echo ""
echo "Recent backend errors (if any):"
docker logs faang-backend 2>&1 | grep -i error | tail -5

echo ""
echo "Full diagnostic report: $OUTPUT_FILE"
