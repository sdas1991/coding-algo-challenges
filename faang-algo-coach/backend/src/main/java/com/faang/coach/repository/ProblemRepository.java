package com.faang.coach.repository;

import com.faang.coach.domain.Problem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProblemRepository extends JpaRepository<Problem, Long> {

    List<Problem> findByCategory(String category);

    List<Problem> findByModuleType(String moduleType);

    List<Problem> findByCategoryAndModuleType(String category, String moduleType);

    @Query("SELECT p FROM Problem p WHERE p.moduleType = :moduleType " +
           "AND p.id NOT IN (SELECT m.problemId FROM Mastery m WHERE m.userId = :userId AND m.status IN ('SOLVED', 'MASTERED')) " +
           "ORDER BY p.difficulty, p.id")
    List<Problem> findUnsolvedByModuleTypeAndUserId(@Param("moduleType") String moduleType, @Param("userId") Long userId);

    Optional<Problem> findByIdAndArena(Long id, String arena);

    List<Problem> findByArena(String arena);
}
