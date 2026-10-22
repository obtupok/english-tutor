-- Личный бот-репетитор английского. Выполнить в Supabase → SQL Editor (можно повторно — ничего не сломается).
-- Состояние разговора (одна строка — владелец; общая для бота и сайта)
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
alter table public.english_tutor add column if not exists stats jsonb not null default '{}';   -- {days: {'2026-10-22': 14}}
alter table public.english_tutor enable row level security;   -- доступ только у функции (service role)

-- Новые слова из разговоров + интервальное повторение
create table if not exists public.english_words (
  id          bigserial primary key,
  key         text not null unique,                -- слово в нижнем регистре
  word        text not null,
  translation text not null,
  example     text,
  added       timestamptz not null default now(),
  due         timestamptz not null default now(),
  ivl         real not null default 0,             -- интервал в днях
  ease        real not null default 2.5,
  reps        int  not null default 0
);
alter table public.english_words enable row level security;

-- Исправленные ошибки
create table if not exists public.english_mistakes (
  id       bigserial primary key,
  original text not null,
  fixed    text not null,
  notes    jsonb not null default '[]',
  at       timestamptz not null default now()
);
alter table public.english_mistakes enable row level security;

-- Голос Yomi (Orpheus в Groq): hannah | diana | autumn | troy | austin | daniel
alter table public.english_tutor add column if not exists speaker text not null default 'hannah';

-- Характер Yomi: kind | cute | angry | funny | sleepy
alter table public.english_tutor add column if not exists persona text not null default 'kind';
