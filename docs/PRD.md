# Career Counseling & Mentoring Platform — PRD

## Problem
Bangladeshi university students and recent graduates (18–25) are confused about career direction. Career counselors currently manage assessments, analysis, recommendations, and follow-ups via spreadsheets, forms, and WhatsApp — slow, unstructured, hard to track.

## Target User
- **Primary:** Students/graduates completing a career assessment and following a personalized roadmap.
- **Secondary:** One counselor/mentor (the builder) reviewing assessments, writing recommendations, tracking progress, logging sessions.

## Core Objects (v1)
- **Student** — name, education level, field of study, contact
- **Assessment Response** — answers to structured career assessment questions
- **Career Profile** — interests, strengths, skills, values, career preferences (derived from responses)
- **Career Direction** — 3–5 recommended paths with fit reasoning
- **Roadmap** — 90-day action plan with tasks/milestones
- **Roadmap Task** — actionable next step with status, due date
- **Recommendation** — counselor's written guidance on a student
- **Mentoring Session** — date, notes, follow-up actions

## MVP (v1) Checklist
- [ ] Structured career assessment (interests, strengths, skills, values, preferences)
- [ ] Auto-generated career profile from assessment responses
- [ ] 3–5 recommended career directions with reasoning
- [ ] 90-day personalized roadmap with trackable tasks
- [ ] Student dashboard: view profile, directions, roadmap, task status
- [ ] Counselor dashboard: review any student's assessment/profile/roadmap, add recommendations, log mentoring sessions, update task progress
- [ ] All screens viewable without login (demo mode with seed data)

## Non-goals (v1)
- Native mobile apps; AI chatbot; job marketplace; employer portal; payments; video calls; psychometric testing platform; social/community features; automated career diagnosis without counselor input.

## Success Criteria
A student completes the assessment → sees a clear career profile with 3–5 suitable directions → receives a practical 90-day roadmap with specific next steps → tracks task progress. A counselor reviews the same student's full profile, adds a recommendation, and logs a mentoring session. ≥10 test users complete this flow without assistance.

## Definition of Done
A student can complete the assessment, view their career profile and 3–5 directions, see and update their 90-day roadmap tasks, and a counselor can review everything and add recommendations — all persisting to the database, no dead buttons.