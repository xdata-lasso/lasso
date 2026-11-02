-- Schema DDL
CREATE TABLE "PARTSUPP" (
    "PS_ID" INT,
    "PS_COST" FLOAT,
    PRIMARY KEY ("PS_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PARTSUPP VALUES (-1, NULL);
INSERT INTO PARTSUPP VALUES (0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ps_id FROM partsupp WHERE ps_cost = (SELECT MIN(ps_cost) FROM partsupp);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT ps_id FROM partsupp;

/*
Prediction Result:
(-1,)
(0,)
*/