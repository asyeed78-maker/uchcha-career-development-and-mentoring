-- Career Counseling & Mentoring Platform — v1 Schema

create table if not exists students (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text,
  education_level text,
  field_of_study text,
  university text,
  graduation_year int,
  phone text,
  user_id uuid,
  created_at timestamptz not null default now()
);

create table if not exists assessment_responses (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references students(id) on delete cascade,
  dimension text not null,
  question_key text not null,
  answer_value text not null,
  answer_score numeric default 0,
  user_id uuid,
  created_at timestamptz not null default now()
);

create table if not exists career_profiles (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references students(id) on delete cascade,
  interests text[] default '{}',
  strengths text[] default '{}',
  skills text[] default '{}',
  values text[] default '{}',
  career_preferences text,
  summary text,
  summary_source text,
  summary_confidence numeric,
  review_status text default 'unreviewed',
  user_id uuid,
  created_at timestamptz not null default now()
);

create table if not exists career_directions (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references students(id) on delete cascade,
  career_path text not null,
  fit_score numeric default 0,
  fit_reasoning text,
  reasoning_source text,
  reasoning_confidence numeric,
  review_status text default 'unreviewed',
  user_id uuid,
  created_at timestamptz not null default now()
);

create table if not exists roadmaps (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references students(id) on delete cascade,
  title text not null,
  target_direction text not null,
  start_date date,
  end_date date,
  status text default 'active',
  user_id uuid,
  created_at timestamptz not null default now()
);

create table if not exists roadmap_tasks (
  id uuid primary key default gen_random_uuid(),
  roadmap_id uuid not null references roadmaps(id) on delete cascade,
  title text not null,
  description text,
  category text default 'learn',
  due_date date,
  status text default 'pending',
  completed_at timestamptz,
  user_id uuid,
  created_at timestamptz not null default now()
);

create table if not exists recommendations (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references students(id) on delete cascade,
  counselor_note text not null,
  action_type text default 'guidance',
  user_id uuid,
  created_at timestamptz not null default now()
);

create table if not exists mentoring_sessions (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references students(id) on delete cascade,
  session_date date not null,
  duration_minutes int default 45,
  notes text,
  follow_up_actions text,
  user_id uuid,
  created_at timestamptz not null default now()
);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  action text not null,
  actor text,
  target_table text,
  target_id uuid,
  metadata jsonb,
  created_at timestamptz not null default now()
);

-- RLS: enable
alter table students enable row level security;
alter table assessment_responses enable row level security;
alter table career_profiles enable row level security;
alter table career_directions enable row level security;
alter table roadmaps enable row level security;
alter table roadmap_tasks enable row level security;
alter table recommendations enable row level security;
alter table mentoring_sessions enable row level security;
alter table audit_logs enable row level security;

-- Permissive v1 policies (demo-first, no login)
drop policy if exists "students_v1_read" on students;
create policy "students_v1_read" on students for select using (true);
drop policy if exists "students_v1_write" on students;
create policy "students_v1_write" on students for all using (true) with check (true);

drop policy if exists "assessment_responses_v1_read" on assessment_responses;
create policy "assessment_responses_v1_read" on assessment_responses for select using (true);
drop policy if exists "assessment_responses_v1_write" on assessment_responses;
create policy "assessment_responses_v1_write" on assessment_responses for all using (true) with check (true);

drop policy if exists "career_profiles_v1_read" on career_profiles;
create policy "career_profiles_v1_read" on career_profiles for select using (true);
drop policy if exists "career_profiles_v1_write" on career_profiles;
create policy "career_profiles_v1_write" on career_profiles for all using (true) with check (true);

drop policy if exists "career_directions_v1_read" on career_directions;
create policy "career_directions_v1_read" on career_directions for select using (true);
drop policy if exists "career_directions_v1_write" on career_directions;
create policy "career_directions_v1_write" on career_directions for all using (true) with check (true);

drop policy if exists "roadmaps_v1_read" on roadmaps;
create policy "roadmaps_v1_read" on roadmaps for select using (true);
drop policy if exists "roadmaps_v1_write" on roadmaps;
create policy "roadmaps_v1_write" on roadmaps for all using (true) with check (true);

