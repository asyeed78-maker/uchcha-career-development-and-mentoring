# Intelligence Layer

## Messy Inputs
- Free-text assessment answers ("I like helping people but not sure what career")
- Varied skill levels, inconsistent education terms
- Counselor's unstructured session notes

## Auto-Structure Schema
```json
{
  "dimension": "interests",
  "extracted_tags": ["helping_others", "communication", "research"],
  "dimension_scores": {
    "interests": {"helping_others": 8, "technology": 3, "business": 5},
    "strengths": {"communication": 7, "analytical_thinking": 6},
    "skills": {"writing": 5, "public_speaking": 4},
    "values": {"impact": 9, "autonomy": 6, "stability": 4},
    "preferences": {"work_environment": "collaborative", "industry": "nonprofit/education"}
  },
  "source": "rule_based_scoring",
  "confidence": 0.82
}
```

## Events to Track
- Assessment started, completed
- Profile generated, reviewed by counselor
- Direction viewed, selected
- Roadmap generated, task completed
- Recommendation added
- Session logged

## Scoring Rules (v1, rule-based)
- Each assessment question maps to a dimension tag with weight 1–10
- Dimension score = sum of (answer_score × weight) / max possible for that dimension
- Career direction fit = weighted cosine similarity between profile vector and career catalog vector
- Top 3–5 directions above threshold (fit_score ≥ 0.6) returned
- AI (optional) enriches fit_reasoning text; rule-based fallback produces template reasoning

## What Gets Ranked
- Career directions: ranked by fit_score descending
- Roadmap tasks: ranked by due_date then category priority (learn→build→network→apply→reflect)

## v1 vs Later
- **v1:** Rule-based scoring + template reasoning. No AI required.
- **Later:** LLM-generated profile summaries, personalized task descriptions, dynamic career catalog expansion.