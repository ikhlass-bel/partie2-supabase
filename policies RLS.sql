create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null check (role in ('admin','analyst','customer_service','customer')),
  created_at timestamptz default now()
);

alter table public.profiles enable row level security;

insert into public.profiles (id, role)
values
  ('df4e0f78-e2f4-4976-a34d-d9fccd8291d0', 'admin'),
  ('da94d0ce-59a9-433d-b024-5f69c85133f9', 'analyst'),
  ('d34374e6-d8ec-4288-84b6-b8eb6d56b84c', 'customer_service'),
  ('c722a53e-0ca6-402c-b344-d3a49dee3304', 'customer')
on conflict (id) do update set role = excluded.role;


alter table public.customers
add column if not exists user_id uuid;

alter table public.customers enable row level security;
alter table public.accounts enable row level security;
alter table public.cards enable row level security;
alter table public.transactions enable row level security;


create or replace function public.current_role()
returns text
language sql
stable
as $$
  select role from public.profiles where id = auth.uid()
$$;

drop policy if exists "customers_select_policy" on public.customers;

create policy "customers_select_policy"
on public.customers
for select
using (
  public.current_role() in ('admin','analyst','customer_service')
  OR (public.current_role() = 'customer' and customers.user_id = auth.uid())
);
drop policy if exists "customers_select_policy" on public.customers;


drop policy if exists "customers_select_policy" on public.customers;

create policy "customers_select_policy"
on public.customers
for select
using (
  public.current_role() in ('admin','analyst','customer_service')
  OR (public.current_role() = 'customer' and customers.user_id = auth.uid())
);


drop policy if exists "accounts_select_policy" on public.accounts;

create policy "accounts_select_policy"
on public.accounts
for select
using (
  public.current_role() in ('admin','analyst','customer_service')
  OR (
    public.current_role() = 'customer'
    and exists (
      select 1 from public.customers c
      where c.customer_id = accounts.customer_id
        and c.user_id = auth.uid()
    )
  )
);


drop policy if exists "transactions_select_policy" on public.transactions;

create policy "transactions_select_policy"
on public.transactions
for select
using (
  public.current_role() in ('admin','analyst','customer_service')
  OR (
    public.current_role() = 'customer'
    and exists (
      select 1
      from public.accounts a
      join public.customers c on c.customer_id = a.customer_id
      where a.account_id = transactions.account_id
        and c.user_id = auth.uid()
    )
  )
);


drop policy if exists "cards_update_policy" on public.cards;

create policy "cards_update_policy"
on public.cards
for update
using (
  public.current_role() in ('admin','customer_service')
)
with check (
  public.current_role() in ('admin','customer_service')
);
