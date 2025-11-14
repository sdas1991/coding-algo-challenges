-- FAANG Algo Coach Database Schema
-- Offline FAANG Preparation Platform

CREATE DATABASE IF NOT EXISTS faang CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE faang;

-- User Session Table
CREATE TABLE IF NOT EXISTS user_session (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    wisdom_points INT DEFAULT 100,
    last_teach_me_time DATETIME,
    streak_count INT DEFAULT 0,
    last_login DATETIME,
    current_level VARCHAR(50) DEFAULT 'APPRENTICE',
    total_problems_solved INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_last_login (last_login)
) ENGINE=InnoDB;

-- Problem Table
CREATE TABLE IF NOT EXISTS problem (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    module_type VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description_markdown TEXT NOT NULL,
    hints_markdown TEXT,
    solved_java_code MEDIUMTEXT,
    solved_kotlin_code MEDIUMTEXT,
    solution_explanation_markdown TEXT,
    difficulty ENUM('EASY', 'MEDIUM', 'HARD') NOT NULL,
    tags VARCHAR(255),
    arena VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_module_type (module_type),
    INDEX idx_category (category),
    INDEX idx_difficulty (difficulty),
    INDEX idx_arena (arena)
) ENGINE=InnoDB;

-- Test Case Table (for ALGO problems only)
CREATE TABLE IF NOT EXISTS test_case (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    input_data TEXT NOT NULL,
    expected_output TEXT NOT NULL,
    is_hidden BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (problem_id) REFERENCES problem(id) ON DELETE CASCADE,
    INDEX idx_problem_id (problem_id)
) ENGINE=InnoDB;

-- Mastery Table
CREATE TABLE IF NOT EXISTS mastery (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    problem_id BIGINT NOT NULL,
    status VARCHAR(10) DEFAULT 'UNSOLVED',
    attempts INT DEFAULT 0,
    last_submission_time DATETIME,
    first_solved_time DATETIME,
    best_time_ms BIGINT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_user_problem (user_id, problem_id),
    FOREIGN KEY (user_id) REFERENCES user_session(id) ON DELETE CASCADE,
    FOREIGN KEY (problem_id) REFERENCES problem(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- Badge Table
CREATE TABLE IF NOT EXISTS badge (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    badge_name VARCHAR(100) NOT NULL,
    badge_type VARCHAR(50) NOT NULL,
    earned_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_session(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB;

-- Boss Battle Table
CREATE TABLE IF NOT EXISTS boss_battle (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    battle_week VARCHAR(20) NOT NULL,
    score INT DEFAULT 0,
    completed BOOLEAN DEFAULT FALSE,
    completed_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES user_session(id) ON DELETE CASCADE,
    INDEX idx_user_week (user_id, battle_week)
) ENGINE=InnoDB;

-- Practice Playlist Table
CREATE TABLE IF NOT EXISTS practice_playlist (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    problem_ids TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_session(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB;

-- Insert default user session
INSERT INTO user_session (id, wisdom_points, streak_count, last_login, current_level)
VALUES (1, 100, 0, NOW(), 'APPRENTICE');
