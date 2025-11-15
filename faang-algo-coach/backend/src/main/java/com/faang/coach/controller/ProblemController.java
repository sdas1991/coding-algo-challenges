package com.faang.coach.controller;

import com.faang.coach.domain.Mastery;
import com.faang.coach.domain.Problem;
import com.faang.coach.dto.ProblemResponse;
import com.faang.coach.repository.MasteryRepository;
import com.faang.coach.repository.ProblemRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/problems")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class ProblemController {

    private final ProblemRepository problemRepository;
    private final MasteryRepository masteryRepository;

    @GetMapping("/solved/{category}")
    public ResponseEntity<List<ProblemResponse>> getSolvedProblems(
            @PathVariable String category,
            @RequestParam(required = false, defaultValue = "1") Long userId) {

        List<Mastery> solvedMasteries = masteryRepository.findSolvedByUserIdAndCategory(userId, category);

        List<ProblemResponse> responses = solvedMasteries.stream()
                .map(mastery -> {
                    Optional<Problem> problemOpt = problemRepository.findById(mastery.getProblemId());
                    if (problemOpt.isPresent()) {
                        Problem problem = problemOpt.get();
                        return buildProblemResponse(problem, mastery);
                    }
                    return null;
                })
                .filter(response -> response != null)
                .collect(Collectors.toList());

        return ResponseEntity.ok(responses);
    }

    @GetMapping("/next/{moduleType}")
    public ResponseEntity<ProblemResponse> getNextProblem(
            @PathVariable String moduleType,
            @RequestParam(required = false, defaultValue = "1") Long userId) {

        List<Problem> unsolvedProblems = problemRepository
                .findUnsolvedByModuleTypeAndUserId(moduleType.toUpperCase(), userId);

        if (unsolvedProblems.isEmpty()) {
            return ResponseEntity.noContent().build();
        }

        Problem nextProblem = unsolvedProblems.get(0);
        Optional<Mastery> masteryOpt = masteryRepository.findByUserIdAndProblemId(userId, nextProblem.getId());

        ProblemResponse response = buildProblemResponse(nextProblem, masteryOpt.orElse(null));

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProblemResponse> getProblemById(
            @PathVariable Long id,
            @RequestParam(required = false, defaultValue = "1") Long userId) {

        Optional<Problem> problemOpt = problemRepository.findById(id);

        if (problemOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Problem problem = problemOpt.get();
        Optional<Mastery> masteryOpt = masteryRepository.findByUserIdAndProblemId(userId, problem.getId());

        ProblemResponse response = buildProblemResponse(problem, masteryOpt.orElse(null));

        return ResponseEntity.ok(response);
    }

    @GetMapping("/category/{category}")
    public ResponseEntity<List<ProblemResponse>> getProblemsByCategory(
            @PathVariable String category,
            @RequestParam(required = false, defaultValue = "1") Long userId) {

        List<Problem> problems = problemRepository.findByCategory(category);

        List<ProblemResponse> responses = problems.stream()
                .map(problem -> {
                    Optional<Mastery> masteryOpt = masteryRepository.findByUserIdAndProblemId(userId, problem.getId());
                    return buildProblemResponse(problem, masteryOpt.orElse(null));
                })
                .collect(Collectors.toList());

        return ResponseEntity.ok(responses);
    }

    private ProblemResponse buildProblemResponse(Problem problem, Mastery mastery) {
        List<String> tags = problem.getTags() != null ?
                Arrays.asList(problem.getTags().split(",")) : List.of();

        return ProblemResponse.builder()
                .id(problem.getId())
                .moduleType(problem.getModuleType())
                .category(problem.getCategory())
                .arena(problem.getArena())
                .title(problem.getTitle())
                .descriptionMarkdown(problem.getDescriptionMarkdown())
                .difficulty(problem.getDifficulty())
                .tags(tags)
                .wpReward(problem.getWpReward())
                .hintCost(problem.getHintCost())
                .teachCost(problem.getTeachCost())
                .timeLimitMs(problem.getTimeLimitMs())
                .memoryLimitMb(problem.getMemoryLimitMb())
                .masteryStatus(mastery != null ? mastery.getStatus() : "UNSOLVED")
                .attempts(mastery != null ? mastery.getAttempts() : 0)
                .hintsAvailable(problem.getHintsMarkdown() != null && !problem.getHintsMarkdown().isEmpty())
                .teachMeAvailable(problem.getSolutionExplanationMarkdown() != null &&
                                 !problem.getSolutionExplanationMarkdown().isEmpty())
                .build();
    }
}
