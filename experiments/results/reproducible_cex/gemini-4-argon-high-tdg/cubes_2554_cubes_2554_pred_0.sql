-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (10, 'Howard', 325000.0, '21042');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 1990.0, 'Independent', 'Zelda', 'Lt1', 'Comp1', 'Zelda', 'Sen1');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (2, 1994.0, 'Democratic', 'Aaron', 'Lt2', 'Comp2', 'OtherAG1', 'Sen2');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (3, 1998.0, 'Democratic', 'Aaron', 'Lt3', 'Comp3', 'OtherAG2', 'Sen3');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (4, 1982.0, 'Democratic', 'OtherGov1', 'Lt4', 'Comp4', 'Aaron', 'Sen4');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (5, 1986.0, 'Democratic', 'OtherGov2', 'Lt5', 'Comp5', 'Aaron', 'Sen5');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (6, 2002.0, 'Republican', 'MidGov', 'Lt6', 'Comp6', 'NoMatchAG', 'Sen6');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (7, 2006.0, 'Republican', 'NoMatchGov', 'Lt7', 'Comp7', 'MidGov', 'Sen7');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (10, 10, 2, 'Howard', 'Del A', 1994.0, 'Finance');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (11, 10, 2, 'Howard', 'Del B', 1994.0, 'Rules');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT governor FROM (SELECT party_id, YEAR, party, governor, lieutenant_governor, comptroller, governor AS attorney_general, us_senate, party_id_other, year_other, governor_other, lieutenant_governor_other, comptroller_other, us_senate_other FROM (SELECT LHS.party_id AS party_id, LHS.year AS YEAR, LHS.party AS party, LHS.governor AS governor, LHS.lieutenant_governor AS lieutenant_governor, LHS.comptroller AS comptroller, LHS.attorney_general AS attorney_general, LHS.us_senate AS us_senate, RHS.party_id AS party_id_other, RHS.year AS year_other, RHS.governor AS governor_other, RHS.lieutenant_governor AS lieutenant_governor_other, RHS.comptroller AS comptroller_other, RHS.us_senate AS us_senate_other FROM party AS LHS INNER JOIN party AS RHS ON (LHS.party = RHS.party AND LHS.governor = RHS.attorney_general))) ORDER BY governor;

/*
Gold Result:
('Aaron',)
('MidGov',)
('Zelda',)
*/

-- Prediction Query
SELECT Governor FROM party GROUP BY Governor ORDER BY COUNT(*) DESC, Governor NULLS LAST LIMIT 1;

/*
Prediction Result:
('Aaron',)
*/