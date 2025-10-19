CREATE TABLE [dbo].[UserLog] (
    [LogID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    [UserID] UNIQUEIDENTIFIER NOT NULL,
    [VendorID] UNIQUEIDENTIFIER NULL,
    [FullName] NVARCHAR(100) NULL,
    [Username] NVARCHAR(50) NULL,
    [Email] NVARCHAR(100) NULL,
    [Password] NVARCHAR(256) NULL,
    [ActionType] NVARCHAR(10) NOT NULL, -- INSERT / UPDATE / DELETE
    [ActionDate] DATETIME DEFAULT GETDATE(),
    [ActionBy] NVARCHAR(100) NULL      -- optional: store who made the change
);
