-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "party" ("Party_ID", "Year", "Governor") VALUES (1, 2008.0, 'Eliot Spitzer');
INSERT INTO "party" ("Party_ID", "Year", "Governor") VALUES (2, 2006.0, 'Eliot Spitzer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "year" FROM "party" WHERE ("governor" = 'Eliot Spitzer') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(2006.0,)
(2008.0,)
*/

-- Prediction Query
SELECT DISTINCT YEAR FROM party WHERE Governor = 'Eliot Spitzer';

/*
Prediction Result:
(2008.0,)
(2006.0,)
*/