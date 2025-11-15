package com.faang.coach.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "problems")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Problem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "module_type", nullable = false, length = 50)
    private String moduleType; // ALGO, SQL, SYSTEM_DESIGN, MCQ

    @Column(name = "category", nullable = false, length = 100)
    private String category; // arrays, strings, etc.

    @Column(name = "arena", length = 50)
    private String arena; // speed_run, boss_battle, practice

    @Column(name = "title", nullable = false, length = 255)
    private String title;

    @Column(name = "description_markdown", columnDefinition = "TEXT")
    private String descriptionMarkdown;

    @Column(name = "hints_markdown", columnDefinition = "TEXT")
    private String hintsMarkdown;

    @Column(name = "solved_java_code", columnDefinition = "TEXT")
    private String solvedJavaCode;

    @Column(name = "solved_kotlin_code", columnDefinition = "TEXT")
    private String solvedKotlinCode;

    @Column(name = "solution_explanation_markdown", columnDefinition = "TEXT")
    private String solutionExplanationMarkdown;

    @Column(name = "difficulty", nullable = false, length = 20)
    private String difficulty; // EASY, MEDIUM, HARD, NIGHTMARE

    @Column(name = "tags", length = 500)
    private String tags; // Comma-separated tags

    @Column(name = "time_limit_ms")
    private Integer timeLimitMs = 5000;

    @Column(name = "memory_limit_mb")
    private Integer memoryLimitMb = 256;

    @Column(name = "wp_reward", nullable = false)
    private Integer wpReward = 10;

    @Column(name = "hint_cost")
    private Integer hintCost = 5;

    @Column(name = "teach_cost")
    private Integer teachCost = 15;

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
