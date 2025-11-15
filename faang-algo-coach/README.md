# FAANG Algo Coach 🚀

An **offline-first, gamified FAANG algorithm preparation platform** designed to help aspiring software engineers master coding interviews through interactive problem-solving and comprehensive learning resources.

## Overview 📚

FAANG Algo Coach is a comprehensive platform for FAANG (Facebook, Apple, Amazon, Netflix, Google) interview preparation. It combines an extensive problem library with intelligent gamification to keep learners engaged and motivated throughout their preparation journey.

### Key Highlights

- **500+ Algorithm Problems** - Curated problems from all major FAANG companies
- **Offline-First Architecture** - Access problems and solutions without constant internet
- **Gamification System** - Wisdom Points, Levels, Badges, Streaks, and Boss Battles
- **Multiple Module Types** - Data Structures, Algorithms, System Design, Behavioral
- **Progressive Difficulty** - Easy, Medium, and Hard problems with clear progression paths
- **Code Solutions** - Multiple language implementations (Java, Kotlin)
- **Interactive Learning** - Hints, explanations, and test cases for every problem

## Features ✨

### Problem Library
- **500+ Curated Problems** across all difficulty levels
- **Multiple Modules**: Data Structures, Algorithms, System Design, Behavioral
- **Rich Content**: Detailed descriptions, hints, solutions, and explanations
- **Test Cases**: Automated validation for algorithm problems
- **Multi-language Support**: Java and Kotlin implementations

### Gamification System
- **Wisdom Points (WP)**: Earn points for solving problems and completing daily streaks
  - First solve: +25 WP
  - Additional attempts: +5 WP
  - Daily streak bonus: +10 WP per day

- **Level Progression**: Rise through ranks as you earn WP
  - APPRENTICE (0 WP) → NOVICE (100 WP) → DEVELOPER (500 WP)
  - EXPERT (1500 WP) → MASTER (3000 WP) → LEGEND (5000+ WP)

- **Badge System**: Earn achievements for milestones
  - Problem-solving badges (10, 50, 100 problems solved)
  - Difficulty mastery badges (solved 5 hard problems)
  - Speed badges (solve 3 in 24 hours)
  - Consistency badges (7-day streak)

- **Streak Counter**: Track consecutive daily practice sessions
  - Motivates consistent learning
  - Bonus WP multiplier for long streaks

- **Boss Battles**: Weekly challenges with escalating difficulty
  - Compete against algorithmic "bosses"
  - Unlock special badges upon completion
  - Leaderboard rankings

### Learning Resources
- **Interactive Hints**: Progressive hints for each problem
- **Detailed Solutions**: Step-by-step problem explanations
- **Code Examples**: Reference implementations in Java and Kotlin
- **Test Case Validation**: Verify solutions against comprehensive test suites
- **Practice Playlists**: Curated problem sequences by topic

## Architecture Overview 🏗️

```
┌─────────────────────────────────────────────────────────────┐
│                        FAANG Algo Coach                      │
└─────────────────────────────────────────────────────────────┘
                              │
                    ┌─────────┼─────────┐
                    │         │         │
                    ▼         ▼         ▼
            ┌──────────┐ ┌──────────┐ ┌──────────┐
            │ Frontend │ │ Backend  │ │ Database │
            │ (Vue.js) │ │(Spring   │ │ (MySQL)  │
            │ + Vite   │ │  Boot)   │ │          │
            └──────────┘ └──────────┘ └──────────┘
                │            │            │
                │            │            │
            nginx            │       Seeding &
            (Reverse         │       Migrations
             Proxy)          │
                │            │
                └─────┬──────┘
                      │
                Docker Network
                (faang-network)
```

### Technology Stack

**Backend**
- **Framework**: Spring Boot 3.x
- **Language**: Java 21
- **Build Tool**: Maven
- **ORM**: Hibernate/JPA
- **Database**: MySQL 8.0

**Frontend**
- **Framework**: Vue.js 3
- **Build Tool**: Vite
- **Package Manager**: npm
- **Styling**: CSS with Tailwind
- **HTTP Client**: Axios

**Infrastructure**
- **Containerization**: Docker & Docker Compose
- **Web Server**: Nginx (Alpine)
- **Container Base**: Alpine Linux (optimized size)

## Prerequisites 📋

### Minimum Requirements
- **Docker**: 20.10+
- **Docker Compose**: 1.29+
- **Disk Space**: 2GB free
- **RAM**: 4GB minimum (8GB recommended)

### Optional (for local development)
- **Java**: JDK 21
- **Node.js**: 20.x LTS
- **Maven**: 3.8.x
- **Git**: 2.30+

