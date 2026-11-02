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
INSERT INTO MANUFACTURERS VALUES (-1, 0, 0, 0, 0);
INSERT INTO MANUFACTURERS VALUES (0, 0, 0, 0, 0);
INSERT INTO PRODUCTS VALUES (1, -1, 0, 0);
INSERT INTO PRODUCTS VALUES (0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price AS min_price_ FROM (SELECT LHS.name AS name, LHS.price AS price, RHS.code AS code, RHS.manufacturer AS manufacturer FROM (SELECT name, MIN(price) AS price FROM products GROUP BY name) AS LHS LEFT JOIN products AS RHS ON (LHS.name = RHS.name AND LHS.price = RHS.price)) ORDER BY code, name NULLS LAST, min_price_ NULLS LAST;

/*
Gold Result:
(0, '0', 0.0)
(1, '0', 0.0)
*/

-- Prediction Query
SELECT code, name, MIN(price) FROM products GROUP BY name;

/*
Prediction Result:
(1, '0', 0.0)
*/