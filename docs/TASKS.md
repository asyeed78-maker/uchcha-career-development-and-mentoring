# Tasks & Sprints

## Sprint 0 — Foundation & Shell
- [ ] Set up Next.js + Supabase project, env vars
- [ ] Create `lib/data/` with typed Supabase client and CRUD helpers
- [ ] Build responsive sidebar shell (Dashboard, Assessment, Profile, Roadmap, Mentoring)
- [ ] Seed demo students, assessments, profiles, directions, roadmaps
- **DoD:** App loads with sidebar nav, demo data visible on dashboard, no login required.

## Sprint 1 — Assessment Engine (CORE)
- [ ] Build assessment form (5 dimensions: interests, strengths, skills, values, preferences)
- [ ] Save responses to `assessment_responses`
- [ ] Rule-based scoring → write `career_profiles`
- [ ] Display career profile to student
- **DoD:** Student completes assessment, profile generated and visible, persists to DB.

## Sprint 2 — Career Directions & Roadmap (CORE)
- [ ] Career catalog table or config with weighted vectors
- [ ] Match directions from profile → write `career_directions` (3–5 ranked)
- [ ] Display directions with fit_score and reasoning
- [ ] Roadmap template generator from chosen direction → write `roadmaps` + `roadmap_tasks`
- [ ] Display 90-day roadmap with task list
- **DoD:** Student sees 3–5 ranked directions, selects one, gets a populated 90-day roadmap. ← **v1 FUNCTIONAL MILESTONE**

## Sprint 3 — Counselor Review & Mentoring
- [ ] Counselor student list view (all students with assessment status)
- [ ] Student detail view (profile, directions, roadmap, tasks)
- [ ] Add recommendation form → writes `recommendations`
- [ ] Log mentoring session form → writes `mentoring_sessions`
- [ ] Update roadmap task status from counselor or student view
- **DoD:** Counselor reviews a student's full profile, adds recommendation, logs session, updates task — all persist.

## Sprint 4 — Lock It Down
- [ ] Add Supabase Auth (email/password)
- [ ] Signup/login pages
- [ ] Replace permissive RLS with owner-scoped policies (`auth.uid() = user_id`)
- [ ] Counselor role flag + all-access policies
- [ ] Audit logging for all automated + manual actions
- **DoD:** Login works, students see only their data, counselor sees all, no anonymous writes.

## Text Gantt
```
Task                          S0  S1  S2  S3  S4
Shell + data layer             █
Assessment + scoring               █
Career directions + roadmap            █
Counselor review + mentoring               █
Auth + RLS lock-down                             █
```