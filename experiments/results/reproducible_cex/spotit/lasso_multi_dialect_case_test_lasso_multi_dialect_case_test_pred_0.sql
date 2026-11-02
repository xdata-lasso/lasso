-- Schema DDL
CREATE TABLE "ITEMS" (
    "ID" INT,
    "COST" FLOAT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ITEMS VALUES (-2147483647, 10);
INSERT INTO ITEMS VALUES (-2147483648, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM items WHERE cost > 10.0;

/*
Gold Result:
*/

-- Prediction Query
SELECT id FROM items WHERE cost >= 10.0;

/*
Prediction Result:
(-2147483647,)
*/