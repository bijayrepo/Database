CREATE PROCEDURE [dbo].[DeleteUserDocument]
    @UserID UNIQUEIDENTIFIER,
    @DocumentType NVARCHAR(50)  -- e.g., 'ProfilePicture', 'IDProof', 'Other'
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Capture the document to be deleted
        DECLARE @DeletedDoc TABLE (
            DocumentID UNIQUEIDENTIFIER,
            UserID UNIQUEIDENTIFIER,
            DocumentType NVARCHAR(50),
            DocumentURL NVARCHAR(500),
            UploadedAt DATETIME,
            UpdatedAt DATETIME
        );

        INSERT INTO @DeletedDoc
        SELECT *
        FROM [dbo].[UserDocuments]
        WHERE UserID = @UserID
          AND DocumentType = @DocumentType;

        -- Delete the document
        DELETE FROM [dbo].[UserDocuments]
        WHERE UserID = @UserID
          AND DocumentType = @DocumentType;

        -- Optional: return deleted document info
        SELECT * FROM @DeletedDoc;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
