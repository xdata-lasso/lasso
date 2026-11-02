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
INSERT INTO COUNTY VALUES (-2147483648, 16, -1, 17);
INSERT INTO COUNTY VALUES (-2147483647, 22, 49999, 23);
INSERT INTO PARTY VALUES (-2147483647, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PARTY VALUES (-2147483648, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ELECTION VALUES (-2147483647, -2147483647, -2147483648, 18, 19, 20, 21);
INSERT INTO ELECTION VALUES (-2147483648, -2147483647, -2147483648, 24, 25, 26, 27);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count_distinct_t2_delegate_ FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, LHS.election_id AS election_id, LHS.counties_represented AS counties_represented, LHS.district AS district, LHS.delegate AS delegate, LHS.party AS party, LHS.first_elected AS first_elected, LHS.committee AS committee, RHS.n AS n FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.election_id AS election_id, RHS.counties_represented AS counties_represented, RHS.district AS district, RHS.delegate AS delegate, RHS.party AS party, RHS.first_elected AS first_elected, RHS.committee AS committee FROM county AS LHS CROSS JOIN election AS RHS) AS LHS CROSS JOIN (SELECT COUNT(*) AS n FROM county WHERE (population <> 50000.0)) AS RHS) ORDER BY count_distinct_t2_delegate_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.Delegate) FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T1.Population > 50000;

/*
Prediction Result:
(0,)
*/