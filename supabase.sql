-- My Life Dashboard cloud database (Supabase/PostgreSQL)
create table if not exists public.life_dashboard (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.life_dashboard enable row level security;
drop policy if exists "Users can read their dashboard" on public.life_dashboard;
drop policy if exists "Users can insert their dashboard" on public.life_dashboard;
drop policy if exists "Users can update their dashboard" on public.life_dashboard;
create policy "Users can read their dashboard" on public.life_dashboard for select using (auth.uid() = user_id);
create policy "Users can insert their dashboard" on public.life_dashboard for insert with check (auth.uid() = user_id);
create policy "Users can update their dashboard" on public.life_dashboard for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
