-- Schema DDL
CREATE TABLE "USERS" (
    "USER_ID" INT,
    "USERNAME" TEXT,
    "STATUS" TEXT,
    "LAST_LOGIN" DATE,
    PRIMARY KEY ("USER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO USERS VALUES (-1, 6, 4, NULL);
INSERT INTO USERS VALUES (0, 7, 5, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT username FROM Users WHERE NOT last_login IS NULL AND NOT status IN ('BANNED', 'SUSPENDED');

/*
Gold Result:
('7',)
*/

-- Prediction Query
SELECT username FROM Users WHERE NOT status IN ('BANNED', 'SUSPENDED');

/*
Prediction Result:
('6',)
('7',)
*/