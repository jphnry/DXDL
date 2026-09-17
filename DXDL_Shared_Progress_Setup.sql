-- Run in the SQL editor of the Supabase project that will hold DXDL progress.
-- Public viewers may read completion state. Only allowlisted signed-in editors may change it.

create table if not exists public.playbook_editors (
  email text primary key,
  constraint editor_email_lowercase check (email = lower(email))
);

create table if not exists public.playbook_progress (
  task_id text primary key,
  completed boolean not null default false,
  updated_at timestamptz not null default now(),
  constraint task_id_length check (length(task_id) between 3 and 100)
);

alter table public.playbook_editors enable row level security;
alter table public.playbook_progress enable row level security;

revoke all on public.playbook_editors from anon, authenticated;
revoke all on public.playbook_progress from anon, authenticated;
grant select on public.playbook_editors to authenticated;
grant select on public.playbook_progress to anon, authenticated;
grant insert, update on public.playbook_progress to authenticated;

drop policy if exists "Editor can check their own access" on public.playbook_editors;
create policy "Editor can check their own access"
on public.playbook_editors for select to authenticated
using (email = lower((select auth.jwt() ->> 'email')));

drop policy if exists "Anyone can view progress" on public.playbook_progress;
create policy "Anyone can view progress"
on public.playbook_progress for select to anon, authenticated
using (true);

drop policy if exists "Editors can add progress" on public.playbook_progress;
create policy "Editors can add progress"
on public.playbook_progress for insert to authenticated
with check (exists (
  select 1 from public.playbook_editors e
  where e.email = lower((select auth.jwt() ->> 'email'))
));

drop policy if exists "Editors can update progress" on public.playbook_progress;
create policy "Editors can update progress"
on public.playbook_progress for update to authenticated
using (exists (
  select 1 from public.playbook_editors e
  where e.email = lower((select auth.jwt() ->> 'email'))
))
with check (exists (
  select 1 from public.playbook_editors e
  where e.email = lower((select auth.jwt() ->> 'email'))
));

-- After running this script, add the actual editor email addresses in the
-- playbook_editors table in the Supabase Table Editor. Use lowercase emails.
-- Do not put a service_role / secret key into the GitHub Pages HTML.
