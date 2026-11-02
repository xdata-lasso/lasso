-- Schema DDL
CREATE TABLE "USERS" (
    "ID" INT,
    "SCORE" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO USERS VALUES (1, 0, 6);
INSERT INTO USERS VALUES (0, 0, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM USERS ORDER BY SCORE DESC, USERS.id NULLS LAST LIMIT 1;

/*
Gold Result:
('7',)
*/

-- Prediction Query
SELECT NAME FROM USERS LIMIT 1;

/*
Prediction Result:
('6',)
*/