-- Schema DDL
CREATE TABLE "USERS" ("ID" INTEGER PRIMARY KEY, "SCORE" INTEGER, "NAME" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO USERS (ID, SCORE, NAME) VALUES (1, 10, 'Alice');
INSERT INTO USERS (ID, SCORE, NAME) VALUES (2, 100, 'Bob');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM USERS ORDER BY SCORE DESC, USERS.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT NAME FROM USERS LIMIT 1;

/*
Prediction Result:
('Alice',)
*/