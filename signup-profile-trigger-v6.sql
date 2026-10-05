create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  requested_username text;
  final_username text;
begin
  requested_username := lower(trim(new.raw_user_meta_data->>'username'));
  if requested_username ~ '^[a-z0-9_]{3,24}$' then
    final_username := requested_username;
  else
    final_username := 'user_' || substr(replace(new.id::text, '-', ''), 1, 12);
  end if;

  insert into public.profiles(id, username, display_name)
  values (
    new.id,
    final_username,
    coalesce(nullif(new.raw_user_meta_data->>'display_name',''), 'E-Message User')
  )
  on conflict(id) do nothing;
  return new;
end;
$$;

-- Recreate the auth trigger if it already exists.
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();
