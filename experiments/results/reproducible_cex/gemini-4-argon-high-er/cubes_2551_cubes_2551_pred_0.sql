-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2020.0, 'Democratic', 'Gov1', 'B', 'Comp1', 'AG1', 'Sen1');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (2, 2021.0, 'Democratic', 'Gov2', 'A', 'Comp2', 'AG2', 'Sen2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lieutenant_governor", "comptroller" FROM "party" WHERE ("party" = 'Democratic') ORDER BY lieutenant_governor, party.party_id NULLS LAST;

/*
Gold Result:
('A', 'Comp2')
('B', 'Comp1')
*/

-- Prediction Query
SELECT Lieutenant_Governor, Comptroller FROM party WHERE Party = 'Democratic';

/*
Prediction Result:
('B', 'Comp1')
('A', 'Comp2')
*/