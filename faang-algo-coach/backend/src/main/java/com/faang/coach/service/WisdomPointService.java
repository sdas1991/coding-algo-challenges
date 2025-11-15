package com.faang.coach.service;

import com.faang.coach.domain.UserSession;
import com.faang.coach.repository.UserSessionRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class WisdomPointService {

    private static final int DAILY_LOGIN_BONUS = 10;
    private static final int TEACH_ME_COOLDOWN_HOURS = 24;
    private static final int STREAK_BONUS_THRESHOLD = 7;
    private static final int STREAK_BONUS_WP = 50;

    private final UserSessionRepository userSessionRepository;

    @Transactional
    public UserSession getUserSession(Long userId) {
        // For demo purposes, we'll use the first session or create one
        return userSessionRepository.findFirstByOrderByIdAsc()
                .orElseGet(() -> createDefaultSession());
    }

    @Transactional
    public UserSession createDefaultSession() {
        UserSession session = UserSession.builder()
                .wisdomPoints(100)
                .streakCount(0)
                .currentLevel(1)
                .totalProblemsSolved(0)
                .lastLogin(LocalDateTime.now())
                .build();
        return userSessionRepository.save(session);
    }

    @Transactional
    public void addWisdomPoints(UserSession session, int points) {
        session.setWisdomPoints(session.getWisdomPoints() + points);
        userSessionRepository.save(session);
        log.info("Added {} WP to user session {}. New total: {}", points, session.getId(), session.getWisdomPoints());
    }

    @Transactional
    public boolean deductWisdomPoints(UserSession session, int points) {
        if (session.getWisdomPoints() < points) {
            log.warn("Insufficient WP. Required: {}, Available: {}", points, session.getWisdomPoints());
            return false;
        }
        session.setWisdomPoints(session.getWisdomPoints() - points);
        userSessionRepository.save(session);
        log.info("Deducted {} WP from user session {}. Remaining: {}", points, session.getId(), session.getWisdomPoints());
        return true;
    }

    @Transactional
    public void updateStreak(UserSession session) {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime lastLogin = session.getLastLogin();

        if (lastLogin == null) {
            // First login
            session.setStreakCount(1);
            session.setLastLogin(now);
        } else {
            long hoursSinceLastLogin = Duration.between(lastLogin, now).toHours();

            if (hoursSinceLastLogin < 24) {
                // Same day, no change
                return;
            } else if (hoursSinceLastLogin < 48) {
                // Next day, increment streak
                session.setStreakCount(session.getStreakCount() + 1);
                session.setLastLogin(now);

                // Award daily login bonus
                addWisdomPoints(session, DAILY_LOGIN_BONUS);

                // Check for streak milestone bonus
                if (session.getStreakCount() % STREAK_BONUS_THRESHOLD == 0) {
                    addWisdomPoints(session, STREAK_BONUS_WP);
                    log.info("Streak milestone reached! Awarded {} bonus WP", STREAK_BONUS_WP);
                }
            } else {
                // Streak broken
                log.info("Streak broken for user session {}", session.getId());
                session.setStreakCount(1);
                session.setLastLogin(now);
            }
        }

        userSessionRepository.save(session);
    }

    public boolean canUseTeachMe(UserSession session) {
        if (session.getLastTeachMeTime() == null) {
            return true;
        }

        long hoursSinceLastTeach = Duration.between(session.getLastTeachMeTime(), LocalDateTime.now()).toHours();
        return hoursSinceLastTeach >= TEACH_ME_COOLDOWN_HOURS;
    }

    public long getTeachMeCooldownSeconds(UserSession session) {
        if (session.getLastTeachMeTime() == null) {
            return 0;
        }

        LocalDateTime cooldownEnd = session.getLastTeachMeTime().plusHours(TEACH_ME_COOLDOWN_HOURS);
        long secondsRemaining = Duration.between(LocalDateTime.now(), cooldownEnd).toSeconds();
        return Math.max(0, secondsRemaining);
    }

    @Transactional
    public void recordTeachMeUsage(UserSession session) {
        session.setLastTeachMeTime(LocalDateTime.now());
        userSessionRepository.save(session);
    }

    @Transactional
    public void incrementProblemsSolved(UserSession session) {
        session.setTotalProblemsSolved(session.getTotalProblemsSolved() + 1);

        // Level up logic (simple: every 10 problems = 1 level)
        int newLevel = (session.getTotalProblemsSolved() / 10) + 1;
        if (newLevel > session.getCurrentLevel()) {
            session.setCurrentLevel(newLevel);
            log.info("User leveled up to level {}!", newLevel);
        }

        userSessionRepository.save(session);
    }
}
