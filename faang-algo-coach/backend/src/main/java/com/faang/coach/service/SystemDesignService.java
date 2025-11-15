package com.faang.coach.service;

import com.faang.coach.domain.Problem;
import com.faang.coach.dto.TestCaseResult;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class SystemDesignService {

    private static final int MIN_ANSWER_LENGTH = 100;
    private static final List<String> REQUIRED_SECTIONS = List.of(
        "requirements", "architecture", "components", "database", "api"
    );

    /**
     * Evaluates system design submissions based on content quality
     * Note: This is a simplified version. Production would use ML/NLP for better evaluation
     */
    public TestCaseResult evaluateSystemDesign(String submission, Problem problem) {
        try {
            if (submission == null || submission.trim().isEmpty()) {
                return TestCaseResult.builder()
                        .testCaseNumber(1)
                        .passed(false)
                        .errorMessage("Submission is empty")
                        .build();
            }

            String normalized = submission.toLowerCase();
            List<String> feedback = new ArrayList<>();

            // Check minimum length
            if (submission.length() < MIN_ANSWER_LENGTH) {
                feedback.add("Answer is too short. Provide more detailed explanation.");
            }

            // Check for key sections/keywords
            int sectionsFound = 0;
            List<String> missingSections = new ArrayList<>();

            for (String section : REQUIRED_SECTIONS) {
                if (normalized.contains(section)) {
                    sectionsFound++;
                } else {
                    missingSections.add(section);
                }
            }

            // Check for system design keywords
            int keywordScore = calculateKeywordScore(normalized);

            // Check for diagrams or structured thinking
            boolean hasStructure = checkStructure(submission);

            // Calculate overall score
            boolean passed = submission.length() >= MIN_ANSWER_LENGTH &&
                           sectionsFound >= 3 &&
                           keywordScore >= 5 &&
                           hasStructure;

            if (!missingSections.isEmpty()) {
                feedback.add("Consider adding sections: " + String.join(", ", missingSections));
            }

            if (keywordScore < 5) {
                feedback.add("Include more system design concepts (scalability, load balancing, caching, etc.)");
            }

            if (!hasStructure) {
                feedback.add("Use bullet points, numbering, or sections to structure your answer");
            }

            String message = passed ? "Good system design answer!" : String.join(" ", feedback);

            return TestCaseResult.builder()
                    .testCaseNumber(1)
                    .passed(passed)
                    .actualOutput(submission)
                    .errorMessage(passed ? null : message)
                    .build();

        } catch (Exception e) {
            log.error("Error evaluating system design", e);
            return TestCaseResult.builder()
                    .testCaseNumber(1)
                    .passed(false)
                    .errorMessage("Evaluation error: " + e.getMessage())
                    .build();
        }
    }

    private int calculateKeywordScore(String normalized) {
        List<String> keywords = List.of(
            "scalability", "load balancer", "cache", "database", "microservice",
            "api", "cdn", "queue", "sharding", "replication", "consistency",
            "availability", "partition", "redis", "nosql", "sql", "rest",
            "websocket", "kafka", "distributed", "horizontal", "vertical"
        );

        int score = 0;
        for (String keyword : keywords) {
            if (normalized.contains(keyword)) {
                score++;
            }
        }
        return score;
    }

    private boolean checkStructure(String submission) {
        // Check if answer has structure (bullets, numbers, headings)
        return submission.contains("1.") ||
               submission.contains("2.") ||
               submission.contains("-") ||
               submission.contains("*") ||
               submission.contains("#") ||
               submission.contains("\n\n");
    }

    /**
     * Validates that the submission is appropriate
     */
    public boolean isValidSubmission(String submission) {
        if (submission == null || submission.trim().isEmpty()) {
            return false;
        }

        // Check for minimum effort
        return submission.length() >= 50;
    }
}
