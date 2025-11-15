package com.faang.coach.service;

import com.faang.coach.domain.Problem;
import com.faang.coach.dto.TestCaseResult;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class McqEvaluatorService {

    /**
     * Evaluates MCQ submissions
     * Answer format: "A" or "B" or "A,B,C" for multiple correct answers
     */
    public TestCaseResult evaluateMcq(String submittedAnswer, Problem problem) {
        try {
            if (submittedAnswer == null || submittedAnswer.trim().isEmpty()) {
                return TestCaseResult.builder()
                        .testCaseNumber(1)
                        .passed(false)
                        .errorMessage("No answer provided")
                        .build();
            }

            // Get correct answer from problem's solution code
            String correctAnswer = extractCorrectAnswer(problem);

            if (correctAnswer == null || correctAnswer.isEmpty()) {
                log.error("No correct answer found for problem {}", problem.getId());
                return TestCaseResult.builder()
                        .testCaseNumber(1)
                        .passed(false)
                        .errorMessage("Problem configuration error")
                        .build();
            }

            // Normalize answers
            Set<String> submittedOptions = normalizeAnswer(submittedAnswer);
            Set<String> correctOptions = normalizeAnswer(correctAnswer);

            // Compare answers
            boolean passed = submittedOptions.equals(correctOptions);

            String feedback;
            if (passed) {
                feedback = "Correct!";
            } else {
                feedback = "Incorrect. ";
                if (submittedOptions.size() != correctOptions.size()) {
                    feedback += "Number of selected options is wrong. ";
                }
                // Don't reveal correct answer immediately for learning
            }

            return TestCaseResult.builder()
                    .testCaseNumber(1)
                    .passed(passed)
                    .input("Selected: " + submittedAnswer)
                    .expectedOutput(passed ? correctAnswer : "Try again!")
                    .actualOutput(submittedAnswer)
                    .errorMessage(passed ? null : feedback)
                    .build();

        } catch (Exception e) {
            log.error("Error evaluating MCQ", e);
            return TestCaseResult.builder()
                    .testCaseNumber(1)
                    .passed(false)
                    .errorMessage("Evaluation error: " + e.getMessage())
                    .build();
        }
    }

    private String extractCorrectAnswer(Problem problem) {
        // Correct answer is stored in solvedJavaCode field for MCQ problems
        // Format: "ANSWER: A" or "ANSWER: B,C"
        String solutionCode = problem.getSolvedJavaCode();
        if (solutionCode == null) {
            return null;
        }

        String[] lines = solutionCode.split("\n");
        for (String line : lines) {
            if (line.trim().toUpperCase().startsWith("ANSWER:")) {
                return line.substring(line.indexOf(":") + 1).trim();
            }
        }

        return null;
    }

    private Set<String> normalizeAnswer(String answer) {
        Set<String> options = new HashSet<>();

        // Remove spaces and split by comma
        String[] parts = answer.toUpperCase()
                .replaceAll("\\s+", "")
                .split(",");

        for (String part : parts) {
            String normalized = part.trim();
            if (!normalized.isEmpty() && normalized.matches("[A-Z]")) {
                options.add(normalized);
            }
        }

        return options;
    }

    /**
     * Validates MCQ answer format
     */
    public boolean isValidMcqAnswer(String answer) {
        if (answer == null || answer.trim().isEmpty()) {
            return false;
        }

        // Should be one or more letters (A-Z) separated by commas
        String normalized = answer.toUpperCase().replaceAll("\\s+", "");
        return normalized.matches("^[A-Z](,[A-Z])*$");
    }

    /**
     * Provides hints for MCQ problems
     */
    public String generateMcqHint(Problem problem, int hintLevel) {
        // Return progressively revealing hints
        switch (hintLevel) {
            case 1:
                return "Think about the core concept being tested. Review the question carefully.";
            case 2:
                return "Eliminate obviously wrong answers first. Consider edge cases.";
            case 3:
                String correctAnswer = extractCorrectAnswer(problem);
                Set<String> correct = normalizeAnswer(correctAnswer);
                return "The correct answer has " + correct.size() + " option(s).";
            default:
                return "Read the explanation to understand the concept better.";
        }
    }
}
