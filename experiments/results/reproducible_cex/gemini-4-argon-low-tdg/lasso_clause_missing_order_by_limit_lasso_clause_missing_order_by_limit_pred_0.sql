-- Schema DDL
CREATE TABLE "USERS" ("ID" INTEGER PRIMARY KEY, "SCORE" INTEGER, "NAME" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by SCORE DESC, LIMIT 1, and out-of-order insertion where ID order opposes SCORE order.
INSERT INTO USERS (ID, SCORE, NAME) VALUES (1, 100, 'Alice');
INSERT INTO USERS (ID, SCORE, NAME) VALUES (2, 300, 'Bob');
INSERT INTO USERS (ID, SCORE, NAME) VALUES (3, 200, 'Charlie');
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