-- Schema DDL
CREATE TABLE "PRODUCTS" (
    "ID" INT,
    "CATEGORY" TEXT,
    "PRICE" FLOAT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PRODUCTS VALUES (-1, 0, 11);
INSERT INTO PRODUCTS VALUES (0, 1, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC, category NULLS LAST LIMIT 5;

/*
Gold Result:
('0', 1)
('1', 1)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products ORDER BY COUNT(*) DESC, Products.id NULLS LAST LIMIT 5;

/*
Prediction Result:
('0', 2)
*/