-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'Albany', 304204.0, '12207');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Bronx', 1385108.0, '10451');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2000.0, 'Democratic', 'Gov A', 'LtGov A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (2, 2004.0, 'Liberal', 'Gov B', 'LtGov B', 'Comp B', 'AG B', 'Sen B');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (3, 2008.0, 'Democratic', 'Gov C', 'LtGov C', 'Comp C', 'AG C', 'Sen C');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (4, 2000.0, 'Republican', 'Gov D', 'LtGov D', 'Comp D', 'AG D', 'Sen D');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (5, 2012.0, 'Democratic', 'Gov E', 'LtGov E', 'Comp E', 'AG E', 'Sen E');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 1, 4, 'Albany', 'Del 1', 2000.0, 'Finance');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 1, 2, 'Albany', 'Del 2', 2004.0, 'Appropriations');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (3, 2, 3, 'Bronx', 'Del 3', 2008.0, 'Appropriations');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (4, 2, 1, 'Bronx', 'Del 4', 2000.0, 'Judiciary');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (5, 1, 5, 'Albany', 'Del 5', 2000.0, 'Rules');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "committee" FROM (SELECT "election_id", "counties_represented", "district", "delegate", "party", "first_elected", "committee", "party_other", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate", "election_id" AS "party_id" FROM (SELECT "LHS"."election_id" AS "election_id", "LHS"."counties_represented" AS "counties_represented", "LHS"."district" AS "district", "LHS"."delegate" AS "delegate", "LHS"."party" AS "party", "LHS"."first_elected" AS "first_elected", "LHS"."committee" AS "committee", "RHS"."party" AS "party_other", "RHS"."governor" AS "governor", "RHS"."lieutenant_governor" AS "lieutenant_governor", "RHS"."comptroller" AS "comptroller", "RHS"."attorney_general" AS "attorney_general", "RHS"."us_senate" AS "us_senate" FROM "election" AS "LHS" INNER JOIN (SELECT * FROM "party" WHERE ("party" = 'Democratic' OR "party" = 'Liberal')) AS RHS ON (LHS.election_id = RHS.party_id AND LHS.first_elected = RHS.year))) ORDER BY committee, "committee" NULLS LAST;

/*
Gold Result:
('Appropriations',)
('Appropriations',)
('Finance',)
*/

-- Prediction Query
SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party = T2.Party_ID WHERE T2.Party = 'Democratic' INTERSECT SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party = T2.Party_ID WHERE T2.Party = 'Liberal';

/*
Prediction Result:
('Appropriations',)
*/