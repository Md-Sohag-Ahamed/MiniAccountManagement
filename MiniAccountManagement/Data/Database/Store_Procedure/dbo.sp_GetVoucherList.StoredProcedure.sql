CREATE OR ALTER PROCEDURE dbo.sp_GetVoucherList
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        vm.VoucherMasterID,
        vm.VoucherDate,
        vm.VoucherType,
        vm.ReferenceNo,
        vm.Narration,
        SUM(vd.DebitAmount) AS TotalAmount
    FROM
        dbo.VoucherMaster vm
    JOIN
        dbo.VoucherDetails vd ON vm.VoucherMasterID = vd.VoucherMasterID
    WHERE
        (@StartDate IS NULL OR vm.VoucherDate >= @StartDate)
        AND
        (@EndDate IS NULL OR vm.VoucherDate <= @EndDate)
    GROUP BY
        vm.VoucherMasterID,
        vm.VoucherDate,
        vm.VoucherType,
        vm.ReferenceNo,
        vm.Narration
    ORDER BY
        vm.VoucherDate DESC, vm.VoucherMasterID DESC;
END
GO