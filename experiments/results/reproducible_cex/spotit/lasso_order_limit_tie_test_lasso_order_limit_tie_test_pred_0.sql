-- Schema DDL
CREATE TABLE "ITEMS" (
    "ID" INT,
    "SCORE" INT,
    "VAL" FLOAT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ITEMS VALUES (1, NULL, NULL);
INSERT INTO ITEMS VALUES (0, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val FROM items ORDER BY score DESC, items.id NULLS LAST LIMIT 1;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT val FROM items WHERE score = (SELECT MAX(score) FROM items);

/*
Prediction Result:
*/