-- Schema DDL
CREATE TABLE "A" (
    "ID" INT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "B" (
    "A_ID" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO A VALUES (0);
INSERT INTO A VALUES (-1);
INSERT INTO B VALUES (0);
INSERT INTO B VALUES (0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.id FROM A LEFT JOIN B ON A.id = B.a_id;

/*
Gold Result:
(0,)
(0,)
(-1,)
*/

-- Prediction Query
SELECT A.id FROM A INNER JOIN B ON A.id = B.a_id;

/*
Prediction Result:
(0,)
(0,)
*/