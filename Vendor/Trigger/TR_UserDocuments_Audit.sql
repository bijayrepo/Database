CREATE TRIGGER [dbo].[TR_UserDocuments_Audit]
ON [dbo].[UserDocuments]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- INSERT: log new documents
        INSERT INTO [dbo].[UserDocumentsLog] (DocumentID, UserID, DocumentType, NewDocumentURL, ActionType, ActionDate)
        SELECT i.DocumentID, i.UserID, i.DocumentType, i.DocumentURL, 'INSERT', GETDATE()
        FROM inserted i
        LEFT JOIN deleted d ON i.DocumentID = d.DocumentID
        WHERE d.DocumentID IS NULL;

        -- UPDATE: log changes
        INSERT INTO [dbo].[UserDocumentsLog] (DocumentID, UserID, DocumentType, OldDocumentURL, NewDocumentURL, ActionType, ActionDate)
        SELECT d.DocumentID, d.UserID, d.DocumentType, d.DocumentURL, i.DocumentURL, 'UPDATE', GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.DocumentID = d.DocumentID
        WHERE ISNULL(i.DocumentURL,'') <> ISNULL(d.DocumentURL,'');

        -- DELETE: log deleted documents
        INSERT INTO [dbo].[UserDocumentsLog] (DocumentID, UserID, DocumentType, OldDocumentURL, ActionType, ActionDate)
        SELECT d.DocumentID, d.UserID, d.DocumentType, d.DocumentURL, 'DELETE', GETDATE()
        FROM deleted d
        LEFT JOIN inserted i ON d.DocumentID = i.DocumentID
        WHERE i.DocumentID IS NULL;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
