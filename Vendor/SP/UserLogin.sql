CREATE PROCEDURE [dbo].[UserLogin]
    @UsernameOrEmail NVARCHAR(100),
    @Password NVARCHAR(100)  -- plain text input
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Hash the input password
        DECLARE @HashedPassword VARBINARY(256);
        SET @HashedPassword = HASHBYTES('SHA2_256', CONVERT(VARBINARY(MAX), @Password));

        -- Check if user exists with matching username/email and password
        SELECT 
            UserID,
            VendorID,
            FullName,
            Username,
            Email,
            CreatedAt,
            UpdatedAt
        FROM [dbo].[Users]
        WHERE 
            (Username = @UsernameOrEmail OR Email = @UsernameOrEmail)
            AND Password = @HashedPassword;
        
        -- Optional: return a message if login fails
        IF @@ROWCOUNT = 0
        BEGIN
            SELECT 'Login failed: Invalid username/email or password.' AS Message;
        END

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
