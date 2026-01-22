alter table profiles enable row level security;

create policy "customer can read own profile"
on profiles for select
to authenticated
using (auth.uid() = id);

alter table transactions enable row level security;

create policy "customer reads own transactions"
on transactions for select
to authenticated
using (
  exists (
    select 1
    from accounts a
    join profiles p on p.customer_id = a.customer_id
    where a.account_id = transactions.account_id
      and p.id = auth.uid()
      and p.role = 'customer'
  )
);
create policy "analyst reads all transactions"
on transactions for select
to authenticated
using (
  exists (
    select 1 from profiles p
    where p.id = auth.uid()
      and p.role in ('analyst','admin')
  )
);