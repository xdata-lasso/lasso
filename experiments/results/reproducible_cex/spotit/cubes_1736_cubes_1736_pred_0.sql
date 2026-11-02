-- Schema DDL
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "AGE" INT,
    "NAME" TEXT,
    "NATIONALITY" TEXT,
    "GRADUATION_COLLEGE" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);
CREATE TABLE "COMPANY" (
    "COMPANY_ID" FLOAT,
    "NAME" TEXT,
    "HEADQUARTERS" TEXT,
    "INDUSTRY" TEXT,
    "SALES_IN_BILLION" FLOAT,
    "PROFITS_IN_BILLION" FLOAT,
    "ASSETS_IN_BILLION" FLOAT,
    "MARKET_VALUE_IN_BILLION" FLOAT,
    PRIMARY KEY ("COMPANY_ID")
);
CREATE TABLE "EMPLOYMENT" (
    "COMPANY_ID" INT,
    "PEOPLE_ID" INT,
    "YEAR_WORKING" INT,
    PRIMARY KEY ("COMPANY_ID", "PEOPLE_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID"),
    FOREIGN KEY ("COMPANY_ID") REFERENCES "COMPANY"("COMPANY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PEOPLE VALUES (1, NULL, 50, NULL, 51);
INSERT INTO PEOPLE VALUES (0, NULL, 52, NULL, NULL);
INSERT INTO COMPANY VALUES (0, -4, NULL, 14, 15, 16, 17, NULL);
INSERT INTO COMPANY VALUES (-1, -3, 19, NULL, 21, 22, NULL, NULL);
INSERT INTO EMPLOYMENT VALUES (-1, 0, 0);
INSERT INTO EMPLOYMENT VALUES (0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, n AS count___ FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, LHS.people_id AS people_id, LHS.year_working AS year_working, RHS.age AS age, RHS.nationality AS nationality, RHS.n AS n FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, RHS.people_id AS people_id, RHS.year_working AS year_working FROM company AS LHS INNER JOIN employment AS RHS ON (LHS.company_id = RHS.company_id)) AS LHS CROSS JOIN (SELECT age, nationality, COUNT(*) AS n FROM people GROUP BY age, nationality) AS RHS) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('-3', 2)
('-4', 2)
*/

-- Prediction Query
SELECT T3.Name, COUNT(*) FROM employment AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID JOIN company AS T3 ON T1.Company_ID = T3.Company_ID GROUP BY T3.Name;

/*
Prediction Result:
('-3', 1)
('-4', 1)
*/