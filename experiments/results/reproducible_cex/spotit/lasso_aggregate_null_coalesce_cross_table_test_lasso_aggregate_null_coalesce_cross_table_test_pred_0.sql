-- Schema DDL
CREATE TABLE "CHESTS" (
    "CHEST_ID" INT,
    "AMOUNT" INT,
    PRIMARY KEY ("CHEST_ID")
);
CREATE TABLE "BOXES" (
    "BOX_ID" INT,
    "CHEST_ID" INT,
    "AMOUNT" INT,
    PRIMARY KEY ("BOX_ID"),
    FOREIGN KEY ("CHEST_ID") REFERENCES "CHESTS"("CHEST_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CHESTS VALUES (0, NULL);
INSERT INTO CHESTS VALUES (1, 1);
INSERT INTO BOXES VALUES (-1, 0, NULL);
INSERT INTO BOXES VALUES (0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(amount) FROM (SELECT amount FROM boxes UNION ALL SELECT c.amount FROM chests AS c INNER JOIN boxes AS b ON b.chest_id = c.chest_id);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(COALESCE(b.amount, 0) + COALESCE(c.amount, 0)) FROM boxes AS b LEFT JOIN chests AS c ON c.chest_id = b.chest_id;

/*
Prediction Result:
(0,)
*/