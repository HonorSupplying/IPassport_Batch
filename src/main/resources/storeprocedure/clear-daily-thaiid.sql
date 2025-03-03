CREATE PROCEDURE sp_clear_thaiid
AS
BEGIN
    DECLARE @ThresholdHours INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdHours = config_value FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'dataClearHourThreshold';

    -- Default to 24 hours if no value is found
    IF @ThresholdHours IS NULL
        SET @ThresholdHours = 24;

    DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_THAIID
    WHERE DATEDIFF(HOUR, record_created_date, GETDATE()) > @ThresholdHours;
END;
GO