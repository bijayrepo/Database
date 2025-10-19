CREATE PROCEDURE [dbo].[UpdateUserDocument]
    @UserID UNIQUEIDENTIFIER,
    @DocumentType NVARCHAR(50),
    @NewDocumentURL NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF EXISTS (
            SELECT 1 
            FROM [dbo].[UserDocuments]
            WHERE [UserID] = @UserID AND [DocumentType] = @DocumentType
        )
        BEGIN
            UPDATE [dbo].[UserDocuments]
            SET 
                [DocumentURL] = @NewDocumentURL,
                [UpdatedAt] = GETDATE()
            WHERE 
                [UserID] = @UserID
                AND [DocumentType] = @DocumentType;
        END
        ELSE
        BEGIN
            INSERT INTO [dbo].[UserDocuments] (
                [UserID], [DocumentType], [DocumentURL]
            )
            VALUES (
                @UserID, @DocumentType, @NewDocumentURL
            );
        END

        -- Return the updated/inserted record
        SELECT 
            [DocumentID],
            [UserID],
            [DocumentType],
            [DocumentURL],
            [UploadedAt],
            [UpdatedAt]
        FROM [dbo].[UserDocuments]
        WHERE [UserID] = @UserID AND [DocumentType] = @DocumentType;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
