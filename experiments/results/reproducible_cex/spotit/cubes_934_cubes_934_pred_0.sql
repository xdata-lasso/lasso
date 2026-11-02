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
INSERT INTO MANUFACTURERS VALUES (1, 0, 0, 0, 0);
INSERT INTO PRODUCTS VALUES (0, 0, NULL, NULL);
INSERT INTO PRODUCTS VALUES (-1, 1, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM (SELECT * FROM (SELECT * FROM products ORDER BY price, products.code NULLS LAST) LIMIT 1);

/*
Gold Result:
('0', None)
*/

-- Prediction Query
SELECT name, price FROM Products ORDER BY price ASC, Products.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('0', None)
*/