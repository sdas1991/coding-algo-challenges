package com.faang.coach.controller;

import com.faang.coach.domain.Mastery;
import com.faang.coach.domain.Problem;
import com.faang.coach.domain.TestCase;
import com.faang.coach.domain.UserSession;
import com.faang.coach.dto.*;
import com.faang.coach.repository.MasteryRepository;
import com.faang.coach.repository.ProblemRepository;
import com.faang.coach.repository.TestCaseRepository;
import com.faang.coach.service.*;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/submit")
@RequiredArgsConstructor
@Slf4j
public class SubmissionController {

    private final ProblemRepository problemRepository;
    private final TestCaseRepository testCaseRepository;
    private final MasteryRepository masteryRepository;
    private final WisdomPointService wisdomPointService;
    private final TestRunnerService testRunnerService;
    private final SqlEvaluatorService sqlEvaluatorService;
    private final SystemDesignService systemDesignService;
    private final McqEvaluatorService mcqEvaluatorService;

    @PostMapping("/algo")
    public ResponseEntity<?> submitAlgoSolution(@Valid @RequestBody SubmitAlgoRequest request) {
        try {
            Long userId = request.getUserId() != null ? request.getUserId() : 1L;

            // Get problem
            Optional<Problem> problemOpt = problemRepository.findById(request.getProblemId());
            if (problemOpt.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Map.of("error", "Problem not found"));
            }

            Problem problem = problemOpt.get();

            // Get test cases
            List<TestCase> testCases = testCaseRepository.findByProblemId(problem.getId());
            if (testCases.isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("error", "No test cases found for this problem"));
            }

