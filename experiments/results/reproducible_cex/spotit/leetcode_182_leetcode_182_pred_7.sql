-- Schema DDL
CREATE TABLE "PERSON" (
    "ID" INT,
    "EMAIL" TEXT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PERSON VALUES (0, 7);
INSERT INTO PERSON VALUES (1, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT P.EMAIL FROM PERSON AS P WHERE (SELECT COUNT(*) FROM PERSON AS P2 WHERE P.EMAIL = P2.EMAIL) > 1;

/*
Prediction Result:
*/