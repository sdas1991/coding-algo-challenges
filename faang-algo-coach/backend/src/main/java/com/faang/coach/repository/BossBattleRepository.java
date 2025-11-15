package com.faang.coach.repository;

import com.faang.coach.domain.BossBattle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BossBattleRepository extends JpaRepository<BossBattle, Long> {

    List<BossBattle> findByUserId(Long userId);

    List<BossBattle> findByUserIdAndStatus(Long userId, String status);

    Optional<BossBattle> findByUserIdAndProblemId(Long userId, Long problemId);

    List<BossBattle> findByUserIdAndCategory(Long userId, String category);
}
