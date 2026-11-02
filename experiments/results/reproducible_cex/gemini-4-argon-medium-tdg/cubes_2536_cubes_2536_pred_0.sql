-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2000.0, 'Democratic', 'Alice', 'L1', 'C1', 'X1', 'S1');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (2, 2004.0, 'Democratic', 'G2', 'L2', 'C2', 'Alice', 'S2');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (3, 2008.0, 'Democratic', 'Bob', 'L3', 'C3', 'Bob', 'S3');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (4, 2000.0, 'Republican', 'Charlie', 'L4', 'C4', 'X4', 'S4');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (5, 2004.0, 'Green', 'G5', 'L5', 'C5', 'Charlie', 'S5');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (6, 2008.0, 'Libertarian', 'Dave', 'Dave', 'Dave', 'NotDave', 'Dave');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (7, 2012.0, 'Whig', 'Eve', 'L7', 'C7', 'Eve', 'S7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT party_id, YEAR, party, governor, lieutenant_governor, comptroller, governor AS attorney_general, us_senate, party_id_other, year_other, governor_other, lieutenant_governor_other, comptroller_other, us_senate_other FROM (SELECT LHS.party_id AS party_id, LHS.year AS YEAR, LHS.party AS party, LHS.governor AS governor, LHS.lieutenant_governor AS lieutenant_governor, LHS.comptroller AS comptroller, LHS.attorney_general AS attorney_general, LHS.us_senate AS us_senate, RHS.party_id AS party_id_other, RHS.year AS year_other, RHS.governor AS governor_other, RHS.lieutenant_governor AS lieutenant_governor_other, RHS.comptroller AS comptroller_other, RHS.us_senate AS us_senate_other FROM party AS LHS INNER JOIN party AS RHS ON (LHS.party = RHS.party AND LHS.governor = RHS.attorney_general))) ORDER BY party;

/*
Gold Result:
('Democratic',)
('Whig',)
*/

-- Prediction Query
SELECT Party FROM party GROUP BY Party HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Democratic',)
*/