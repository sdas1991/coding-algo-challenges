package com.faang.coach.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "mastery", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"user_id", "problem_id"})
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Mastery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "problem_id", nullable = false)
    private Long problemId;

    @Column(name = "status", nullable = false, length = 50)
    private String status; // UNSOLVED, HINT_USED, TEACH_USED, SOLVED, MASTERED

    @Column(name = "attempts", nullable = false)
    private Integer attempts = 0;

    @Column(name = "last_submission_time")
    private LocalDateTime lastSubmissionTime;

    @Column(name = "first_solved_time")
    private LocalDateTime firstSolvedTime;

    @Column(name = "best_time_ms")
    private Long bestTimeMs;

    @Column(name = "best_memory_mb")
    private Integer bestMemoryMb;

    @Column(name = "hints_used", nullable = false)
    private Integer hintsUsed = 0;

    @Column(name = "teach_used", nullable = false)
    private Boolean teachUsed = false;

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
