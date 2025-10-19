CREATE PROCEDURE [dbo].[DeleteUser]
    @UserID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Optional: capture the user before deletion
        DECLARE @DeletedUser TABLE (
            UserID UNIQUEIDENTIFIER,
            VendorID UNIQUEIDENTIFIER,
            FullName NVARCHAR(100),
            Username NVARCHAR(50),
            Email NVARCHAR(100),
            Password NVARCHAR(256),
            CreatedAt DATETIME,
            UpdatedAt DATETIME
        );

        INSERT INTO @DeletedUser
        SELECT *
        FROM [dbo].[Users]
        WHERE UserID = @UserID;

        -- Delete the user
        DELETE FROM [dbo].[Users]
        WHERE UserID = @UserID;

        -- Return deleted user info
        SELECT * FROM @DeletedUser;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
