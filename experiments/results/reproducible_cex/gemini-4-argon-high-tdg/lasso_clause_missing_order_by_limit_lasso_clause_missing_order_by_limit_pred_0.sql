-- Schema DDL
CREATE TABLE "USERS" ("ID" INTEGER PRIMARY KEY, "SCORE" INTEGER, "NAME" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO USERS (ID, SCORE, NAME) VALUES (1, 9, 'Zoe');
INSERT INTO USERS (ID, SCORE, NAME) VALUES (2, 50, 'Alice');
INSERT INTO USERS (ID, SCORE, NAME) VALUES (3, 100, 'David');
INSERT INTO USERS (ID, SCORE, NAME) VALUES (4, 60, 'Alice');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM USERS ORDER BY SCORE DESC, USERS.id NULLS LAST LIMIT 1;

/*
Gold Result:
('David',)
*/

-- Prediction Query
SELECT NAME FROM USERS LIMIT 1;

/*
Prediction Result:
('Zoe',)
*/