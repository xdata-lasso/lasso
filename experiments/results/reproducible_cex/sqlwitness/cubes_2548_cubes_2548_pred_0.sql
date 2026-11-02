-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, year, party, governor, lieutenant_governor, comptroller, attorney_general, us_senate) VALUES (1, 0.0, 'Appropriations', NULL, 'Appropriations', NULL, 'default2', 'default1'), (0, 1.0, NULL, NULL, 'Appropriations', 'default1', NULL, 'Appropriations'), (2, NULL, 'default1', 'default1', NULL, 'Appropriations', 'default1', 'default2'), (3, 1.0, NULL, NULL, NULL, 'Appropriations', 'default1', NULL), (4, 0.0, NULL, 'Appropriations', 'default1', 'default2', 'default2', 'default2'), (5, 1.0, 'default2', NULL, 'default2', NULL, 'default1', 'Appropriations'), (6, NULL, NULL, 'default1', 'Appropriations', 'Appropriations', 'Appropriations', 'default1'), (7, NULL, 'Appropriations', 'default1', 'default1', 'default2', NULL, NULL), (8, 0.0, NULL, 'Appropriations', 'Appropriations', 'default1', NULL, 'Appropriations'), (9, 0.0, 'Appropriations', 'default2', NULL, 'Appropriations', NULL, 'default2'), (10, NULL, NULL, 'default1', 'default1', 'default2', NULL, NULL), (11, 0.0, NULL, NULL, 'default1', NULL, 'Appropriations', 'Appropriations'), (12, NULL, NULL, 'default1', 'Appropriations', NULL, 'default1', 'default1'), (13, 1.0, 'default2', 'default2', 'Appropriations', NULL, NULL, 'default1'), (14, NULL, NULL, 'default1', 'default2', 'Appropriations', 'default2', 'default2');
INSERT INTO county (county_id, county_name, population, zip_code) VALUES (1, NULL, 0.0, 'default2'), (0, 'Appropriations', 1.0, 'default1'), (2, 'Appropriations', 0.0, NULL);
INSERT INTO election (election_id, district, party, counties_represented, delegate, first_elected, committee) VALUES (1, 2, 2, NULL, 'Appropriations', NULL, 'Appropriations'), (0, 2, 3, NULL, 'default1', NULL, 'default1'), (2, 0, 10, NULL, 'default1', 1.0, 'Appropriations'), (3, 2, 8, NULL, 'default1', 0.0, 'default2'), (4, NULL, 3, NULL, NULL, NULL, 'Appropriations'), (5, 0, 1, 'Appropriations', 'Appropriations', NULL, 'default1'), (6, 1, 10, 'default1', NULL, 1.0, 'default1'), (7, 1, 11, 'Appropriations', 'default2', 1.0, 'Appropriations'), (8, 1, 1, NULL, 'default2', NULL, 'Appropriations'), (9, NULL, 8, 'Appropriations', 'Appropriations', NULL, NULL), (10, 0, 3, 'default1', NULL, 1.0, 'default1'), (11, 0, 3, 'default1', 'Appropriations', 0.0, 'default2'), (12, 2, 8, 'default1', NULL, NULL, 'Appropriations'), (13, 1, 9, 'default1', 'Appropriations', NULL, 'Appropriations'), (14, 0, 4, 'Appropriations', 'default1', NULL, NULL), (15, 1, 6, 'default2', 'Appropriations', 0.0, 'default2'), (16, 0, 13, 'default2', 'default1', 1.0, 'Appropriations'), (17, 0, 5, 'default1', 'default1', 1.0, 'default2'), (18, 2, 14, 'Appropriations', 'default2', 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "county_name" FROM (SELECT "LHS"."county_id" AS "county_id", "LHS"."county_name" AS "county_name", "LHS"."population" AS "population", "LHS"."zip_code" AS "zip_code", "RHS"."election_id" AS "election_id", "RHS"."counties_represented" AS "counties_represented", "RHS"."delegate" AS "delegate", "RHS"."party" AS "party", "RHS"."first_elected" AS "first_elected", "RHS"."committee" AS "committee" FROM "county" AS "LHS" INNER JOIN (SELECT * FROM "election" WHERE ("committee" = 'Appropriations')) AS RHS ON (LHS.county_id = RHS.district)) ORDER BY county_name, "county_name" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
('Appropriations',)
('Appropriations',)
('Appropriations',)
('Appropriations',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T2.Committee = 'Appropriations';

/*
Prediction Result:
('Appropriations',)
('Appropriations',)
(None,)
(None,)
('Appropriations',)
(None,)
('Appropriations',)
*/