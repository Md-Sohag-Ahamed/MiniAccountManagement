CREATE OR ALTER PROCEDURE dbo.sp_CheckUserHasVouchers
    @UserId NVARCHAR(450)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CAST(
        CASE WHEN EXISTS (SELECT 1 FROM dbo.VoucherMaster WHERE CreatedBy = @UserId)
        THEN 1
        ELSE 0
    END AS BIT);
END
GO