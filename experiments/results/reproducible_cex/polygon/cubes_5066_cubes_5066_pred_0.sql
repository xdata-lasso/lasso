-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (11, '16', 16, '16');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (10, '16', 16, '16');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (13, 16, '16', '21', '16', '16', '16', '16');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (12, 16, '16', '16', '16', '16', '16', '16');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (15, 10, 12, '16', '16', 16, '16');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (14, 11, 13, '16', '16', 16, '16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT attorney_general AS governor FROM (SELECT LHS.attorney_general AS attorney_general, LHS.n AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general)) AS RHS ON (LHS.n = RHS.n)) ORDER BY governor;

/*
Gold Result:
('16',)
*/

-- Prediction Query
SELECT Governor FROM party GROUP BY Governor ORDER BY COUNT(*) DESC, Governor NULLS LAST LIMIT 1;

/*
Prediction Result:
('16',)
*/