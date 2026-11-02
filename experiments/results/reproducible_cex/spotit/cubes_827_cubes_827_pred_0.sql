-- Schema DDL
CREATE TABLE "MANUFACTURER" (
    "MANUFACTURER_ID" INT,
    "OPEN_YEAR" FLOAT,
    "NAME" TEXT,
    "NUM_OF_FACTORIES" INT,
    "NUM_OF_SHOPS" INT,
    PRIMARY KEY ("MANUFACTURER_ID")
);
CREATE TABLE "FURNITURE" (
    "FURNITURE_ID" INT,
    "NAME" TEXT,
    "NUM_OF_COMPONENT" INT,
    "MARKET_RATE" FLOAT,
    PRIMARY KEY ("FURNITURE_ID")
);
CREATE TABLE "FURNITURE_MANUFACTE" (
    "MANUFACTURER_ID" INT,
    "FURNITURE_ID" INT,
    "PRICE_IN_DOLLAR" FLOAT,
    PRIMARY KEY ("MANUFACTURER_ID", "FURNITURE_ID"),
    FOREIGN KEY ("FURNITURE_ID") REFERENCES "FURNITURE"("FURNITURE_ID"),
    FOREIGN KEY ("MANUFACTURER_ID") REFERENCES "MANUFACTURER"("MANUFACTURER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MANUFACTURER VALUES (1, 39, 40, 0, 0);
INSERT INTO MANUFACTURER VALUES (0, 41, 42, 0, 0);
INSERT INTO FURNITURE VALUES (0, 0, 0, 0);
INSERT INTO FURNITURE VALUES (1, 0, 0, 0);
INSERT INTO FURNITURE_MANUFACTE VALUES (1, 0, 1);
INSERT INTO FURNITURE_MANUFACTE VALUES (0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manufacturer_id, num_of_shops FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.open_year AS open_year, LHS.name AS name, LHS.num_of_factories AS num_of_factories, LHS.num_of_shops AS num_of_shops, RHS.price_in_dollar AS price_in_dollar FROM manufacturer AS LHS INNER JOIN furniture_manufacte AS RHS ON (LHS.manufacturer_id = RHS.manufacturer_id AND LHS.num_of_shops = RHS.furniture_id)) ORDER BY manufacturer_id, num_of_shops NULLS LAST;

/*
Gold Result:
(0, 0)
(1, 0)
*/

-- Prediction Query
SELECT t1.manufacturer_id, t1.num_of_shops FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id = t2.manufacturer_id ORDER BY t2.Price_in_Dollar DESC, t1.manufacturer_id NULLS LAST, t2.manufacturer_id NULLS LAST, t2.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 0)
*/