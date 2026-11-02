-- Schema DDL
CREATE TABLE "FILM" (
    "FILM_ID" INT,
    "TITLE" TEXT,
    "STUDIO" TEXT,
    "DIRECTOR" TEXT,
    "GROSS_IN_DOLLAR" INT,
    PRIMARY KEY ("FILM_ID")
);
CREATE TABLE "MARKET" (
    "MARKET_ID" INT,
    "COUNTRY" TEXT,
    "NUMBER_CITIES" INT,
    PRIMARY KEY ("MARKET_ID")
);
CREATE TABLE "FILM_MARKET_ESTIMATION" (
    "ESTIMATION_ID" INT,
    "MARKET_ID" INT,
    "FILM_ID" INT,
    "LOW_ESTIMATE" FLOAT,
    "HIGH_ESTIMATE" FLOAT,
    "TYPE" TEXT,
    "YEAR" INT,
    PRIMARY KEY ("ESTIMATION_ID"),
    FOREIGN KEY ("MARKET_ID") REFERENCES "MARKET"("MARKET_ID"),
    FOREIGN KEY ("FILM_ID") REFERENCES "FILM"("FILM_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO FILM VALUES (-2147483648, 0, 0, 0, -2147483648);
INSERT INTO FILM VALUES (-2147483647, 0, 0, 0, -2147483648);
INSERT INTO MARKET VALUES (-2147483648, 12, 2);
INSERT INTO MARKET VALUES (-2147483647, 15, 0);
INSERT INTO FILM_MARKET_ESTIMATION VALUES (-2147483648, -2147483647, -2147483647, 10002, 13, 14, -2147483648);
INSERT INTO FILM_MARKET_ESTIMATION VALUES (-2147483647, -2147483648, -2147483647, 10001, 20, 21, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meannumber_cities AS avg_t2_number_cities_ FROM (SELECT film_id, low_estimate, AVG(number_cities) AS meannumber_cities FROM (SELECT LHS.market_id AS market_id, LHS.country AS country, LHS.number_cities AS number_cities, RHS.estimation_id AS estimation_id, RHS.low_estimate AS low_estimate, RHS.high_estimate AS high_estimate, RHS.film_id AS film_id, RHS.type AS TYPE, RHS.year AS YEAR FROM market AS LHS INNER JOIN (SELECT * FROM film_market_estimation WHERE (low_estimate > 10000.0)) AS RHS ON (LHS.market_id = RHS.market_id)) GROUP BY film_id, low_estimate) ORDER BY avg_t2_number_cities_;

/*
Gold Result:
(0.0,)
(2.0,)
*/

-- Prediction Query
SELECT AVG(T2.Number_cities) FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID = T2.Market_ID WHERE T1.Low_Estimate > 10000;

/*
Prediction Result:
(1.0,)
*/