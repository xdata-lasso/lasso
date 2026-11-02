-- Schema DDL
CREATE TABLE "MANUFACTURERS" (
    "CODE" INT,
    "NAME" TEXT,
    "HEADQUARTER" TEXT,
    "FOUNDER" TEXT,
    "REVENUE" FLOAT,
    PRIMARY KEY ("CODE")
);
CREATE TABLE "PRODUCTS" (
    "CODE" INT,
    "MANUFACTURER" INT,
    "NAME" TEXT,
    "PRICE" FLOAT,
    PRIMARY KEY ("CODE"),
    FOREIGN KEY ("MANUFACTURER") REFERENCES "MANUFACTURERS"("CODE")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MANUFACTURERS VALUES (0, 0, 0, 0, 0);
INSERT INTO MANUFACTURERS VALUES (-1, 0, 0, 0, 0);
INSERT INTO PRODUCTS VALUES (-1, -1, 26, NULL);
INSERT INTO PRODUCTS VALUES (0, -1, 27, -4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM (SELECT LHS.price AS price, RHS.code AS code, RHS.name AS name, RHS.manufacturer AS manufacturer FROM (SELECT MIN(price) AS price FROM products) AS LHS LEFT JOIN products AS RHS ON (LHS.price = RHS.price)) ORDER BY name, price NULLS LAST;

/*
Gold Result:
('27', -4.0)
*/

-- Prediction Query
SELECT name, price FROM Products ORDER BY price ASC, Products.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('26', None)
*/