drop policy if exists "roadmap_tasks_v1_read" on roadmap_tasks;
create policy "roadmap_tasks_v1_read" on roadmap_tasks for select using (true);
drop policy if exists "roadmap_tasks_v1_write" on roadmap_tasks;
create policy "roadmap_tasks_v1_write" on roadmap_tasks for all using (true) with check (true);

drop policy if exists "recommendations_v1_read" on recommendations;
create policy "recommendations_v1_read" on recommendations for select using (true);
drop policy if exists "recommendations_v1_write" on recommendations;
create policy "recommendations_v1_write" on recommendations for all using (true) with check (true);

drop policy if exists "mentoring_sessions_v1_read" on mentoring_sessions;
create policy "mentoring_sessions_v1_read" on mentoring_sessions for select using (true);
drop policy if exists "mentoring_sessions_v1_write" on mentoring_sessions;
create policy "mentoring_sessions_v1_write" on mentoring_sessions for all using (true) with check (true);

drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

-- Seed demo data
insert into students (id, name, email, education_level, field_of_study, university, graduation_year, phone) values
  ('a1111111-1111-1111-1111-111111111111', 'Tanvir Ahmed', 'tanvir@example.com', 'Undergraduate', 'Computer Science', 'BUET', 2025, '01700000001'),
  ('a2222222-2222-2222-2222-222222222222', 'Nusrat Jahan', 'nusrat@example.com', 'Graduate', 'Marketing', 'Dhaka University', 2024, '01700000002'),
  ('a3333333-3333-3333-3333-333333333333', 'Rakib Hasan', 'rakib@example.com', 'Undergraduate', 'Electrical Engineering', 'KUET', 2026, '01700000003')
on conflict (id) do nothing;

insert into assessment_responses (student_id, dimension, question_key, answer_value, answer_score) values
  ('a1111111-1111-1111-1111-111111111111', 'interests', 'problem_solving', 'Strong interest', 8),
  ('a1111111-1111-1111-1111-111111111111', 'interests', 'building_things', 'Strong interest', 7),
  ('a1111111-1111-1111-1111-111111111111', 'strengths', 'analytical_thinking', 'Very strong', 9),
  ('a1111111-1111-1111-1111-111111111111', 'skills', 'programming', 'Intermediate', 6),
  ('a1111111-1111-1111-1111-111111111111', 'values', 'innovation', 'Very important', 8),
  ('a1111111-1111-1111-1111-111111111111', 'preferences', 'work_environment', 'Startup / fast-paced', 7)
on conflict (id) do nothing;

insert into career_profiles (student_id, interests, strengths, skills, values, career_preferences, summary, summary_source, summary_confidence, review_status) values
  ('a1111111-1111-1111-1111-111111111111',
   '{problem_solving, building_products, technology}',
   '{analytical_thinking, attention_to_detail}',
   '{programming, data_analysis, communication}',
   '{innovation, autonomy, impact}',
   'Prefers startup environment, values innovation and autonomy',
   'Strong analytical profile with high interest in problem-solving and building. Well-suited for software engineering or product roles in fast-paced environments.',
   'rule_based_scoring', 0.85, 'reviewed')
on conflict (id) do nothing;

insert into career_directions (student_id, career_path, fit_score, fit_reasoning, reasoning_source, reasoning_confidence, review_status) values
  ('a1111111-1111-1111-1111-111111111111', 'Software Engineer', 0.92, 'High analytical score, strong programming interest, values innovation and autonomy — strong match for engineering roles.', 'rule_based', 0.88, 'reviewed'),
  ('a1111111-1111-1111-1111-111111111111', 'Product Manager', 0.78, 'Problem-solving interest and communication skills align with product management, though less technical depth.', 'rule_based', 0.75, 'unreviewed'),
  ('a1111111-1111-1111-1111-111111111111', 'Data Analyst', 0.74, 'Analytical strength and data skills match, but lower programming score limits advanced data roles.', 'rule_based', 0.72, 'unreviewed')
on conflict (id) do nothing;

insert into roadmaps (id, student_id, title, target_direction, start_date, end_date, status) values
  ('b1111111-1111-1111-1111-111111111111', 'a1111111-1111-1111-1111-111111111111', '90-Day Software Engineer Career Roadmap', 'Software Engineer', '2025-01-15', '2025-04-15', 'active')
on conflict (id) do nothing;

