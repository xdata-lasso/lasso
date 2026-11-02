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
INSERT INTO MANUFACTURERS VALUES (1, 0, 0, 0, 150);
INSERT INTO MANUFACTURERS VALUES (0, 0, 0, 0, 99);
INSERT INTO PRODUCTS VALUES (0, 1, 0, 0);
INSERT INTO PRODUCTS VALUES (1, 1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM manufacturers WHERE (revenue >= 100.0 AND revenue < 150.0) ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue BETWEEN 100 AND 150;

/*
Prediction Result:
('0',)
*/