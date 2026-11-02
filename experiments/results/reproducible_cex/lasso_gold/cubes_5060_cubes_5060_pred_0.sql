-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1019, 'Brandon Davis', 1022.5, '50116');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1020, 'Lindsey Roman', 1029.5, '10829');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1021, 'Kimberly Dudley', 1036.5, '72858');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1037, NULL, 1040.5, '61090');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1038, NULL, 1047.5, '50236');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1039, NULL, 1054.5, '35883');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1025, 1028.5, 'finally', 'present', 'high', 'sea', 'recently', 'figure');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1026, 1033.5, 'themselves', 'value', 'participant', 'available', 'drive', 'base');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1027, 1038.5, 'production', 'training', 'dark', 'answer', 'spring', 'top');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1043, 1046.5, 'wish', 'onto', 'garden', 'stand', 'term', 'four');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1044, 1051.5, 'push', 'discuss', 'threat', 'arrive', 'almost', 'institution');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1045, 1056.5, 'rise', 'reveal', 'special', 'drop', 'support', 'executive');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1031, 1019, 1025, 'early', 'husband', 1034.5, 'prove');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1032, 1019, 1025, 'trial', 'fall', 1047.5, 'they');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1033, 1019, 1025, 'blood', 'long', 1060.5, 'his');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1049, 1037, 1043, 'attorney', 'yes', 1052.5, 'serious');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1050, 1037, 1043, 'development', 'our', 1065.5, 'forward');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1051, 1037, 1043, 'white', 'under', 1078.5, 'difference');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name FROM (SELECT county_id, county_name, population, zip_code, n, county_id AS district FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.n AS n FROM county AS LHS INNER JOIN (SELECT district, COUNT(*) AS n FROM election GROUP BY district) AS RHS ON (LHS.county_id = RHS.district))) WHERE (n >= 2) ORDER BY county_name;

/*
Gold Result:
(None,)
('Brandon Davis',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District GROUP BY T1.County_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Brandon Davis',)
(None,)
*/