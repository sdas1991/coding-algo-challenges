package com.faang.coach.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "badges")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Badge {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "badge_type", nullable = false, length = 100)
    private String badgeType; // STREAK_WARRIOR, SPEED_DEMON, BOSS_SLAYER, etc.

    @Column(name = "badge_name", nullable = false, length = 255)
    private String badgeName;

    @Column(name = "description", length = 500)
    private String description;

    @Column(name = "icon_url", length = 255)
    private String iconUrl;

    @Column(name = "earned_at", nullable = false)
    private LocalDateTime earnedAt;

    @Column(name = "metadata", columnDefinition = "TEXT")
    private String metadata; // JSON metadata for additional badge info

    @PrePersist
    protected void onCreate() {
        if (earnedAt == null) {
            earnedAt = LocalDateTime.now();
        }
    }
}
