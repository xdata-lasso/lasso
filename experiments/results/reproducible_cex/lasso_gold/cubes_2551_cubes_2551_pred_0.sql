-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1032, 1033.5, 'Democratic', 'available', 'high', 'participant', 'dark', 'sea');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1034, 1034.5, 'Democratic', 'training', 'figure', 'recently', 'drive', 'spring');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lieutenant_governor", "comptroller" FROM "party" WHERE ("party" = 'Democratic') ORDER BY lieutenant_governor, party.party_id NULLS LAST;

/*
Gold Result:
('figure', 'recently')
('high', 'participant')
*/

-- Prediction Query
SELECT Lieutenant_Governor, Comptroller FROM party WHERE Party = 'Democratic';

/*
Prediction Result:
('high', 'participant')
('figure', 'recently')
*/