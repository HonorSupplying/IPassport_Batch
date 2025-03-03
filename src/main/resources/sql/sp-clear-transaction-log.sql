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
    WHERE DATEDIFF(HOUR, record_created_date, GETDATE()) > @ThresholdYears;

    -- Commit transaction
    COMMIT TRANSACTION;


END;
GO