            // Run tests
            List<TestCaseResult> results;
            if ("java".equalsIgnoreCase(request.getLanguage())) {
                results = testRunnerService.runJavaTests(
                        request.getCode(),
                        testCases,
                        problem.getTimeLimitMs()
                );
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("error", "Only Java is currently supported"));
            }

            // Check if all tests passed
            boolean allPassed = results.stream().allMatch(TestCaseResult::getPassed);

            // Update mastery
            Mastery mastery = updateMastery(userId, problem, allPassed, results);

            // Award wisdom points if solved
            UserSession session = wisdomPointService.getUserSession(userId);
            int wpEarned = 0;

            if (allPassed && !"SOLVED".equals(mastery.getStatus()) && !"MASTERED".equals(mastery.getStatus())) {
                wpEarned = calculateWpReward(problem, mastery);
                wisdomPointService.addWisdomPoints(session, wpEarned);
                wisdomPointService.incrementProblemsSolved(session);
                mastery.setStatus("SOLVED");
                mastery.setFirstSolvedTime(LocalDateTime.now());
                masteryRepository.save(mastery);
            }

            // Build response
            SubmissionResult response = SubmissionResult.builder()
                    .success(allPassed)
                    .message(allPassed ? "All test cases passed!" : "Some test cases failed")
                    .wpEarned(wpEarned)
                    .totalWp(session.getWisdomPoints())
                    .testCaseResults(results)
                    .build();

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            log.error("Error processing algo submission", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Submission processing failed: " + e.getMessage()));
        }
    }

    @PostMapping("/knowledge")
    public ResponseEntity<?> submitKnowledgeSolution(@Valid @RequestBody SubmitKnowledgeRequest request) {
        try {
            Long userId = request.getUserId() != null ? request.getUserId() : 1L;

            // Get problem
            Optional<Problem> problemOpt = problemRepository.findById(request.getProblemId());
            if (problemOpt.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Map.of("error", "Problem not found"));
            }

            Problem problem = problemOpt.get();
            List<TestCaseResult> results;

            // Evaluate based on module type
            switch (request.getModuleType().toUpperCase()) {
                case "SQL":
                    if (!sqlEvaluatorService.isValidSql(request.getAnswer()) ||
                        !sqlEvaluatorService.isSafeSql(request.getAnswer())) {
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                .body(Map.of("error", "Invalid or unsafe SQL"));
                    }
                    List<TestCase> sqlTestCases = testCaseRepository.findByProblemId(problem.getId());
                    results = sqlEvaluatorService.evaluateSql(request.getAnswer(), sqlTestCases, problem);
                    break;

                case "SYSTEM_DESIGN":
                    if (!systemDesignService.isValidSubmission(request.getAnswer())) {
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                .body(Map.of("error", "Submission too short. Provide detailed explanation."));
                    }
                    TestCaseResult sdResult = systemDesignService.evaluateSystemDesign(request.getAnswer(), problem);
                    results = List.of(sdResult);
                    break;

                case "MCQ":
                    if (!mcqEvaluatorService.isValidMcqAnswer(request.getAnswer())) {
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                .body(Map.of("error", "Invalid MCQ answer format. Use format: A or A,B"));
                    }
                    TestCaseResult mcqResult = mcqEvaluatorService.evaluateMcq(request.getAnswer(), problem);
                    results = List.of(mcqResult);
                    break;

                default:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                            .body(Map.of("error", "Unsupported module type"));
            }

            // Check if all tests passed
            boolean allPassed = results.stream().allMatch(TestCaseResult::getPassed);

            // Update mastery
            Mastery mastery = updateMastery(userId, problem, allPassed, results);

            // Award wisdom points if solved
            UserSession session = wisdomPointService.getUserSession(userId);
            int wpEarned = 0;

            if (allPassed && !"SOLVED".equals(mastery.getStatus()) && !"MASTERED".equals(mastery.getStatus())) {
                wpEarned = calculateWpReward(problem, mastery);
                wisdomPointService.addWisdomPoints(session, wpEarned);
                wisdomPointService.incrementProblemsSolved(session);
                mastery.setStatus("SOLVED");
                mastery.setFirstSolvedTime(LocalDateTime.now());
                masteryRepository.save(mastery);
            }

            // Build response
            SubmissionResult response = SubmissionResult.builder()
                    .success(allPassed)
                    .message(allPassed ? "Correct!" : "Incorrect. Try again!")
                    .wpEarned(wpEarned)
                    .totalWp(session.getWisdomPoints())
                    .testCaseResults(results)
                    .build();

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            log.error("Error processing knowledge submission", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Submission processing failed: " + e.getMessage()));
        }
    }

    @PostMapping("/hint/{problemId}")
    public ResponseEntity<?> getHint(
            @PathVariable Long problemId,
            @RequestParam(required = false, defaultValue = "1") Long userId) {

        try {
            Optional<Problem> problemOpt = problemRepository.findById(problemId);
            if (problemOpt.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Map.of("error", "Problem not found"));
            }

            Problem problem = problemOpt.get();
            UserSession session = wisdomPointService.getUserSession(userId);

            // Check if user has enough WP
            if (session.getWisdomPoints() < problem.getHintCost()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("error", "Insufficient Wisdom Points"));
            }

            // Deduct WP
            wisdomPointService.deductWisdomPoints(session, problem.getHintCost());

            // Update mastery
            Optional<Mastery> masteryOpt = masteryRepository.findByUserIdAndProblemId(userId, problemId);
            Mastery mastery = masteryOpt.orElse(Mastery.builder()
                    .userId(userId)
                    .problemId(problemId)
                    .status("UNSOLVED")
                    .attempts(0)
                    .hintsUsed(0)
                    .teachUsed(false)
                    .build());

            mastery.setHintsUsed(mastery.getHintsUsed() + 1);
            if ("UNSOLVED".equals(mastery.getStatus())) {
                mastery.setStatus("HINT_USED");
            }
            masteryRepository.save(mastery);

            Map<String, Object> response = new HashMap<>();
            response.put("hint", problem.getHintsMarkdown());
            response.put("wpDeducted", problem.getHintCost());
            response.put("remainingWp", session.getWisdomPoints());

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            log.error("Error getting hint", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Failed to get hint: " + e.getMessage()));
        }
    }

    @PostMapping("/teach/{problemId}")
    public ResponseEntity<?> getTeachMe(
            @PathVariable Long problemId,
            @RequestParam(required = false, defaultValue = "1") Long userId) {

        try {
            Optional<Problem> problemOpt = problemRepository.findById(problemId);
            if (problemOpt.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Map.of("error", "Problem not found"));
            }

            Problem problem = problemOpt.get();
            UserSession session = wisdomPointService.getUserSession(userId);

            // Check cooldown
            if (!wisdomPointService.canUseTeachMe(session)) {
                long cooldownSeconds = wisdomPointService.getTeachMeCooldownSeconds(session);
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("error", "Teach Me is on cooldown",
                                   "cooldownSeconds", cooldownSeconds));
            }

            // Check if user has enough WP
            if (session.getWisdomPoints() < problem.getTeachCost()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("error", "Insufficient Wisdom Points"));
            }

            // Deduct WP and record usage
            wisdomPointService.deductWisdomPoints(session, problem.getTeachCost());
            wisdomPointService.recordTeachMeUsage(session);

            // Update mastery
            Optional<Mastery> masteryOpt = masteryRepository.findByUserIdAndProblemId(userId, problemId);
            Mastery mastery = masteryOpt.orElse(Mastery.builder()
                    .userId(userId)
                    .problemId(problemId)
                    .status("UNSOLVED")
                    .attempts(0)
                    .hintsUsed(0)
                    .teachUsed(false)
                    .build());

            mastery.setTeachUsed(true);
            mastery.setStatus("TEACH_USED");
            masteryRepository.save(mastery);

            Map<String, Object> response = new HashMap<>();
            response.put("explanation", problem.getSolutionExplanationMarkdown());
            response.put("solutionJava", problem.getSolvedJavaCode());
            response.put("solutionKotlin", problem.getSolvedKotlinCode());
            response.put("wpDeducted", problem.getTeachCost());
            response.put("remainingWp", session.getWisdomPoints());

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            log.error("Error getting teach me", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Failed to get explanation: " + e.getMessage()));
        }
    }

    private Mastery updateMastery(Long userId, Problem problem, boolean passed, List<TestCaseResult> results) {
        Optional<Mastery> masteryOpt = masteryRepository.findByUserIdAndProblemId(userId, problem.getId());

        Mastery mastery = masteryOpt.orElse(Mastery.builder()
                .userId(userId)
                .problemId(problem.getId())
                .status("UNSOLVED")
                .attempts(0)
                .hintsUsed(0)
                .teachUsed(false)
                .build());

        mastery.setAttempts(mastery.getAttempts() + 1);
        mastery.setLastSubmissionTime(LocalDateTime.now());

        if (passed) {
            // Calculate best time from test results
            long totalTime = results.stream()
                    .filter(r -> r.getExecutionTimeMs() != null)
                    .mapToLong(TestCaseResult::getExecutionTimeMs)
                    .sum();

            if (mastery.getBestTimeMs() == null || totalTime < mastery.getBestTimeMs()) {
                mastery.setBestTimeMs(totalTime);
            }
        }

        return masteryRepository.save(mastery);
    }

    private int calculateWpReward(Problem problem, Mastery mastery) {
        int baseReward = problem.getWpReward();

        // Reduce reward if hints or teach were used
        if (mastery.getHintsUsed() > 0) {
            baseReward = (int) (baseReward * 0.8);
        }
        if (mastery.getTeachUsed()) {
            baseReward = (int) (baseReward * 0.5);
        }

        // Bonus for first attempt solve
        if (mastery.getAttempts() == 1) {
            baseReward = (int) (baseReward * 1.5);
        }

        return Math.max(baseReward, 5); // Minimum 5 WP
    }
}
