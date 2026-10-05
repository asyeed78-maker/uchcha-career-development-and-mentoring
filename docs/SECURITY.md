# Security

## Secret Handling
- Supabase URL + anon key in frontend (safe for RLS-protected reads).
- Supabase service role key in server-side code only (`.env.local`), never imported in client components.
- No secrets in client bundles; verify with build output inspection.

## Permission Model
- **v1 (demo):** All tables permissive — anonymous read/write. Seed data visible. No login required.
- **Lock-down sprint:** RLS enabled with owner-scoped policies. Students see only their own rows (`auth.uid() = user_id`). Counselor role sees all student-related rows. Enforced at Postgres RLS level, not in app code.
- Role check: counselor flag on a profiles table or custom claim — checked server-side.

## Approved-Tools Rule
- Only the five named tools in the agentic layer may execute automated actions.
- No raw SQL execution from frontend — all DB access through `lib/data/` functions.
- No arbitrary `run_any` / `send_any` patterns.

## Audit Principle
- Every automated action (profile generation, direction matching, roadmap creation, recommendation draft) writes an audit_log row with actor, action, target, and timestamp.
- Counselor manual actions (recommendation published, session logged, task status changed) also logged.
- Logs are append-only; no update or delete on audit table.

## Data Safety
- No student PII exposed in client-side error messages.
- Assessment responses never logged in plaintext to console or external services.
- If AI layer is called, only dimension scores and tags are sent — never raw PII.