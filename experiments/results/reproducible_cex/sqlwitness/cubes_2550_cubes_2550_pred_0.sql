-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, year, party, governor, lieutenant_governor, comptroller, attorney_general, us_senate) VALUES (1, 1.0, 'default1', 'Eliot Spitzer', 'Eliot Spitzer', 'default2', 'Eliot Spitzer', NULL), (0, NULL, 'default2', 'default2', NULL, 'default2', 'default1', 'default1'), (2, NULL, NULL, 'Eliot Spitzer', 'Eliot Spitzer', NULL, 'default1', 'Eliot Spitzer'), (3, 0.0, 'default2', 'default2', 'default1', 'default1', 'default1', 'default1'), (4, 1.0, 'Eliot Spitzer', 'Eliot Spitzer', 'default2', NULL, NULL, 'default1'), (5, 0.0, 'Eliot Spitzer', NULL, 'default1', 'Eliot Spitzer', 'default2', NULL), (6, NULL, NULL, NULL, 'Eliot Spitzer', 'Eliot Spitzer', NULL, NULL), (7, 1.0, 'default2', 'default1', 'Eliot Spitzer', 'default1', 'default2', NULL), (8, 1.0, NULL, NULL, 'default2', NULL, 'default1', NULL), (9, NULL, 'default2', NULL, 'default2', 'Eliot Spitzer', 'Eliot Spitzer', 'default1'), (10, 0.0, 'default2', 'default2', 'default2', 'default2', 'Eliot Spitzer', 'Eliot Spitzer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "year" FROM "party" WHERE ("governor" = 'Eliot Spitzer') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(None,)
(1.0,)
*/

-- Prediction Query
SELECT DISTINCT YEAR FROM party WHERE Governor = 'Eliot Spitzer';

/*
Prediction Result:
(1.0,)
(None,)
*/