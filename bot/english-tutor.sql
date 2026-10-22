-- Личный бот-репетитор английского: состояние разговора. Выполнить один раз в Supabase → SQL Editor.
create table if not exists public.english_tutor (
  chat_id    bigint primary key,
  mode       text not null default 'free',        -- free | test | coach | scenario
  scene      text not null default 'smalltalk',
  level      text,                                 -- A1…C2 после теста
  voice      boolean not null default true,        -- отвечать голосом
  history    jsonb not null default '[]',          -- последние реплики [{role, text}]
  plan       jsonb,                                -- {level, summary, plan[], at}
  updated_at timestamptz not null default now()
);
alter table public.english_tutor enable row level security;   -- доступ только у функции (service role)
