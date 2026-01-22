create table public.audit_logs (
  log_id serial primary key,
  user_id uuid,
  action varchar(100),
  table_name varchar(50),
  record_id int,
  ip_address varchar(45),
  created_at timestamptz default now()
);


create or replace function public.get_customers_audited()
returns setof public.customers
language plpgsql
security definer
as $$
begin
  insert into public.audit_logs (
    user_id,
    action,
    table_name,
    record_id,
    ip_address
  )
  select
    auth.uid(),
    'VIEW_CUSTOMER',
    'customers',
    customer_id,
    inet_client_addr()::text
  from public.customers;

  return query
  select * from public.customers;
end;
$$;


select * from public.get_customers_audited();
