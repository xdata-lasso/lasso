-- Schema DDL
CREATE TABLE "PERSON" (
    "ID" INT,
    "EMAIL" TEXT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PERSON VALUES (0, 7);
INSERT INTO PERSON VALUES (-1, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.EMAIL FROM PERSON AS P WHERE P.ID IN (SELECT P1.ID FROM PERSON AS P1 WHERE 1 < (SELECT COUNT(*) FROM PERSON AS P2 WHERE P1.EMAIL = P2.EMAIL)) GROUP BY P.EMAIL;

/*
Prediction Result:
*/