## Quick Start 🚀

### Option 1: Docker Compose (Recommended)

```bash
# Navigate to project root
cd /home/user/coding-algo-challenges/faang-algo-coach

# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

**Service URLs:**
- Frontend: http://localhost:5173
- Backend API: http://localhost:8080
- Database: localhost:3306

### Option 2: Development Environment

```bash
# Backend Setup
cd backend
./mvnw clean install
./mvnw spring-boot:run

# Frontend Setup (in another terminal)
cd frontend
npm install
npm run dev
```

## Project Structure 📁

```
faang-algo-coach/
├── backend/                          # Spring Boot Backend
│   ├── src/
│   │   ├── main/java/com/faang/
│   │   │   ├── controller/          # REST API Endpoints
│   │   │   ├── service/             # Business Logic
│   │   │   ├── repository/          # Data Access Layer
│   │   │   ├── model/               # Entity Classes
│   │   │   ├── dto/                 # Data Transfer Objects
│   │   │   ├── config/              # Spring Configuration
│   │   │   ├── exception/           # Custom Exceptions
│   │   │   └── util/                # Utility Classes
│   │   └── resources/
│   │       ├── application.yml      # App Configuration
│   │       └── application-dev.yml  # Dev Configuration
│   ├── pom.xml                       # Maven Dependencies
│   ├── mvnw                          # Maven Wrapper
│   └── Dockerfile                    # Container Definition
│
├── frontend/                         # Vue.js Frontend
│   ├── src/
│   │   ├── components/              # Reusable UI Components
│   │   ├── views/                   # Page Components
│   │   ├── stores/                  # Pinia State Management
│   │   ├── router/                  # Vue Router Configuration
│   │   ├── assets/                  # Static Resources
│   │   ├── App.vue                  # Root Component
│   │   └── main.js                  # Entry Point
│   ├── public/                       # Public Assets
│   ├── package.json                  # NPM Dependencies
│   ├── vite.config.js               # Vite Configuration
│   ├── nginx.conf                    # Nginx Configuration
│   ├── nginx/
│   │   └── default.conf             # Nginx Virtual Host Config
│   └── Dockerfile                    # Container Definition
│
├── db/                              # Database
│   ├── schema.sql                   # Table Definitions
│   ├── seed/                        # Seed Data
│   │   ├── 01_users.sql            # User Data
│   │   ├── 02_problems.sql         # Problem Library
│   │   ├── 03_test_cases.sql       # Test Cases
│   │   └── ...
│   └── migrations/                  # (Future) Schema Migrations
│
├── docker/                          # Docker Configuration
│   └── mysql/
│       └── my.cnf                   # MySQL Configuration
│
├── docker-compose.yml               # Multi-container Orchestration
└── README.md                         # This File
```

## Database Schema Overview 🗄️

### Core Tables

**user_session** - User account and gamification data
```
├── id (BIGINT, PK)
├── wisdom_points (INT) - Total WP accumulated
├── current_level (VARCHAR) - APPRENTICE, NOVICE, etc.
├── streak_count (INT) - Consecutive days of activity
├── total_problems_solved (INT)
├── last_login (DATETIME)
└── timestamps
```

**problem** - Algorithm and design problems
```
├── id (BIGINT, PK)
├── module_type (VARCHAR) - ALGO, DS, SYSTEM_DESIGN, BEHAVIORAL
├── category (VARCHAR) - linked list, tree, graph, etc.
├── title (VARCHAR) - Problem title
├── description_markdown (TEXT) - Detailed description
├── hints_markdown (TEXT) - Progressive hints
├── solved_java_code (MEDIUMTEXT) - Reference solution
├── solved_kotlin_code (MEDIUMTEXT) - Alternative solution
├── solution_explanation_markdown (TEXT) - Step-by-step explanation
├── difficulty (ENUM) - EASY, MEDIUM, HARD
├── tags (VARCHAR) - search/filter tags
└── arena (VARCHAR) - problem set/collection
```

**test_case** - Validation test cases for problems
```
├── id (BIGINT, PK)
├── problem_id (BIGINT, FK)
├── input_data (TEXT) - Test input
├── expected_output (TEXT) - Expected output
└── is_hidden (BOOLEAN) - Hidden from users pre-submission
```

**mastery** - User problem-solving progress
```
├── id (BIGINT, PK)
├── user_id (BIGINT, FK)
├── problem_id (BIGINT, FK)
├── status (VARCHAR) - UNSOLVED, SOLVED, MASTERED
├── attempts (INT) - Number of submission attempts
├── first_solved_time (DATETIME) - When first solved
├── best_time_ms (BIGINT) - Fastest solve time
└── timestamps
```

**badge** - User achievements
```
├── id (BIGINT, PK)
├── user_id (BIGINT, FK)
├── badge_name (VARCHAR) - Badge identifier
├── badge_type (VARCHAR) - MILESTONE, DIFFICULTY, SPEED, etc.
└── earned_at (DATETIME)
```

**boss_battle** - Weekly competitive challenges
```
├── id (BIGINT, PK)
├── user_id (BIGINT, FK)
├── battle_week (VARCHAR) - Week identifier
├── score (INT) - Points earned
├── completed (BOOLEAN)
└── completed_at (DATETIME)
```

**practice_playlist** - Custom problem collections
```
├── id (BIGINT, PK)
├── user_id (BIGINT, FK)
├── playlist_name (VARCHAR) - User-defined name
├── problem_ids (TEXT) - Comma-separated problem IDs
└── timestamps
```

## API Endpoints Summary 🔌

### User Management
- `GET /api/users/profile` - Get current user profile
- `POST /api/users/login` - User authentication
- `PUT /api/users/profile` - Update profile
- `GET /api/users/{userId}/stats` - User statistics

### Problems
- `GET /api/problems` - List all problems (with filters)
- `GET /api/problems/{problemId}` - Get problem details
- `GET /api/problems/category/{category}` - Problems by category
- `GET /api/problems/difficulty/{level}` - Problems by difficulty
- `GET /api/problems/module/{moduleType}` - Problems by module

### Solutions & Test Cases
- `GET /api/problems/{problemId}/hints` - Get hints for a problem
- `GET /api/problems/{problemId}/solution` - Get solution explanation
- `POST /api/submissions/validate` - Validate solution code
- `GET /api/problems/{problemId}/test-cases` - Get test cases

### Gamification
- `GET /api/users/{userId}/badges` - User's earned badges
- `POST /api/gamification/solve-problem` - Record problem solve
- `GET /api/gamification/leaderboard` - Global leaderboard
- `GET /api/gamification/leaderboard/weekly` - Weekly standings
- `GET /api/boss-battles/{week}` - Current boss battle details
- `POST /api/boss-battles/{week}/submit` - Submit boss battle

### Mastery Tracking
- `GET /api/mastery/user/{userId}` - User mastery overview
- `GET /api/mastery/user/{userId}/by-difficulty` - Solved problems by difficulty
- `GET /api/mastery/user/{userId}/stats` - Detailed mastery statistics

### Practice Playlists
- `GET /api/playlists/user/{userId}` - User's playlists
- `POST /api/playlists` - Create new playlist
- `PUT /api/playlists/{playlistId}` - Update playlist
- `DELETE /api/playlists/{playlistId}` - Delete playlist

## Frontend Routes 🗺️

### Main Navigation
- `/` - Dashboard/Home
- `/explore` - Problem browser with filters
- `/problems/:id` - Problem detail view
- `/problems/:id/solve` - Interactive problem solver
- `/solutions/:id` - Solution explanation

### User Section
- `/profile` - User profile and settings
- `/progress` - Learning progress dashboard
- `/badges` - Badge collection
- `/leaderboard` - Global rankings

### Learning Paths
- `/paths` - Predefined learning paths
- `/playlists` - Custom practice playlists
- `/playlists/:id` - Playlist details and problems

### Competitive
- `/boss-battles` - Current/upcoming boss battles
- `/boss-battles/:week` - Battle details
- `/competitions` - Live competitions
- `/achievements` - Achievement showcase

### Administrative
- `/admin/problems` - Manage problems (admin only)
- `/admin/users` - User management (admin only)

## Gamification System Deep Dive 🎮

### Wisdom Points (WP) Economy

**Earning WP:**
```
First solve of a problem:           +25 WP
Additional attempts on same problem: +5 WP per solve
Daily streak bonus (5+ days):        +10 WP
Weekly completion bonus:             +50 WP
Boss battle victory:                 +100 WP
```

**Level Thresholds:**
```
APPRENTICE:  0 - 99 WP       (Starting level)
NOVICE:      100 - 499 WP    (5+ problems)
DEVELOPER:   500 - 1499 WP   (25+ problems)
EXPERT:      1500 - 2999 WP  (50+ problems)
MASTER:      3000 - 4999 WP  (100+ problems)
LEGEND:      5000+ WP        (200+ problems)
```

### Streak System

**How Streaks Work:**
1. Login/solve problem each day to maintain streak
2. Streak resets if no activity for 24+ hours
3. Streaks provide bonus WP multiplier (1.0x to 2.0x)
4. Special badges awarded for 7, 30, 90, 365-day streaks

### Badge Categories

**Milestone Badges:**
- Bronze Badge: Solve 10 problems
- Silver Badge: Solve 50 problems
- Gold Badge: Solve 100 problems
- Platinum Badge: Solve 250 problems
- Diamond Badge: Solve 500 problems

**Difficulty Mastery Badges:**
- Easy Master: Solve 10 easy problems
- Medium Expert: Solve 5 medium problems
- Hard Slayer: Solve 3 hard problems
- All-Around Warrior: Solved problems in all difficulties

**Speed Badges:**
- Speed Runner: Solve 3 problems in 24 hours
- Lightning: Solve 5 in 24 hours
- Blitz Master: Solve 10 in 24 hours

**Streak Badges:**
- Consistent: 7-day streak
- Dedicated: 30-day streak
- Committed: 90-day streak
- Legendary: 365-day streak

**Category Masters:**
- Arrays Wizard
- Linked List Sage
- Tree Traverser
- Graph Navigator
- DP Solver
- String Manipulator

### Boss Battles

**Weekly Structure:**
- New boss battle every Monday
- 5 increasingly difficult problems
- Each correct solution: +20 points
- Bonus for speed (solve all by Friday): +50 points
- Top 100 winners get badges and WP bonus

**Boss Types:**
- Algorithm Masters (focused on specific algorithms)
- Data Structure Challenges (combined DS concepts)
- Timed Trials (speed-focused)
- Themed Battles (all problems on one topic)

## Development Guide 🛠️

### Backend Development

**Project Structure:**
```
backend/src/main/java/com/faang/
├── FaangAlgoCoachApplication.java     # Entry point
├── controller/
│   ├── ProblemController.java         # Problem endpoints
│   ├── UserController.java            # User endpoints
│   ├── GamificationController.java    # Gamification logic
│   └── MasteryController.java         # Mastery endpoints
├── service/
│   ├── ProblemService.java            # Problem business logic
│   ├── UserService.java               # User operations
│   ├── GamificationService.java       # Gamification logic
│   ├── MasteryService.java            # Progress tracking
│   └── BadgeService.java              # Badge management
├── repository/
│   ├── ProblemRepository.java         # Problem queries
│   ├── UserSessionRepository.java     # User queries
│   ├── MasteryRepository.java         # Mastery queries
│   └── BadgeRepository.java           # Badge queries
├── model/
│   ├── Problem.java
│   ├── UserSession.java
│   ├── Mastery.java
│   ├── Badge.java
│   └── TestCase.java
├── dto/
│   ├── ProblemDTO.java
│   ├── UserDTO.java
│   └── MasteryDTO.java
├── exception/
│   ├── ProblemNotFoundException.java
│   ├── UserNotFoundException.java
│   └── InvalidSolutionException.java
├── config/
│   ├── WebConfig.java                # CORS, interceptors
│   ├── JpaConfig.java                # JPA/Hibernate config
│   └── SecurityConfig.java           # Spring Security config
└── util/
    ├── CodeValidator.java            # Solution validation
    └── WisdomPointCalculator.java    # WP calculation
