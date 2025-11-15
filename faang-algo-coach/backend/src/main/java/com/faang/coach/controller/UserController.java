package com.faang.coach.controller;

import com.faang.coach.domain.UserSession;
import com.faang.coach.dto.UserStatusResponse;
import com.faang.coach.service.WisdomPointService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class UserController {

    private final WisdomPointService wisdomPointService;

    @GetMapping("/status")
    public ResponseEntity<UserStatusResponse> getUserStatus(
            @RequestParam(required = false, defaultValue = "1") Long userId) {

        UserSession session = wisdomPointService.getUserSession(userId);

        // Update streak on each status check
        wisdomPointService.updateStreak(session);

        UserStatusResponse response = UserStatusResponse.builder()
                .userId(session.getId())
                .wisdomPoints(session.getWisdomPoints())
                .streakCount(session.getStreakCount())
                .currentLevel(session.getCurrentLevel())
                .totalProblemsSolved(session.getTotalProblemsSolved())
                .lastLogin(session.getLastLogin())
                .lastTeachMeTime(session.getLastTeachMeTime())
                .canUseTeachMe(wisdomPointService.canUseTeachMe(session))
                .teachMeCooldownSeconds(wisdomPointService.getTeachMeCooldownSeconds(session))
                .build();

        return ResponseEntity.ok(response);
    }

    @PostMapping("/reset")
    public ResponseEntity<UserStatusResponse> resetUserSession(
            @RequestParam(required = false, defaultValue = "1") Long userId) {

        log.info("Resetting user session for userId: {}", userId);
        UserSession session = wisdomPointService.createDefaultSession();

        UserStatusResponse response = UserStatusResponse.builder()
                .userId(session.getId())
                .wisdomPoints(session.getWisdomPoints())
                .streakCount(session.getStreakCount())
                .currentLevel(session.getCurrentLevel())
                .totalProblemsSolved(session.getTotalProblemsSolved())
                .lastLogin(session.getLastLogin())
                .canUseTeachMe(true)
                .teachMeCooldownSeconds(0L)
                .build();

        return ResponseEntity.ok(response);
    }
}
