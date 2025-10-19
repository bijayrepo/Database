CREATE TABLE [dbo].[Users] (
    [UserID]    UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [FullName]  NVARCHAR (100)   NOT NULL,
    [Username]  NVARCHAR (50)    NOT NULL,
    [Email]     NVARCHAR (100)   NOT NULL,
    [Password]  NVARCHAR (256)   NOT NULL,
    [CreatedAt] DATETIME         DEFAULT (getdate()) NULL,
    [UpdatedAt] DATETIME         NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC),
    UNIQUE NONCLUSTERED ([Username] ASC)
);

