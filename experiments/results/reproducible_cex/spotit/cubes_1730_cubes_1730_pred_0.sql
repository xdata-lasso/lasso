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
INSERT INTO PEOPLE VALUES (-1, NULL, 18, 19, 20);
INSERT INTO PEOPLE VALUES (0, 0, NULL, 22, 23);
INSERT INTO COMPANY VALUES (0, NULL, 8, NULL, 200, 10, 11, 12);
INSERT INTO COMPANY VALUES (1, NULL, 15, 13, 200, 14, 16, 17);
INSERT INTO EMPLOYMENT VALUES (1, -1, 0);
INSERT INTO EMPLOYMENT VALUES (0, -1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name FROM (SELECT LHS.company_id AS company_id, LHS.people_id AS people_id, LHS.year_working AS year_working, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, RHS.age AS age, RHS.name AS name_other, RHS.nationality AS nationality, RHS.graduation_college AS graduation_college FROM (SELECT LHS.company_id AS company_id, LHS.people_id AS people_id, LHS.year_working AS year_working, RHS.name AS name, RHS.headquarters AS headquarters, RHS.industry AS industry, RHS.sales_in_billion AS sales_in_billion, RHS.profits_in_billion AS profits_in_billion, RHS.assets_in_billion AS assets_in_billion, RHS.market_value_in_billion AS market_value_in_billion FROM employment AS LHS LEFT JOIN company AS RHS ON (LHS.company_id = RHS.company_id)) AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) WHERE (sales_in_billion >= 200.0) ORDER BY name;

/*
Gold Result:
('18',)
('18',)
*/

-- Prediction Query
SELECT T2.Name FROM employment AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID JOIN company AS T3 ON T1.Company_ID = T3.Company_ID WHERE T3.Sales_in_Billion > 200;

/*
Prediction Result:
*/