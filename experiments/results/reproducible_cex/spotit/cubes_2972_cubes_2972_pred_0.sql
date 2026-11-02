-- Schema DDL
CREATE TABLE "BUILDINGS" (
    "ID" INT,
    "NAME" TEXT,
    "CITY" TEXT,
    "HEIGHT" INT,
    "STORIES" INT,
    "STATUS" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "COMPANIES" (
    "ID" INT,
    "NAME" TEXT,
    "HEADQUARTERS" TEXT,
    "INDUSTRY" TEXT,
    "SALES_BILLION" FLOAT,
    "PROFITS_BILLION" FLOAT,
    "ASSETS_BILLION" FLOAT,
    "MARKET_VALUE_BILLION" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "OFFICE_LOCATIONS" (
    "BUILDING_ID" INT,
    "COMPANY_ID" INT,
    "MOVE_IN_YEAR" INT,
    PRIMARY KEY ("COMPANY_ID", "BUILDING_ID"),
    FOREIGN KEY ("COMPANY_ID") REFERENCES "COMPANIES"("ID"),
    FOREIGN KEY ("BUILDING_ID") REFERENCES "BUILDINGS"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO BUILDINGS VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO BUILDINGS VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO COMPANIES VALUES (2, 17, 18, -1, 19, 22, 20, 21);
INSERT INTO COMPANIES VALUES (1, 10, 11, 0, 12, 13, 14, 15);
INSERT INTO OFFICE_LOCATIONS VALUES (0, 2, 0);
INSERT INTO OFFICE_LOCATIONS VALUES (0, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT industry FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value_billion AS market_value_billion FROM companies AS LHS INNER JOIN (SELECT profits_billion, COUNT(*) AS n FROM companies GROUP BY profits_billion) AS RHS ON (LHS.id = RHS.n AND LHS.profits_billion = RHS.profits_billion)) ORDER BY industry;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC, Industry NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/