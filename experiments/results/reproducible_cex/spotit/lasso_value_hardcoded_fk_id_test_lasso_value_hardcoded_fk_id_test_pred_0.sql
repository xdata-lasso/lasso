-- Schema DDL
CREATE TABLE "CATEGORIES" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "PRODUCTS" (
    "ID" INT,
    "CAT_ID" INT,
    "TITLE" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("CAT_ID") REFERENCES "CATEGORIES"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CATEGORIES VALUES (0, 10);
INSERT INTO CATEGORIES VALUES (8, 7184221363661875895);
INSERT INTO PRODUCTS VALUES (0, 8, 9);
INSERT INTO PRODUCTS VALUES (1, 8, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.title FROM products AS p JOIN categories AS c ON p.cat_id = c.id WHERE c.name = 'Electronics';

/*
Gold Result:
*/

-- Prediction Query
SELECT p.title FROM products AS p WHERE p.cat_id = 7;

/*
Prediction Result:
*/