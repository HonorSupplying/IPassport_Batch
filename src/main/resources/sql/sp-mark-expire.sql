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

--    -- Update
--    UPDATE IPASSPORTDDB.dbo.IPRO_TX_TRANSACTION
--    SET record_updated_date = GETDATE()
--    WHERE DATEDIFF(HOUR, record_timestamp, GETDATE()) > @ThresholdHours;

END;
GO