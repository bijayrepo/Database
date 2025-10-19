CREATE TABLE [dbo].[Vendors] (
    [VendorID]     UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [CompanyName]  NVARCHAR (100)   NOT NULL,
    [ContactName]  NVARCHAR (100)   NOT NULL,
    [ContactEmail] NVARCHAR (100)   NOT NULL,
    [ContactPhone] NVARCHAR (20)    NULL,
    [Address]      NVARCHAR (200)   NULL,
    [City]         NVARCHAR (50)    NULL,
    [State]        NVARCHAR (50)    NULL,
    [Country]      NVARCHAR (50)    NULL,
    [GSTNumber]    NVARCHAR (20)    NULL,
    [PANNumber]    NVARCHAR (20)    NULL,
    [CreatedAt]    DATETIME         DEFAULT (getdate()) NULL,
    [UpdatedAt]    DATETIME         NULL,
    PRIMARY KEY CLUSTERED ([VendorID] ASC)
);

