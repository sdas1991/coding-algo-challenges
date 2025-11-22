package com.faang.coach.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_session")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserSession {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "wisdom_points", nullable = false)
    private Integer wisdomPoints = 0;

    @Column(name = "last_teach_me_time")
    private LocalDateTime lastTeachMeTime;

    @Column(name = "streak_count", nullable = false)
    private Integer streakCount = 0;

    @Column(name = "last_login")
    private LocalDateTime lastLogin;

    @Column(name = "current_level", nullable = false)
    private Integer currentLevel = 1;

    @Column(name = "total_problems_solved", nullable = false)
    private Integer totalProblemsSolved = 0;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
