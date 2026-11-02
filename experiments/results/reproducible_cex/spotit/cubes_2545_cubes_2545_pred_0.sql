-- Schema DDL
CREATE TABLE "COUNTY" (
    "COUNTY_ID" INT,
    "COUNTY_NAME" TEXT,
    "POPULATION" FLOAT,
    "ZIP_CODE" TEXT,
    PRIMARY KEY ("COUNTY_ID")
);
CREATE TABLE "PARTY" (
    "PARTY_ID" INT,
    "YEAR" FLOAT,
    "PARTY" TEXT,
    "GOVERNOR" TEXT,
    "LIEUTENANT_GOVERNOR" TEXT,
    "COMPTROLLER" TEXT,
    "ATTORNEY_GENERAL" TEXT,
    "US_SENATE" TEXT,
    PRIMARY KEY ("PARTY_ID")
);
CREATE TABLE "ELECTION" (
    "ELECTION_ID" INT,
    "DISTRICT" INT,
    "PARTY" INT,
    "COUNTIES_REPRESENTED" TEXT,
    "DELEGATE" TEXT,
    "FIRST_ELECTED" FLOAT,
    "COMMITTEE" TEXT,
    PRIMARY KEY ("ELECTION_ID"),
    FOREIGN KEY ("DISTRICT") REFERENCES "COUNTY"("COUNTY_ID"),
    FOREIGN KEY ("PARTY") REFERENCES "PARTY"("PARTY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COUNTY VALUES (-2147483648, 15, 100001, 16);
INSERT INTO COUNTY VALUES (-2147483647, 20, 0, 21);
INSERT INTO PARTY VALUES (-2147483647, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PARTY VALUES (-2147483648, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ELECTION VALUES (-2147483647, -2147483648, -2147483647, 17, 2, 18, 19);
INSERT INTO ELECTION VALUES (-2147483648, -2147483648, -2147483647, 22, 1, 23, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT delegate FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.election_id AS election_id, RHS.counties_represented AS counties_represented, RHS.district AS district, RHS.delegate AS delegate, RHS.party AS party, RHS.first_elected AS first_elected, RHS.committee AS committee FROM county AS LHS CROSS JOIN election AS RHS) WHERE (population <= 100000.0) ORDER BY delegate;

/*
Gold Result:
('1',)
('2',)
*/

-- Prediction Query
SELECT T2.Delegate FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T1.Population < 100000;

/*
Prediction Result:
*/