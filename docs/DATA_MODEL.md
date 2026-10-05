# Data Model

## students
- id: uuid (pk), name: text, email: text, education_level: text, field_of_study: text, university: text, graduation_year: int, phone: text, user_id: uuid (nullable), created_at: timestamptz

## assessment_responses
- id: uuid (pk), student_id: uuid (fk→students), dimension: text (interests|strengths|skills|values|preferences), question_key: text, answer_value: text, answer_score: numeric, user_id: uuid (nullable), created_at: timestamptz

## career_profiles
- id: uuid (pk), student_id: uuid (fk→students), interests: text[], strengths: text[], skills: text[], values: text[], career_preferences: text, summary: text, summary_source: text, summary_confidence: numeric, review_status: text (default 'unreviewed'), user_id: uuid (nullable), created_at: timestamptz

## career_directions
- id: uuid (pk), student_id: uuid (fk→students), career_path: text, fit_score: numeric, fit_reasoning: text, reasoning_source: text, reasoning_confidence: numeric, review_status: text (default 'unreviewed'), user_id: uuid (nullable), created_at: timestamptz

## roadmaps
- id: uuid (pk), student_id: uuid (fk→students), title: text, target_direction: text, start_date: date, end_date: date, status: text (default 'active'), user_id: uuid (nullable), created_at: timestamptz

## roadmap_tasks
- id: uuid (pk), roadmap_id: uuid (fk→roadmaps), title: text, description: text, category: text (learn|build|network|apply|reflect), due_date: date, status: text (default 'pending'), completed_at: timestamptz, user_id: uuid (nullable), created_at: timestamptz

## recommendations
- id: uuid (pk), student_id: uuid (fk→students), counselor_note: text, action_type: text (guidance|resource|referral|next_step), user_id: uuid (nullable), created_at: timestamptz

## mentoring_sessions
- id: uuid (pk), student_id: uuid (fk→students), session_date: date, duration_minutes: int, notes: text, follow_up_actions: text, user_id: uuid (nullable), created_at: timestamptz

## Relationships
- student 1→N assessment_responses, 1→1 career_profile, 1→N career_directions, 1→N roadmaps, 1→N recommendations, 1→N mentoring_sessions
- roadmap 1→N roadmap_tasks

## RLS / Permissions
- v1 (demo): all tables permissive read/write (no login required)
- Lock-down: students see own rows; counselor sees all; enforced via `auth.uid() = user_id`

## AI Fields
- career_profiles.summary → value + source + confidence + review_status
- career_directions.fit_reasoning → value + source + confidence + review_status