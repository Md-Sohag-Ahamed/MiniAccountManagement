CREATE TABLE dbo.VoucherDetails
(
    VoucherDetailID BIGINT PRIMARY KEY IDENTITY(1,1),
    VoucherMasterID BIGINT NOT NULL,
    AccountID INT NOT NULL,
    DebitAmount DECIMAL(18, 2) NOT NULL DEFAULT 0,
    CreditAmount DECIMAL(18, 2) NOT NULL DEFAULT 0,

    FOREIGN KEY (VoucherMasterID) REFERENCES dbo.VoucherMaster(VoucherMasterID) ON DELETE CASCADE,
    FOREIGN KEY (AccountID) REFERENCES dbo.ChartOfAccounts(AccountID)
);
GO