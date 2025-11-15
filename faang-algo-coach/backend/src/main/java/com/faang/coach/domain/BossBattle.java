package com.faang.coach.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "boss_battles")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BossBattle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "boss_name", nullable = false, length = 255)
    private String bossName;

    @Column(name = "category", nullable = false, length = 100)
    private String category;

    @Column(name = "problem_id", nullable = false)
    private Long problemId;

    @Column(name = "status", nullable = false, length = 50)
    private String status; // LOCKED, AVAILABLE, IN_PROGRESS, DEFEATED, FAILED

    @Column(name = "attempts", nullable = false)
    private Integer attempts = 0;

    @Column(name = "max_attempts", nullable = false)
    private Integer maxAttempts = 3;

    @Column(name = "wp_cost", nullable = false)
    private Integer wpCost;

    @Column(name = "wp_reward")
    private Integer wpReward;

    @Column(name = "started_at")
    private LocalDateTime startedAt;

    @Column(name = "completed_at")
    private LocalDateTime completedAt;

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
