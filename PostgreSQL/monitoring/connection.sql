-- ------------------ find out all avelavel connection --------------------------------------------------------

select pid as process_id, 
       usename as username, 
       datname as database_name, 
       client_addr as client_address, 
       application_name,
       backend_start,
       state,
       state_change
from pg_stat_activity;

select usename, count(*) from pg_stat_activity where state = 'idle' group by usename;

-- ---------------- drop all idle connection ------------------------------------

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE state = 'idle';