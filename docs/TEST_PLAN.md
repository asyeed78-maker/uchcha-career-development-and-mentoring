# Test Plan

## v1 Success Scenario (end-to-end)
1. Open app → dashboard shows seeded demo students (no login)
2. Click "Take Assessment" → complete all 5 dimensions (interests, strengths, skills, values, preferences)
3. Submit → career profile page loads with interests, strengths, skills, values, summary
4. Click "View Directions" → see 3–5 ranked career paths with fit scores and reasoning
5. Select a direction → 90-day roadmap page loads with tasks (learn, build, network, apply, reflect)
6. Mark a task as completed → status updates, persists on refresh
7. Switch to counselor view → open same student's detail page
8. Verify assessment, profile, directions, roadmap all visible
9. Add a recommendation → appears in student's profile
10. Log a mentoring session → appears in student's session history
11. Update a roadmap task status → reflects in student view

## Empty States
- No students yet → counselor dashboard shows "No students. Share the assessment link."
- No assessment completed → student dashboard shows "Start your career assessment" CTA
- No directions generated → profile page shows "Complete assessment to see directions"
- No roadmap yet → directions page shows "Select a direction to generate your roadmap"
- No recommendations → student profile shows "No recommendations yet"
- No sessions → mentoring tab shows "No sessions logged yet"

## Error States
- Supabase unreachable → assessment submit shows "Could not save. Check connection and retry."
- Incomplete assessment (missing dimension) → submit blocked, highlight missing section
- Roadmap generation fails → show error, allow retry, do not leave blank page
- Task update fails → revert UI, show "Could not update. Try again."

## Loading States
- Assessment submit → spinner with "Generating your career profile…"
- Directions match → spinner with "Finding suitable career paths…"
- Roadmap generation → spinner with "Building your 90-day plan…"
- Student list → skeleton cards

## Persistence Check
- After completing any action, refresh the page → data must still be present (server-truth, not localStorage).
- Create a new student via assessment → it appears in counselor's student list immediately.