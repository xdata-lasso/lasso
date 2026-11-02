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
INSERT INTO PRODUCTS VALUES (0, 1, 0, 201);
INSERT INTO PRODUCTS VALUES (1, 1, 0, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE (price < 200.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM products WHERE price <= 200;

/*
Prediction Result:
('0',)
*/