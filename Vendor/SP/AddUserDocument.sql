CREATE PROCEDURE [dbo].[AddUserDocument]
    @UserID UNIQUEIDENTIFIER,
    @DocumentType NVARCHAR(50),  -- e.g., 'ProfilePicture', 'IDProof', 'Other'
    @DocumentURL NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [dbo].[UserDocuments] (
            [UserID],
            [DocumentType],
            [DocumentURL],
            [UploadedAt]
        )
        VALUES (
            @UserID,
            @DocumentType,
            @DocumentURL,
            GETDATE()
        );

        -- Return the newly inserted document info
        SELECT TOP 1 *
        FROM [dbo].[UserDocuments]
        WHERE UserID = @UserID
        ORDER BY UploadedAt DESC;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