insert into roadmap_tasks (roadmap_id, title, description, category, due_date, status) values
  ('b1111111-1111-1111-1111-111111111111', 'Complete 2 LeetCode problems daily', 'Focus on arrays, strings, and dynamic programming', 'learn', '2025-02-15', 'in_progress'),
  ('b1111111-1111-1111-1111-111111111111', 'Build a portfolio web app', 'Create a full-stack project with Next.js and deploy to Vercel', 'build', '2025-03-01', 'pending'),
  ('b1111111-1111-1111-1111-111111111111', 'Connect with 5 BUET alumni in tech', 'Reach out via LinkedIn for informational interviews', 'network', '2025-02-28', 'pending'),
  ('b1111111-1111-1111-1111-111111111111', 'Apply to 10 software engineer internships', 'Target local startups and remote roles', 'apply', '2025-03-30', 'pending'),
  ('b1111111-1111-1111-1111-111111111111', 'Review progress and update CV', 'Reflect on skills gained and update resume', 'reflect', '2025-04-15', 'pending')
on conflict (id) do nothing;

insert into recommendations (student_id, counselor_note, action_type) values
  ('a1111111-1111-1111-1111-111111111111', 'Focus on building one strong portfolio project before applying. Quality over quantity.', 'guidance'),
  ('a1111111-1111-1111-1111-111111111111', 'Join BUET CSE alumni group on Facebook for networking opportunities.', 'resource')
on conflict (id) do nothing;

insert into mentoring_sessions (student_id, session_date, duration_minutes, notes, follow_up_actions) values
  ('a1111111-1111-1111-1111-111111111111', '2025-01-20', 45, 'Discussed career interests and assessment results. Student is enthusiastic about software engineering but needs more hands-on project experience.', 'Complete portfolio project by March 1; schedule follow-up in 2 weeks.'),
  ('a1111111-1111-1111-1111-111111111111', '2025-02-03', 30, 'Checked progress on LeetCode practice. Student is consistent. Discussed internship application strategy.', 'Apply to 5 internships this month; review CV together next session.')
on conflict (id) do nothing;

insert into assessment_responses (student_id, dimension, question_key, answer_value, answer_score) values
  ('a2222222-2222-2222-2222-222222222222', 'interests', 'creative_work', 'Strong interest', 8),
  ('a2222222-2222-2222-2222-222222222222', 'interests', 'communication', 'Very strong', 9),
  ('a2222222-2222-2222-2222-222222222222', 'strengths', 'interpersonal', 'Very strong', 8),
  ('a2222222-2222-2222-2222-222222222222', 'skills', 'content_writing', 'Advanced', 7),
  ('a2222222-2222-2222-2222-222222222222', 'values', 'creativity', 'Very important', 9),
  ('a2222222-2222-2222-2222-222222222222', 'preferences', 'industry', 'Media / Advertising', 8)
on conflict (id) do nothing;

insert into career_profiles (student_id, interests, strengths, skills, values, career_preferences, summary, summary_source, summary_confidence, review_status) values
  ('a2222222-2222-2222-2222-222222222222',
   '{creative_work, communication, branding}',
   '{interpersonal, persuasion, storytelling}',
   '{content_writing, social_media, public_speaking}',
   '{creativity, collaboration, growth}',
   'Wants to work in media/advertising, values creative freedom',
   'Creative and communicative profile with strong interpersonal skills. Well-suited for brand marketing or content strategy roles.',
   'rule_based_scoring', 0.83, 'unreviewed')
on conflict (id) do nothing;

insert into career_directions (student_id, career_path, fit_score, fit_reasoning, reasoning_source, reasoning_confidence, review_status) values
  ('a2222222-2222-2222-2222-222222222222', 'Brand Manager', 0.85, 'Strong creative interest and communication skills align well with brand management in advertising.', 'rule_based', 0.80, 'unreviewed'),
  ('a2222222-2222-2222-2222-222222222222', 'Content Strategist', 0.80, 'Content writing skills and creative values match content strategy roles.', 'rule_based', 0.76, 'unreviewed'),
  ('a2222222-2222-2222-2222-222222222222', 'Social Media Manager', 0.72, 'Social media skills and communication strength match, but broader career growth may be limited.', 'rule_based', 0.68, 'unreviewed')
on conflict (id) do nothing;