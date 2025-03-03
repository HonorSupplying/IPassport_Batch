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