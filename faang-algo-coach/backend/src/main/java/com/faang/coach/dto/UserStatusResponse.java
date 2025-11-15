package com.faang.coach.dto;

import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserStatusResponse {

    private Long userId;
    private Integer wisdomPoints;
    private Integer streakCount;
    private Integer currentLevel;
    private Integer totalProblemsSolved;
    private LocalDateTime lastLogin;
    private LocalDateTime lastTeachMeTime;
    private Boolean canUseTeachMe;
    private Long teachMeCooldownSeconds;
}