```

**Running Tests:**
```bash
# Unit tests
./mvnw test

# Integration tests
./mvnw verify

# Test coverage
./mvnw jacoco:report
```

### Frontend Development

**Component Structure:**
```
frontend/src/
├── components/
│   ├── ProblemBrowser.vue          # Problem list/filter
│   ├── ProblemDetail.vue           # Problem view
│   ├── CodeEditor.vue              # Code input
│   ├── GamificationWidget.vue      # WP/level display
│   ├── BadgeShowcase.vue           # Badge display
│   └── Navigation.vue              # Menu/routing
├── views/
│   ├── HomePage.vue                # Dashboard
│   ├── ExploreView.vue             # Browse problems
│   ├── ProfileView.vue             # User profile
│   └── LeaderboardView.vue         # Rankings
├── stores/
│   ├── userStore.js                # User state (Pinia)
│   ├── problemStore.js             # Problem data
│   ├── masteryStore.js             # Progress data
│   └── gamificationStore.js        # Gamification state
└── router/
    └── index.js                    # Route definitions
```

**Development Commands:**
```bash
# Start dev server (hot reload)
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Run linter
npm run lint

# Format code
npm run format
```

### Database Management

**Seed Data:**
```bash
# Automatic (via Docker)
docker-compose up

# Manual (if needed)
docker exec faang-mysql mysql -u faang -pfaangpass faang < db/schema.sql
docker exec faang-mysql mysql -u faang -pfaangpass faang < db/seed/*.sql
```

**Database Access:**
```bash
# Interactive MySQL prompt
docker exec -it faang-mysql mysql -u faang -pfaangpass faang

# Backup database
docker exec faang-mysql mysqldump -u faang -pfaangpass faang > backup.sql

# Restore from backup
docker exec -i faang-mysql mysql -u faang -pfaangpass faang < backup.sql
```

## Building & Deployment 🚀

### Building Docker Images

```bash
# Build all services
docker-compose build

# Build specific service
docker-compose build backend
docker-compose build frontend

# Build with custom tag
docker build -t my-registry/faang-backend:1.0 ./backend
docker build -t my-registry/faang-frontend:1.0 ./frontend
```

### Production Deployment

**Environment Variables:**
```bash
# Backend (application.yml or .env)
SPRING_DATASOURCE_URL=jdbc:mysql://mysql-db:3306/faang
SPRING_DATASOURCE_USERNAME=faang
SPRING_DATASOURCE_PASSWORD=<secure-password>
SERVER_PORT=8080

# Frontend (.env.production)
VITE_API_URL=https://api.yourdomain.com
```

**Docker Compose Production:**
```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Scale services (if using Docker Swarm)
docker-compose up --scale backend=3

# Health check
curl http://localhost:8080/actuator/health
curl http://localhost:5173/
```

## Troubleshooting 🔧

### Common Issues

**Issue: "Connection refused" error for database**
```bash
# Solution: Check if MySQL is healthy
docker-compose ps
docker-compose logs mysql-db

# Restart database
docker-compose restart mysql-db

# Wait for it to be ready before restarting backend
docker-compose up -d
```

**Issue: Frontend can't reach backend API**
```bash
# Check if backend is running
docker-compose logs backend-service

# Verify backend URL in frontend
docker-compose exec frontend-service cat /usr/share/nginx/html/index.html | grep -i api

# Test backend connectivity from frontend container
docker-compose exec frontend-service wget -O- http://backend-service:8080/health
```

**Issue: Port already in use**
```bash
# Find process using port
lsof -i :8080  # Backend
lsof -i :5173  # Frontend
lsof -i :3306  # Database

# Kill process or change port in docker-compose.yml
docker-compose down  # Stop all containers first
```

**Issue: Maven dependency download fails**
```bash
# Clear Maven cache
docker-compose build --no-cache backend

# Or manually
rm -rf ~/.m2/repository
docker-compose up --build
```

**Issue: JavaScript/CSS files not loading**
```bash
# Rebuild frontend
docker-compose build --no-cache frontend

# Check nginx logs
docker-compose logs frontend-service

# Verify build output exists
docker-compose exec frontend-service ls -la /usr/share/nginx/html/
```

**Issue: Database migrations fail**
```bash
# Check database logs
docker-compose logs mysql-db

# Verify schema.sql syntax
docker-compose exec mysql-db mysql -u faang -pfaangpass faang < /path/to/schema.sql

# Reset database (⚠️ WARNING: Deletes all data)
docker-compose down -v
docker-compose up
```

### Performance Optimization

**Backend:**
- Use database connection pooling (HikariCP)
- Add caching layer (Redis) for leaderboard data
- Index frequently queried columns
- Implement pagination for problem lists

**Frontend:**
- Enable gzip compression in nginx.conf (already done)
- Lazy load routes and heavy components
- Optimize bundle size with code splitting
- Use service workers for offline caching

**Database:**
- Regular index maintenance
- Monitor slow query log
- Archive old user session data
- Optimize join queries in problem listing

## Monitoring & Logging 📊

### Backend Health Monitoring

```bash
# Health endpoint
curl http://localhost:8080/actuator/health

# Detailed metrics
curl http://localhost:8080/actuator/metrics

# Application info
curl http://localhost:8080/actuator/info
```

### View Logs

```bash
# All services
docker-compose logs

# Specific service
docker-compose logs backend-service
docker-compose logs frontend-service
docker-compose logs mysql-db

# Follow logs in real-time
docker-compose logs -f backend-service

# Last 100 lines
docker-compose logs --tail=100 backend-service
```

### Container Resource Usage

```bash
# View CPU, memory, network usage
docker stats

# Detailed inspection
docker inspect faang-backend
```

## Contributing 👥

1. Create a feature branch from `main`
2. Make your changes with clear commits
3. Write/update tests
4. Submit a pull request with description
5. Ensure all tests pass and CI/CD checks succeed

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Happy Coding!** 🎉 Master FAANG interviews with the Algo Coach!
