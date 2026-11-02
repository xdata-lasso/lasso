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
INSERT INTO COUNTY VALUES (0, 0, 0, 0);
INSERT INTO COUNTY VALUES (1, 0, 0, 0);
INSERT INTO PARTY VALUES (-1, 10, 2, 13, 11, 12, 13, 14);
INSERT INTO PARTY VALUES (0, 20, 1, 15, 21, 22, 15, 23);
INSERT INTO ELECTION VALUES (0, 0, -1, 0, 0, 0, 0);
INSERT INTO ELECTION VALUES (1, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT party_id, YEAR, party, governor, lieutenant_governor, comptroller, governor AS attorney_general, us_senate, party_id_other, year_other, governor_other, lieutenant_governor_other, comptroller_other, us_senate_other FROM (SELECT LHS.party_id AS party_id, LHS.year AS YEAR, LHS.party AS party, LHS.governor AS governor, LHS.lieutenant_governor AS lieutenant_governor, LHS.comptroller AS comptroller, LHS.attorney_general AS attorney_general, LHS.us_senate AS us_senate, RHS.party_id AS party_id_other, RHS.year AS year_other, RHS.governor AS governor_other, RHS.lieutenant_governor AS lieutenant_governor_other, RHS.comptroller AS comptroller_other, RHS.us_senate AS us_senate_other FROM party AS LHS INNER JOIN party AS RHS ON (LHS.party = RHS.party AND LHS.governor = RHS.attorney_general))) ORDER BY party;

/*
Gold Result:
('1',)
('2',)
*/

-- Prediction Query
SELECT Party FROM party GROUP BY Party HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/