-- Clear Activity Log
CREATE PROCEDURE sp_clear_activity_log
AS
BEGIN
    DECLARE @ThresholdYears INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdYears = config_value FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'dataRetentionYearThreshold';

    -- Default to 24 hours if no value is found
    IF @ThresholdYears IS NULL
        SET @ThresholdYears = 3;

    -- Start transaction
    BEGIN TRANSACTION;

    DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_ACTIVITY_LOG
    WHERE DATEDIFF(YEAR, record_created_date, GETDATE()) > @ThresholdYears;

    -- Commit transaction
    COMMIT TRANSACTION;

END;
GO

-- Clear Audit Trail Log
CREATE PROCEDURE sp_clear_audit_trail
AS
BEGIN
    DECLARE @ThresholdYears INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdYears = config_value FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'dataRetentionYearThreshold';

    -- Default to 24 hours if no value is found
    IF @ThresholdYears IS NULL
        SET @ThresholdYears = 3;

    -- Start transaction
    BEGIN TRANSACTION;

    DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_AUDIT_TRAIL
    WHERE DATEDIFF(YEAR, record_created_date, GETDATE()) > @ThresholdYears;

    -- Commit transaction
    COMMIT TRANSACTION;

END;
GO

-- Clear Transaction Log
CREATE PROCEDURE sp_clear_transaction_log
AS
BEGIN
    DECLARE @ThresholdYears INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdYears = config_value FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'dataRetentionYearThreshold';

    -- Default to 24 hours if no value is found
    IF @ThresholdYears IS NULL
        SET @ThresholdYears = 3;

    -- Commit transaction
    COMMIT TRANSACTION;

    DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_TRANSACTION
    WHERE DATEDIFF(YEAR, record_created_date, GETDATE()) > @ThresholdYears;

    -- Commit transaction
    COMMIT TRANSACTION;

END;
GO

-- Data Retention
CREATE PROCEDURE sp_data_retention
AS
BEGIN

    -- Declare variables
    DECLARE @BackupDirectory NVARCHAR(500);
    DECLARE @BackupPath NVARCHAR(500);
    DECLARE @Command NVARCHAR(1000);

    -- Retrieve the backup path from a configuration table
    SELECT @BackupDirectory = config_value FROM IPRO_TX_BATCHCONFIG WHERE config_key = 'archivePath';

    -- Ensure there's a valid backup directory; otherwise, use a default path
    IF @BackupDirectory IS NULL OR @BackupDirectory = ''
        SET @BackupDirectory = 'C:\Backups\';

    -- Generate the backup file name with the current date
    SET @BackupPath = @BackupDirectory + 'ipassport_' + CONVERT(NVARCHAR, GETDATE(), 112) + '.bak';

    -- Backup the database
    BACKUP DATABASE IPASSPORTDDB TO DISK = @BackupPath WITH FORMAT;


    -- Clear the data from the tables (excluding IPRO_TX_THAIID)
--    DELETE FROM IPRO_TX_TRANSACTION;
--    DELETE FROM IPRO_TX_AUDIT_TRAIL;
--    DELETE FROM IPRO_TX_ACTIVITY_LOG;
END;
GO

-- Mark Expire
CREATE PROCEDURE sp_mark_expire
AS
BEGIN
    DECLARE @ThresholdHours INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdHours = config_value FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'markExpireHourThreshold';

    -- Default to 24 hours if no value is found
    IF @ThresholdHours IS NULL
        SET @ThresholdHours = 3;

    UPDATE IPASSPORTDDB.dbo.IPRO_TX_TRANSACTION
    SET transaction_status = 'E'
    WHERE DATEDIFF(HOUR, record_created_date, GETDATE()) > @ThresholdHours AND transaction_status = 'N';

END;
GO

-- Clear Passport Table
CREATE PROCEDURE sp_clear_passportid
AS
BEGIN
    DECLARE @ThresholdHours INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdHours = config_value FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'dataClearHourThreshold';

    -- Default to 24 hours if no value is found
    IF @ThresholdHours IS NULL
        SET @ThresholdHours = 24;

    -- Start transaction
    BEGIN TRANSACTION;

    DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_PASSPORTID
    WHERE DATEDIFF(HOUR, record_created_date, GETDATE()) > @ThresholdHours;

    -- Commit transaction
    COMMIT TRANSACTION;

END;
GO

-- Clear Thai Id Table
CREATE PROCEDURE sp_clear_thaiid
AS
BEGIN
    DECLARE @ThresholdHours INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdHours = config_value FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'dataClearHourThreshold';

    -- Default to 24 hours if no value is found
    IF @ThresholdHours IS NULL
        SET @ThresholdHours = 24;

    -- Commit transaction
    COMMIT TRANSACTION;

    DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_THAIID
    WHERE DATEDIFF(HOUR, record_created_date, GETDATE()) > @ThresholdHours;

    -- Commit transaction
    COMMIT TRANSACTION;

END;
GO