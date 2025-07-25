CREATE OR ALTER PROCEDURE dbo.sp_SaveVoucher
    @VoucherDate DATE,
    @VoucherType NVARCHAR(50),
    @ReferenceNo NVARCHAR(100),
    @Narration NVARCHAR(500),
    @CreatedBy NVARCHAR(450),
    @VoucherDetails dbo.VoucherDetailType READONLY
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @VoucherMasterID BIGINT;

        INSERT INTO dbo.VoucherMaster (VoucherDate, VoucherType, ReferenceNo, Narration, CreatedBy)
        VALUES (@VoucherDate, @VoucherType, @ReferenceNo, @Narration, @CreatedBy);

        SET @VoucherMasterID = SCOPE_IDENTITY();

        INSERT INTO dbo.VoucherDetails (VoucherMasterID, AccountID, DebitAmount, CreditAmount)
        SELECT @VoucherMasterID, AccountID, DebitAmount, CreditAmount
        FROM @VoucherDetails;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Re-throw the error to the calling application
        THROW;
    END CATCH
END
GO