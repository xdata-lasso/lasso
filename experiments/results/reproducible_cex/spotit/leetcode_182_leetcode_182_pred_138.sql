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
SELECT DISTINCT EMAIL AS EMAIL FROM PERSON AS A WHERE 2 <= (SELECT COUNT(*) FROM PERSON AS B WHERE A.EMAIL = B.EMAIL);

/*
Prediction Result:
*/