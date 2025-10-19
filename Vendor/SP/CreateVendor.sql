CREATE PROCEDURE [dbo].[CreateVendorWithUser]
    -- Vendor Parameters
    @CompanyName NVARCHAR(100),
    @ContactName NVARCHAR(100),
    @ContactEmail NVARCHAR(100),
    @ContactPhone NVARCHAR(20) = NULL,
    @Address NVARCHAR(200) = NULL,
    @City NVARCHAR(50) = NULL,
    @State NVARCHAR(50) = NULL,
    @Country NVARCHAR(50) = NULL,
    @GSTNumber NVARCHAR(20) = NULL,
    @PANNumber NVARCHAR(20) = NULL,
    
    -- User Parameters
    @UserFullName NVARCHAR(100),
    @Username NVARCHAR(50),
    @UserEmail NVARCHAR(100),
    @Password NVARCHAR(256)  -- store hashed password
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Step 1: Create Vendor
        DECLARE @NewVendorID UNIQUEIDENTIFIER = NEWID();

        INSERT INTO [dbo].[Vendors] (
            [VendorID], [CompanyName], [ContactName], [ContactEmail], [ContactPhone], 
            [Address], [City], [State], [Country], [GSTNumber], [PANNumber]
        )
        VALUES (
            @NewVendorID, @CompanyName, @ContactName, @ContactEmail, @ContactPhone,
            @Address, @City, @State, @Country, @GSTNumber, @PANNumber
        );

        -- Step 2: Create User linked to this vendor
        DECLARE @NewUserID UNIQUEIDENTIFIER = NEWID();

        INSERT INTO [dbo].[Users] (
            [UserID], [VendorID], [FullName], [Username], [Email], [Password]
        )
        VALUES (
            @NewUserID, @NewVendorID, @UserFullName, @Username, @UserEmail, @Password
        );

        -- Commit transaction
        COMMIT TRANSACTION;

        -- Return both IDs
        SELECT 
            @NewVendorID AS VendorID,
            @NewUserID AS UserID;

    END TRY
    BEGIN CATCH
        -- Rollback in case of error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Return error info
        THROW;
    END CATCH
END
