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