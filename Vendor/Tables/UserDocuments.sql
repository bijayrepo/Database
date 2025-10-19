CREATE TABLE [dbo].[UserDocuments] (
    [DocumentID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    [UserID] UNIQUEIDENTIFIER NOT NULL,           -- foreign key to Users
    [DocumentType] NVARCHAR(50) NOT NULL,        -- e.g., 'ProfilePicture', 'IDProof', 'Other'
    [DocumentURL] NVARCHAR(500) NOT NULL,        -- URL or file path
    [UploadedAt] DATETIME DEFAULT GETDATE(),     -- timestamp
    [UpdatedAt] DATETIME NULL,                   -- timestamp for updates
    CONSTRAINT FK_UserDocuments_Users FOREIGN KEY ([UserID])
        REFERENCES [dbo].[Users]([UserID])
        ON DELETE CASCADE
);
