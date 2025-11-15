package com.faang.coach.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubmitKnowledgeRequest {

    @NotNull(message = "Problem ID is required")
    private Long problemId;

    @NotBlank(message = "Module type is required")
    private String moduleType; // SQL, SYSTEM_DESIGN, MCQ

    @NotBlank(message = "Answer is required")
    private String answer;

    private Long userId; // Optional, can be set from session
}
