-- ------------------------------------------------------------------------------------
-- Query: Find All Available Connections and Their Details
-- Description: This query retrieves information about all current connections to the PostgreSQL database.

-- COLUMN description 
-- Process ID of the connection.
-- Username of the connected user.
-- Name of the database to which the user is connected.
-- Client's IP address.
-- Name of the application connected to the database.
-- Timestamp when the backend process was started.
-- Current state of the connection (e.g., active, idle).
-- Timestamp of the last state change.
-- ------------------------------------------------------------------------------------
select pid as process_id, 
       usename as username, 
       datname as database_name, 
       client_addr as client_address, 
       application_name,
       backend_start,
       state,
       state_change
from pg_stat_activity;

-- ------------------------------------------------------------------------------------
-- Query: Count Idle Connections by Username
-- Description: This query counts the number of idle connections for each username.

-- COLUMN description
-- Username of the connected user.
-- Count of idle connections for each user.
-- ------------------------------------------------------------------------------------
select usename, 
count(*) 
from pg_stat_activity 
where state = 'idle' 
group by usename;

-- ------------------------------------------------------------------------------------
-- Query: Terminate All Idle Connections
-- Description: This query terminates all connections that are in the 'idle' state.

-- Function to terminate a backend process given its process ID.
-- ------------------------------------------------------------------------------------
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE state = 'idle';