# Troubleshooting: "Only Two Sum Appears" Issue

## Root Cause
The database volume was not deleted before rebuild, so MySQL seed scripts didn't run. MySQL only executes `/docker-entrypoint-initdb.d/` scripts when initializing a **fresh** database.

## Solution: Complete Fresh Restart

### Option 1: Using the restart script (Recommended)
```bash
cd /mnt/d/Projects/coding-algo-challenges/faang-algo-coach
chmod +x restart-fresh.sh
./restart-fresh.sh
```

### Option 2: Manual steps
```bash
cd /mnt/d/Projects/coding-algo-challenges/faang-algo-coach

# Stop all containers
docker-compose down

# CRITICAL: Remove the database volume
docker volume rm faang-algo-coach_mysql-data

# Rebuild without cache
docker-compose build --no-cache

# Start fresh
docker-compose up -d

# Wait 60 seconds for database initialization
sleep 60
```

## Verify Database Loaded Correctly

```bash
# Check total problem count (should be 400+)
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SELECT COUNT(*) as total FROM problem;"

# Check problems per arena
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SELECT arena, COUNT(*) FROM problem WHERE module_type='ALGO' GROUP BY arena;"

# Check module types
docker exec faang-mysql mysql -ufaang -pfaangpass faang -e "SELECT module_type, COUNT(*) FROM problem GROUP BY module_type;"
```

Expected output:
- Total problems: 400+
- ARRAYS: 15 problems
- STRINGS: 27 problems (12 + 15 advanced)
- TREES: 29 problems (14 + 15 advanced)
- GRAPHS: 27 problems
- DYNAMIC_PROGRAMMING: 33 problems
- etc.

## If Still Not Working

### 1. Check MySQL Initialization Logs
```bash
docker logs faang-mysql 2>&1 | grep -i error
docker logs faang-mysql 2>&1 | grep -i "seed"
```

### 2. Check Backend Logs
```bash
docker logs faang-backend 2>&1 | tail -50
```

### 3. Test API Directly
```bash
# Test if backend is responding
curl http://localhost:8080/api/problems/arena/arrays?userId=1

# Should return JSON array with 15 problems, not empty array
```

### 4. Clear Browser Cache
- Hard refresh: `Ctrl+Shift+R` (Windows/Linux) or `Cmd+Shift+R` (Mac)
- Or open in incognito/private mode

### 5. Check Frontend API Calls
- Open browser DevTools (F12)
- Go to Network tab
- Click on a widget
- Check the API request to `/api/problems/arena/...`
- If it returns empty array `[]`, the database didn't load
- If it returns error, check CORS or backend issues

## Common Issues

### Issue: Volume doesn't delete
```bash
# Force remove
docker-compose down -v
docker volume ls | grep mysql
docker volume rm $(docker volume ls -q | grep mysql)
```

### Issue: Port conflicts
```bash
# Check if ports are in use
netstat -ano | findstr :3306
netstat -ano | findstr :8080
netstat -ano | findstr :5173
```

### Issue: MySQL not ready when backend starts
```bash
# Increase healthcheck retries in docker-compose.yml
healthcheck:
  retries: 10  # increase from 5
```

## Nuclear Option: Complete Reset

```bash
# Stop everything
docker-compose down -v

# Remove all related containers
docker ps -a | grep faang | awk '{print $1}' | xargs docker rm

# Remove all related volumes
docker volume ls | grep faang | awk '{print $2}' | xargs docker volume rm

# Remove all related images
docker images | grep faang | awk '{print $3}' | xargs docker rmi

# Start fresh
docker-compose up --build
```
