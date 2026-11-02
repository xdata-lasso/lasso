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
INSERT INTO MANUFACTURERS VALUES (1, -1, 0, 12, 30205);
INSERT INTO MANUFACTURERS VALUES (0, 0, 0, 6, NULL);
INSERT INTO PRODUCTS VALUES (0, 0, 0, 0);
INSERT INTO PRODUCTS VALUES (1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, revenue AS max_revenue_, headquarter FROM (SELECT headquarter, name, MAX(revenue) AS revenue FROM manufacturers GROUP BY headquarter, name) ORDER BY name, max_revenue_ NULLS LAST, headquarter NULLS LAST;

/*
Gold Result:
('-1', 30205.0, '0')
('0', None, '0')
*/

-- Prediction Query
SELECT name, MAX(revenue), Headquarter FROM manufacturers GROUP BY Headquarter;

/*
Prediction Result:
('-1', 30205.0, '0')
*/