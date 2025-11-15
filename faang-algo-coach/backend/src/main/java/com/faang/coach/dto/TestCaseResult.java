package com.faang.coach.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TestCaseResult {

    private Integer testCaseNumber;
    private Boolean passed;
    private String input;
    private String expectedOutput;
    private String actualOutput;
    private String errorMessage;
    private Long executionTimeMs;
}
