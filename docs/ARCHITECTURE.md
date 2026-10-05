# Architecture

## Stack
Next.js (App Router) + Supabase (Postgres + RLS) + Vercel. TypeScript throughout.

## Build Sequence
- **Now (v1):** Assessment → career profile → career directions → 90-day roadmap → task tracking → counselor review/recommendations → mentoring sessions. All viewable without login.
- **Next:** Authentication, per-student data isolation, counselor vs student roles.
- **Later:** Paid sessions, CV/LinkedIn services, mock interview booking, transition roadmaps, mentoring packages.

## Key User Flow (one action)
1. Student opens assessment page → answers structured questions across 5 dimensions
2. Responses saved to DB → career profile generated (interests, strengths, skills, values, preferences)
3. Career directions matched from profile (rule-based scoring against a career catalog)
4. 90-day roadmap generated from chosen direction — tasks with due dates
5. Student views roadmap, updates task status
6. Counselor opens student profile → reviews assessment + roadmap → writes recommendation → logs mentoring session

## Responsive Nav Shell
Left sidebar (desktop) collapsing to hamburger (mobile). Sections: Dashboard, Assessment, Career Profile, Roadmap, Mentoring. Counselor sees: All Students, Student Detail, Sessions.

## Layer Plan
1. **Data layer** — `lib/data/` — all Supabase queries (CRUD) in one place
2. **App logic** — `lib/actions/` — server actions for assessment scoring, roadmap generation, task updates
3. **Intelligence** — `lib/ai/` — career direction matching, profile summarization (optional, rule-based fallback works without it)
4. **UI** — feature-oriented component folders

## Why Core Works Without AI
Assessment scoring is rule-based (weighted category mapping). Career directions matched via weighted profile-to-career scoring. Roadmap generated from templates keyed by direction. AI layer only enhances reasoning text and profile summaries — the core flow runs end-to-end without it.

## Repo Structure
```
src/
  app/
    (student)/dashboard, assessment, profile, roadmap
    (counselor)/students, students/[id], sessions
  lib/
    data/        # all DB reads/writes
    actions/     # server actions
    ai/          # career matching, summarization
  components/
    assessment/, profile/, roadmap/, mentoring/, shared/
  __tests__/
```

## Module Map
| Module | Responsibility | Owns | Build Order |
|---|---|---|---|
| assessment | Assessment questions, response capture, scoring | assessment_responses, career_profiles | 1 |
| directions | Match career directions from profile | career_directions | 2 |
| roadmap | Generate 90-day plan, task tracking | roadmaps, roadmap_tasks | 3 |
| mentoring | Counselor review, recommendations, sessions | recommendations, mentoring_sessions | 4 |
| shared | Layout, nav, data-access utilities | — | 0 |