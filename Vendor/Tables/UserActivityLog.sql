CREATE TABLE UserActivityLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(50),
    action_time DATETIME
);