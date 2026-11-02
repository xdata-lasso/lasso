-- Schema DDL
CREATE TABLE "COMPANY" (
    "COMPANY_ID" INT,
    "RANK" INT,
    "COMPANY" TEXT,
    "HEADQUARTERS" TEXT,
    "MAIN_INDUSTRY" TEXT,
    "SALES_BILLION" FLOAT,
    "PROFITS_BILLION" FLOAT,
    "ASSETS_BILLION" FLOAT,
    "MARKET_VALUE" FLOAT,
    PRIMARY KEY ("COMPANY_ID")
);
CREATE TABLE "GAS_STATION" (
    "STATION_ID" INT,
    "OPEN_YEAR" INT,
    "LOCATION" TEXT,
    "MANAGER_NAME" TEXT,
    "VICE_MANAGER_NAME" TEXT,
    "REPRESENTATIVE_NAME" TEXT,
    PRIMARY KEY ("STATION_ID")
);
CREATE TABLE "STATION_COMPANY" (
    "STATION_ID" INT,
    "COMPANY_ID" INT,
    "RANK_OF_THE_YEAR" INT,
    PRIMARY KEY ("COMPANY_ID", "STATION_ID"),
    FOREIGN KEY ("COMPANY_ID") REFERENCES "COMPANY"("COMPANY_ID"),
    FOREIGN KEY ("STATION_ID") REFERENCES "GAS_STATION"("STATION_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COMPANY VALUES (-1, 0, 2, 27, 28, 29, 35, 30, 31);
INSERT INTO COMPANY VALUES (0, 0, 2, 32, 33, 34, 35, 36, 37);
INSERT INTO GAS_STATION VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO GAS_STATION VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO STATION_COMPANY VALUES (0, 0, 0);
INSERT INTO STATION_COMPANY VALUES (1, -1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, n AS count___ FROM (SELECT company, profits_billion, COUNT(*) AS n FROM (SELECT LHS.company_id AS company_id, LHS.rank AS rank, LHS.company AS company, LHS.headquarters AS headquarters, LHS.main_industry AS main_industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value AS market_value, RHS.station_id AS station_id, RHS.rank_of_the_year AS rank_of_the_year FROM company AS LHS INNER JOIN station_company AS RHS ON (LHS.company_id = RHS.company_id)) GROUP BY company, profits_billion) ORDER BY company, count___ NULLS LAST;

/*
Gold Result:
('2', 2)
*/

-- Prediction Query
SELECT T2.company, COUNT(*) FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id GROUP BY T1.company_id;

/*
Prediction Result:
('2', 1)
('2', 1)
*/