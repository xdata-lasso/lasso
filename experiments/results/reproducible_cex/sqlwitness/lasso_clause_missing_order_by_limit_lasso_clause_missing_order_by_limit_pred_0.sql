-- Schema DDL
CREATE TABLE "USERS" ("ID" INTEGER PRIMARY KEY, "SCORE" INTEGER, "NAME" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (id, score, name) VALUES (0, NULL, 'default2'), (1, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM USERS ORDER BY SCORE DESC, USERS.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT NAME FROM USERS LIMIT 1;

/*
Prediction Result:
('default2',)
*/