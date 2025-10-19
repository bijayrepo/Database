CREATE PROCEDURE [dbo].[UpdateUser]
    @UserID UNIQUEIDENTIFIER,
    @FullName NVARCHAR(100) = NULL,
    @Username NVARCHAR(50) = NULL,
    @Email NVARCHAR(100) = NULL,
    @Password NVARCHAR(100) = NULL  -- plain text password
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Hash password if provided
        DECLARE @HashedPassword VARBINARY(256) = NULL;
        IF @Password IS NOT NULL
        BEGIN
            SET @HashedPassword = HASHBYTES('SHA2_256', CONVERT(VARBINARY(MAX), @Password));
        END

        -- Update the user
        UPDATE [dbo].[Users]
        SET
            FullName = COALESCE(@FullName, FullName),
            Username = COALESCE(@Username, Username),
            Email = COALESCE(@Email, Email),
            Password = COALESCE(@HashedPassword, Password),
            UpdatedAt = GETDATE()
        WHERE UserID = @UserID;

        -- Return updated user
        SELECT *
        FROM [dbo].[Users]
        WHERE UserID = @UserID;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
