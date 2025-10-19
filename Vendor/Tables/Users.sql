CREATE TABLE [dbo].[Users] (
    [UserID]    UNIQUEIDENTIFIER DEFAULT (NEWID()) NOT NULL,
    [VendorID]  UNIQUEIDENTIFIER NOT NULL, -- link to Vendors
    [FullName]  NVARCHAR(100)   NOT NULL,
    [Username]  NVARCHAR(50)    NOT NULL,
    [Email]     NVARCHAR(100)   NOT NULL,
    [Password]  NVARCHAR(256)   NOT NULL,
    [CreatedAt] DATETIME        DEFAULT (GETDATE()) NULL,
    [UpdatedAt] DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC),
    UNIQUE NONCLUSTERED ([Username] ASC),
    CONSTRAINT FK_Users_Vendors FOREIGN KEY ([VendorID]) 
        REFERENCES [dbo].[Vendors]([VendorID])
        ON DELETE CASCADE  -- optional, deletes users if vendor is deleted
);
