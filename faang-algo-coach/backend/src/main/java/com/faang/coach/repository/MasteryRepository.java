package com.faang.coach.repository;

import com.faang.coach.domain.Mastery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MasteryRepository extends JpaRepository<Mastery, Long> {

    Optional<Mastery> findByUserIdAndProblemId(Long userId, Long problemId);

    List<Mastery> findByUserId(Long userId);

    List<Mastery> findByUserIdAndStatus(Long userId, String status);

    @Query("SELECT m FROM Mastery m JOIN Problem p ON m.problemId = p.id " +
           "WHERE m.userId = :userId AND p.category = :category AND m.status IN ('SOLVED', 'MASTERED')")
    List<Mastery> findSolvedByUserIdAndCategory(@Param("userId") Long userId, @Param("category") String category);

    long countByUserIdAndStatus(Long userId, String status);
}
