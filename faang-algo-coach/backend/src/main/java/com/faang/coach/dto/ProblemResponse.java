package com.faang.coach.dto;

import lombok.*;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProblemResponse {

    private Long id;
    private String moduleType;
    private String category;
    private String arena;
    private String title;
    private String descriptionMarkdown;
    private String difficulty;
    private List<String> tags;
    private Integer wpReward;
    private Integer hintCost;
    private Integer teachCost;
    private Integer timeLimitMs;
    private Integer memoryLimitMb;

    // Mastery info (if user has attempted)
    private String masteryStatus;
    private Integer attempts;
    private Boolean hintsAvailable;
    private Boolean teachMeAvailable;
}
