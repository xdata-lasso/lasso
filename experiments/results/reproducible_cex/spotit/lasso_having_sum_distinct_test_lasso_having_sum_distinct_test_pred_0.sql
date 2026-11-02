-- Schema DDL
CREATE TABLE "ITEMS" (
    "O_ID" INT,
    "LINE_ID" INT,
    "QTY" FLOAT,
    PRIMARY KEY ("O_ID", "LINE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ITEMS VALUES (0, 0, 151);
INSERT INTO ITEMS VALUES (0, 1, 151);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(qty) > 300;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT o_id FROM items GROUP BY o_id HAVING SUM(DISTINCT qty) > 300;

/*
Prediction Result:
*/