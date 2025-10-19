CREATE TRIGGER [dbo].[TR_Users_Log]
ON [dbo].[Users]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Log INSERT
    INSERT INTO [dbo].[UserLog] (UserID, VendorID, FullName, Username, Email, Password, ActionType)
    SELECT UserID, VendorID, FullName, Username, Email, Password, 'INSERT'
    FROM inserted
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.UserID = inserted.UserID);

    -- Log UPDATE
    INSERT INTO [dbo].[UserLog] (UserID, VendorID, FullName, Username, Email, Password, ActionType)
    SELECT i.UserID, i.VendorID, i.FullName, i.Username, i.Email, i.Password, 'UPDATE'
    FROM inserted i
    INNER JOIN deleted d ON i.UserID = d.UserID
    WHERE
        ISNULL(i.FullName,'') <> ISNULL(d.FullName,'')
        OR ISNULL(i.Username,'') <> ISNULL(d.Username,'')
        OR ISNULL(i.Email,'') <> ISNULL(d.Email,'')
        OR ISNULL(i.Password,'') <> ISNULL(d.Password,'');

    -- Log DELETE
    INSERT INTO [dbo].[UserLog] (UserID, VendorID, FullName, Username, Email, Password, ActionType)
    SELECT UserID, VendorID, FullName, Username, Email, Password, 'DELETE'
    FROM deleted
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.UserID = deleted.UserID);
END
