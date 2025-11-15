package com.faang.coach.repository;

import com.faang.coach.domain.Badge;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BadgeRepository extends JpaRepository<Badge, Long> {

    List<Badge> findByUserId(Long userId);

    List<Badge> findByUserIdAndBadgeType(Long userId, String badgeType);

    boolean existsByUserIdAndBadgeType(Long userId, String badgeType);
}
