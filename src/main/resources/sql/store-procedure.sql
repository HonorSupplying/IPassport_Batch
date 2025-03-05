-- Clear Activity Log
CREATE PROCEDURE sp_clear_activity_log
AS
BEGIN
    DECLARE @ThresholdYears INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdYears = CAST(config_value AS INT) FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'DataRetentionYear';

    -- Default to 3 years if no value is found
    IF @ThresholdYears IS NULL
        SET @ThresholdYears = 3;

    -- Start transaction
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_ACTIVITY_LOG
        WHERE record_created_date < DATEADD(YEAR, -@ThresholdYears, GETDATE());

        -- Commit transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of error
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage,16,1);
    END CATCH
END;
GO

-- Clear Audit Trail Log
CREATE PROCEDURE sp_clear_audit_trail
AS
BEGIN
    DECLARE @ThresholdYears INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdYears = CAST(config_value AS INT) FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'DataRetentionYear';

    -- Default to 24 hours if no value is found
    IF @ThresholdYears IS NULL
        SET @ThresholdYears = 3;

    BEGIN TRY
        -- Start transaction
        BEGIN TRANSACTION;

        DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_AUDIT_TRAIL
        WHERE record_created_date < DATEADD(YEAR, -@ThresholdYears, GETDATE());

        -- Commit transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
            -- Rollback transaction in case of error
            ROLLBACK TRANSACTION;

            DECLARE @ErrorMessage NVARCHAR(4000);
            SET @ErrorMessage = ERROR_MESSAGE();
            RAISERROR(@ErrorMessage,16,1);
    END CATCH
END;
GO

-- Clear Transaction Log
CREATE PROCEDURE sp_clear_transaction_log
AS
BEGIN
    DECLARE @ThresholdYears INT;

    -- Retrieve the threshold hours from the database
   SELECT @ThresholdYears = CAST(config_value AS INT) FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'DataRetentionYear';

    -- Default to 3 years if no value is found
    IF @ThresholdYears IS NULL
        SET @ThresholdYears = 3;

    BEGIN TRY
        -- Commit transaction
        BEGIN TRANSACTION;

        DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_TRANSACTION
        WHERE record_created_date < DATEADD(YEAR, -@ThresholdYears, GETDATE());

        -- Commit transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of error
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage,16,1);
    END CATCH
END;
GO

-- Mark Expire
CREATE PROCEDURE sp_mark_expire
AS
BEGIN

    BEGIN TRY
            -- Start transaction
            BEGIN TRANSACTION;

            UPDATE IPASSPORTDDB.dbo.IPRO_TX_TRANSACTION
            SET transaction_status = 'E'
            WHERE transaction_status IN ('N', 'U');

            -- Commit transaction
            COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of error
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage,16,1);
    END CATCH

END;
GO


-- Clear Passport Table
CREATE PROCEDURE sp_clear_passportid
AS
BEGIN
    DECLARE @ThresholdHours INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdHours = CAST(config_value AS INT) FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'DailyClearHour';

    -- Default to 24 hours if no value is found
    IF @ThresholdHours IS NULL
        SET @ThresholdHours = 24;

    BEGIN TRY
        -- Start transaction
        BEGIN TRANSACTION;

        DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_PASSPORTID
        WHERE DATEDIFF(HOUR, record_created_date, GETDATE()) > @ThresholdHours;

        -- Commit transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of error
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage,16,1);
    END CATCH
END;
GO

-- Clear Thai Id Table
CREATE PROCEDURE sp_clear_thaiid
AS
BEGIN
    DECLARE @ThresholdHours INT;

    -- Retrieve the threshold hours from the database
    SELECT @ThresholdHours = CAST(config_value AS INT) FROM IPASSPORTDDB.dbo.IPRO_TX_BATCHCONFIG WHERE config_key = 'DailyClearHour';

    -- Default to 24 hours if no value is found
    IF @ThresholdHours IS NULL
        SET @ThresholdHours = 24;

    BEGIN TRY
        -- Start transaction
        BEGIN TRANSACTION;

        DELETE FROM IPASSPORTDDB.dbo.IPRO_TX_THAIID
        WHERE DATEDIFF(HOUR, record_created_date, GETDATE()) > @ThresholdHours;

        -- Commit transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of error
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage,16,1);
    END CATCH

END;
GO