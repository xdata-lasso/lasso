-- Schema DDL
CREATE TABLE "USERS" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "POSTS" (
    "ID" INT,
    "USER_ID" INT,
    "TITLE" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("USER_ID") REFERENCES "USERS"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO USERS VALUES (0, 7);
INSERT INTO USERS VALUES (-1, 9);
INSERT INTO POSTS VALUES (0, 0, 8);
INSERT INTO POSTS VALUES (1, 0, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, p.title FROM users AS u LEFT JOIN posts AS p ON u.id = p.user_id;

/*
Gold Result:
('7', '10')
('7', '8')
('9', None)
*/

-- Prediction Query
SELECT u.name, p.title FROM users AS u CROSS JOIN posts AS p ON u.id = p.user_id;

/*
Prediction Result:
('7', '10')
('7', '8')
*/