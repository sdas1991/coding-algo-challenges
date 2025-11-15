package com.faang.coach.dto;

import lombok.*;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubmissionResult {

    private Boolean success;
    private String message;
    private Integer wpEarned;
    private Integer totalWp;
    private List<TestCaseResult> testCaseResults;
    private String errorMessage;
    private Long executionTimeMs;
    private Integer memoryUsedMb;
}
