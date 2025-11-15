package com.faang.coach.service;

import com.faang.coach.domain.Problem;
import com.faang.coach.domain.TestCase;
import com.faang.coach.dto.TestCaseResult;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class SqlEvaluatorService {

    /**
     * Evaluates SQL submissions by normalizing and comparing with expected output
     * Note: In a production system, this would execute against a sandboxed database
     */
    public List<TestCaseResult> evaluateSql(String submittedSql, List<TestCase> testCases, Problem problem) {
        List<TestCaseResult> results = new ArrayList<>();

        for (int i = 0; i < testCases.size(); i++) {
            TestCase testCase = testCases.get(i);
            TestCaseResult result = evaluateSqlTestCase(submittedSql, testCase, i + 1);
            results.add(result);
        }

        return results;
    }

    private TestCaseResult evaluateSqlTestCase(String submittedSql, TestCase testCase, int testNumber) {
        try {
            // Normalize both SQLs for comparison
            String normalizedSubmitted = normalizeSql(submittedSql);
            String normalizedExpected = normalizeSql(testCase.getExpectedOutput());

            // For this offline version, we're doing string comparison
            // In production, you'd execute against a database and compare results
            boolean passed = normalizedSubmitted.contains(normalizeKeywords(normalizedExpected));

            // Check if submitted SQL has required keywords from expected
            boolean hasRequiredKeywords = checkRequiredKeywords(normalizedSubmitted, normalizedExpected);

            return TestCaseResult.builder()
                    .testCaseNumber(testNumber)
                    .passed(hasRequiredKeywords)
                    .input(testCase.getInputData())
                    .expectedOutput(testCase.getExpectedOutput())
                    .actualOutput(submittedSql)
                    .build();

        } catch (Exception e) {
            log.error("Error evaluating SQL test case {}", testNumber, e);
            return TestCaseResult.builder()
                    .testCaseNumber(testNumber)
                    .passed(false)
                    .errorMessage("SQL Evaluation Error: " + e.getMessage())
                    .build();
        }
    }

    private String normalizeSql(String sql) {
        if (sql == null) {
            return "";
        }

        return sql.trim()
                .replaceAll("\\s+", " ")
                .replaceAll("\\(\\s+", "(")
                .replaceAll("\\s+\\)", ")")
                .toLowerCase();
    }

    private String normalizeKeywords(String sql) {
        return sql.replaceAll("[^a-zA-Z0-9\\s]", " ")
                .replaceAll("\\s+", " ")
                .trim()
                .toLowerCase();
    }

    private boolean checkRequiredKeywords(String submitted, String expected) {
        // Extract key SQL keywords and table/column names
        String[] expectedTokens = expected.split("\\s+");
        int matchCount = 0;
        int requiredMatches = 0;

        for (String token : expectedTokens) {
            if (token.length() > 2) { // Skip very short tokens
                requiredMatches++;
                if (submitted.contains(token)) {
                    matchCount++;
                }
            }
        }

        // Require at least 70% keyword match
        return requiredMatches == 0 || ((double) matchCount / requiredMatches) >= 0.7;
    }

    /**
     * Validates SQL syntax (basic validation)
     */
    public boolean isValidSql(String sql) {
        if (sql == null || sql.trim().isEmpty()) {
            return false;
        }

        String normalized = sql.trim().toUpperCase();

        // Must start with valid SQL keyword
        return normalized.startsWith("SELECT") ||
               normalized.startsWith("INSERT") ||
               normalized.startsWith("UPDATE") ||
               normalized.startsWith("DELETE") ||
               normalized.startsWith("CREATE") ||
               normalized.startsWith("WITH");
    }

    /**
     * Checks if SQL is potentially dangerous (basic security check)
     */
    public boolean isSafeSql(String sql) {
        String upper = sql.toUpperCase();

        // Block potentially dangerous operations
        String[] dangerousKeywords = {
            "DROP", "TRUNCATE", "ALTER", "GRANT", "REVOKE",
            "EXEC", "EXECUTE", "SHUTDOWN", "KILL"
        };

        for (String keyword : dangerousKeywords) {
            if (upper.contains(keyword)) {
                log.warn("Dangerous SQL keyword detected: {}", keyword);
                return false;
            }
        }

        return true;
    }
}
