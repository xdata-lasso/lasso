-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "election" ("Election_ID", "Delegate", "Committee") VALUES (1, 'B', 'C1');
INSERT INTO "election" ("Election_ID", "Delegate", "Committee") VALUES (2, 'A', 'C2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate, committee FROM election ORDER BY delegate, election.election_id NULLS LAST;

/*
Gold Result:
('A', 'C2')
('B', 'C1')
*/

-- Prediction Query
SELECT Delegate, Committee FROM election;

/*
Prediction Result:
('B', 'C1')
('A', 'C2')
*/