# Agentic Layer

## Risk Levels

### Low (auto-execute)
- Generate career profile from assessment responses
- Score and rank career directions
- Generate 90-day roadmap from template + chosen direction
- Tag assessment responses by dimension
- Draft roadmap task descriptions

### Medium (draft → counselor approves → execute)
- Update student roadmap task status on counselor review
- Draft recommendation text for counselor to edit and publish
- Summarize mentoring session notes into follow-up actions

### High (always requires approval)
- Publish recommendation to student-visible profile
- Set/modify a student's roadmap target direction
- Change roadmap status (active → completed → paused)

### Human-Only
- Delete a student record or assessment
- Delete or modify a completed mentoring session log
- Any data export beyond the platform UI

## Named Tools (v1)
- `generateCareerProfile(studentId)` — reads responses, writes career_profile
- `matchCareerDirections(studentId)` — reads profile, writes career_directions
- `generateRoadmap(studentId, directionId)` — writes roadmap + roadmap_tasks
- `draftRecommendation(studentId, context)` — returns draft text, does NOT publish
- `summarizeSession(sessionId)` — returns structured follow-up summary

## Audit Log Fields
- action: text, actor: text, target_table: text, target_id: uuid, metadata: jsonb, created_at: timestamptz

## v1 vs Later
- **v1:** Low-risk auto actions only (profile, directions, roadmap generation). Medium-risk drafting enabled but manual review required. No high-risk automation.
- **Later:** Automated recommendation publishing, scheduled follow-up reminders, progress report generation.