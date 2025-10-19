CREATE PROCEDURE [dbo].[UpdateUserDocument]
    @UserID UNIQUEIDENTIFIER,
    @DocumentType NVARCHAR(50),    -- e.g., 'ProfilePicture', 'IDProof', 'Other'
    @NewDocumentURL NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Update the document URL and set UpdatedAt
        UPDATE [dbo].[UserDocuments]
        SET 
            DocumentURL = @NewDocumentURL,
            UpdatedAt = GETDATE()
        WHERE UserID = @UserID
          AND DocumentType = @DocumentType;

        -- Return the updated document info
        SELECT *
        FROM [dbo].[UserDocuments]
        WHERE UserID = @UserID
          AND DocumentType = @DocumentType;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
