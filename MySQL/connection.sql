-- -- -- -- show number of connection -- -- -- --- --
SHOW STATUS LIKE 'max_used_connections';

-- -- -- show all connection -- -- -- --- -- 
show full processlist;


-- Step 1: Identify idle sessions
-- This query selects details of sessions that are in 'Sleep' state from the INFORMATION_SCHEMA.PROCESSLIST table.
-- The 'Sleep' state indicates that the session is idle and waiting for a new command.

-- The selected columns are:
-- - id: The unique session identifier (process ID or thread ID).
-- - user: The MySQL user who owns the session.
-- - host: The host name and port of the client that initiated the session.
-- - db: The default database for the session, if any.
-- - command: The type of command the session is executing (should be 'Sleep' for idle sessions).
-- - time: The duration in seconds that the session has been in its current state.
-- - state: A more detailed state of the session (e.g., 'Waiting for table metadata lock').
-- - info: The text of the statement being executed, if any.

SELECT id, user, host, db, command, time, state, info
FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE command = 'Sleep';

-- Step 2: Generate KILL commands for idle sessions
-- This query generates SQL commands to terminate (KILL) the sessions identified in Step 1.
-- The CONCAT function is used to create a KILL command for each session ID.
-- The result is a list of KILL commands, one for each idle session.

-- The generated commands need to be executed separately to terminate the sessions.

SELECT CONCAT('KILL ', id, ';') AS kill_command
FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE command = 'Sleep';

-- Example output for the above query:
-- +---------------+
-- | kill_command  |
-- +---------------+
-- | KILL 123;     |
-- | KILL 456;     |
-- +---------------+

-- To terminate the idle sessions, you need to execute the output commands:
-- KILL 123;
-- KILL 456;

-- Note:
-- - Be cautious when using the KILL command, as it will terminate the specified session immediately.
-- - Terminating sessions may disrupt ongoing processes and lead to data loss if not handled properly.
-- - It is recommended to review the sessions before executing the KILL commands to ensure no critical sessions are terminated.

-- Optional: Automate the process of killing idle sessions
-- The following stored procedure automates the identification and termination of idle sessions.

DELIMITER //

CREATE PROCEDURE kill_idle_sessions()
BEGIN
    -- Declare variables for cursor control
    DECLARE done INT DEFAULT FALSE;
    DECLARE session_id INT;

    -- Declare a cursor to select idle session IDs
    DECLARE cur CURSOR FOR 
        SELECT id 
        FROM INFORMATION_SCHEMA.PROCESSLIST 
        WHERE command = 'Sleep';

    -- Declare a handler for when the cursor reaches the end of the result set
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN cur;

    -- Loop through the result set
    read_loop: LOOP
        -- Fetch the next session ID into the session_id variable
        FETCH cur INTO session_id;
        
        -- If no more rows, exit the loop
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Prepare and execute the KILL command for the current session_id
        SET @kill_query = CONCAT('KILL ', session_id);
        PREPARE stmt FROM @kill_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END //

DELIMITER ;

-- To call the stored procedure and terminate all idle sessions
CALL kill_idle_sessions();

-- Note:
-- - This stored procedure should be used with caution.
-- - Ensure that terminating idle sessions will not disrupt critical activities.
-- - It is recommended to review and possibly log the sessions before termination.
