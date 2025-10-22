-- Grant execute permission
GRANT EXECUTE ON dbo.YourStoredProcedure TO [UserName]

-- Grant execute to role
GRANT EXECUTE ON dbo.YourStoredProcedure TO [RoleName]

-- View permissions on a stored procedure
EXEC sp_helprotect 'dbo.YourStoredProcedure'

-- Check effective permissions
SELECT * FROM fn_my_permissions('dbo.YourStoredProcedure', 'OBJECT')




-- Create encrypted stored procedure
CREATE PROCEDURE dbo.EncryptedProcedure
WITH ENCRYPTION
AS
BEGIN
    SELECT * FROM SensitiveTable
END

-- Note: Once encrypted, the definition cannot be viewed
-- This prevents users from seeing the source code


-- Method 1: Using system views
SELECT 
    u.name AS UserName,
    p.name AS PrincipalName,
    p.type_desc AS PrincipalType,
    perm.permission_name,
    perm.state_desc AS PermissionState
FROM sys.database_permissions perm
    INNER JOIN sys.objects o ON perm.major_id = o.object_id
    LEFT JOIN sys.database_principals p ON perm.grantee_principal_id = p.principal_id
    LEFT JOIN sys.sysusers u ON p.sid = u.sid
WHERE o.name = 'YourStoredProcedure'
    AND o.type = 'P'

-- Method 2: Check role memberships
SELECT 
    r.name AS RoleName,
    m.name AS MemberName
FROM sys.database_role_members rm
    INNER JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
    INNER JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id
WHERE r.name IN (
    SELECT p.name
    FROM sys.database_permissions perm
        INNER JOIN sys.objects o ON perm.major_id = o.object_id
        INNER JOIN sys.database_principals p ON perm.grantee_principal_id = p.principal_id
    WHERE o.name = 'YourStoredProcedure'
        AND perm.permission_name = 'EXECUTE'
)

-- Method 3: Comprehensive access check
EXEC sp_helprotect 'YourStoredProcedure'



-- Show actual execution plan (SSMS)
-- Ctrl + M or Query -> Include Actual Execution Plan

-- Get estimated plan
SET SHOWPLAN_ALL ON
GO
EXEC YourStoredProcedure
GO
SET SHOWPLAN_ALL OFF

-- Get XML execution plan
SET STATISTICS XML ON
EXEC YourStoredProcedure
SET STATISTICS XML OFF


-- Analyze query performance
SELECT 
    total_elapsed_time / execution_count AS avg_elapsed_time,
    total_worker_time / execution_count AS avg_cpu_time,
    total_logical_reads / execution_count AS avg_logical_reads,
    total_physical_reads / execution_count AS avg_physical_reads,
    execution_count,
    SUBSTRING(st.text, (qs.statement_start_offset/2)+1, 
        ((CASE qs.statement_end_offset WHEN -1 THEN DATALENGTH(st.text)
          ELSE qs.statement_end_offset END - qs.statement_start_offset)/2) + 1) AS statement_text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
ORDER BY avg_elapsed_time DESC



-- Find missing indexes
SELECT 
    migs.avg_total_user_cost * (migs.avg_user_impact / 100.0) * (migs.user_seeks + migs.user_scans) AS improvement_measure,
    mid.statement AS database_object,
    mid.equality_columns,
    mid.inequality_columns,
    mid.included_columns
FROM sys.dm_db_missing_index_groups mig
    INNER JOIN sys.dm_db_missing_index_group_stats migs ON migs.group_handle = mig.index_group_handle
    INNER JOIN sys.dm_db_missing_index_details mid ON mig.index_handle = mid.index_handle
ORDER BY improvement_measure DESC




-- Check for implicit conversions
SELECT 
    s.text,
    qp.query_plan
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) s
CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp
WHERE qp.query_plan.exist('//*:Convert[@Implicit="1"]') = 1




-- Solutions for parameter sniffing:
-- Option 1: Use local variables
CREATE PROCEDURE dbo.FixParameterSniffing
    @Param1 INT
AS
BEGIN
    DECLARE @LocalParam1 INT = @Param1
    SELECT * FROM Table WHERE Column = @LocalParam1
END

-- Option 2: Use OPTIMIZE FOR
CREATE PROCEDURE dbo.FixParameterSniffing2
    @Param1 INT
AS
BEGIN
    SELECT * FROM Table 
    WHERE Column = @Param1
    OPTION (OPTIMIZE FOR (@Param1 UNKNOWN))
END


-- Find blocking
SELECT 
    blocking.session_id AS blocking_session_id,
    blocked.session_id AS blocked_session_id,
    wait.wait_type,
    wait.resource_description,
    blocking_text.text AS blocking_text,
    blocked_text.text AS blocked_text
FROM sys.dm_exec_connections blocking
    INNER JOIN sys.dm_exec_requests blocked ON blocking.session_id = blocked.blocking_session_id
    INNER JOIN sys.dm_os_waiting_tasks wait ON blocked.session_id = wait.session_id
    CROSS APPLY sys.dm_exec_sql_text(blocking.most_recent_sql_handle) blocking_text
    CROSS APPLY sys.dm_exec_sql_text(blocked.sql_handle) blocked_text





-- Local temp table
CREATE TABLE #TempEmployees (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    HireDate DATE
)

-- Create index on temp table
CREATE INDEX IX_TempEmployees_ID ON #TempEmployees(EmployeeID)

-- Insert data
INSERT INTO #TempEmployees
SELECT EmployeeID, Name, HireDate FROM Employees

-- Use in queries
SELECT * FROM #TempEmployees WHERE EmployeeID > 1000

-- Clean up (automatic at session end)
DROP TABLE #TempEmployees





-- Table variable
DECLARE @EmployeeTable TABLE (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    HireDate DATE
)

-- Insert data
INSERT INTO @EmployeeTable
SELECT EmployeeID, Name, HireDate FROM Employees

-- Use in queries
SELECT * FROM @EmployeeTable WHERE EmployeeID > 1000

-- No explicit cleanup needed


-- Example: Choose based on data size
IF @RecordCount > 1000
BEGIN
    -- Use temp table for large datasets
    CREATE TABLE #LargeData (ID INT, Data VARCHAR(100))
    INSERT INTO #LargeData SELECT ID, Data FROM SourceTable
    -- Complex processing...
END
ELSE
BEGIN
    -- Use table variable for small datasets
    DECLARE @SmallData TABLE (ID INT, Data VARCHAR(100))
    INSERT INTO @SmallData SELECT ID, Data FROM SourceTable
    -- Simple processing...
END