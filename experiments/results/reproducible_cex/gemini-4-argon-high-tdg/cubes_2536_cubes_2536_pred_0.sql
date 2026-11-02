-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'essex', 50000.0, '01901');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2000.0, 'Whig', 'Alice', 'Tom', 'Jerry', 'Bob', 'Sam');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (2, 2004.0, 'Whig', 'Bob', 'Tim', 'Jim', 'Charlie', 'Pam');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (3, 2008.0, 'Whig', 'Bob', 'Ted', 'Jed', 'David', 'Dan');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (4, 1996.0, 'Democratic', 'Eve', 'Ann', 'Ben', 'Frank', 'Ken');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (5, 2000.0, 'Democratic', 'Frank', 'Amy', 'Roy', 'Grace', 'Ray');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (6, 2000.0, 'Republican', 'Grace', 'Hal', 'Cal', 'Heidi', 'Sal');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (7, 2004.0, 'Republican', 'Grace', 'Gus', 'Mel', 'Ivan', 'Gil');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (8, 2000.0, 'Green', 'Judy', 'Karl', 'Liam', 'Mallory', 'Niaj');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (9, 2004.0, 'Green', 'Karl', 'Olivia', 'Judy', 'Mallory', 'Judy');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 1, 6, 'Essex', 'John Smith', 2000.0, 'Ways and Means');
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
('Green',)
('Republican',)
('Whig',)
*/