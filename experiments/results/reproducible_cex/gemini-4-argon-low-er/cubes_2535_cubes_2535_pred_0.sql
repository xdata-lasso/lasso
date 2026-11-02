-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("County_Id", "County_name") VALUES (1, 'A');
INSERT INTO "county" ("County_Id", "County_name") VALUES (2, 'B');
INSERT INTO "party" ("Party_ID", "Party") VALUES (1, 'Dem');
INSERT INTO "election" ("Election_ID", "District", "Party") VALUES (1, 2, 1);
INSERT INTO "election" ("Election_ID", "District", "Party") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT district FROM election ORDER BY district;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT District FROM election;

/*
Prediction Result:
(2,)
(1,)
*/