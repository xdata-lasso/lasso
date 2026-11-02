-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'Montgomery', 1050000.0, '20850');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Howard', 325000.0, '21043');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2018.0, 'Democratic', 'Gov_A', 'Charlie', 'Comp_C', 'AG_A', 'Sen_A');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (2, 2014.0, 'Democratic', 'Gov_B', 'Alice', 'Comp_A', 'AG_B', 'Sen_B');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (3, 2010.0, 'Democratic', 'Gov_C', 'Bob', 'Zelda', 'AG_C', 'Sen_C');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (4, 2006.0, 'Democratic', 'Gov_D', 'Bob', 'Aaron', 'AG_D', 'Sen_D');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (5, 2016.0, 'Republican', 'Gov_E', 'aab', 'Comp_E', 'AG_E', 'Sen_E');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (101, 1, 1, 'Montgomery', 'Del_1', 2018.0, 'Finance');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (102, 2, 5, 'Howard', 'Del_2', 2016.0, 'Rules');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lieutenant_governor", "comptroller" FROM "party" WHERE ("party" = 'Democratic') ORDER BY lieutenant_governor, party.party_id NULLS LAST;

/*
Gold Result:
('Alice', 'Comp_A')
('Bob', 'Zelda')
('Bob', 'Aaron')
('Charlie', 'Comp_C')
*/

-- Prediction Query
SELECT Lieutenant_Governor, Comptroller FROM party WHERE Party = 'Democratic';

/*
Prediction Result:
('Charlie', 'Comp_C')
('Alice', 'Comp_A')
('Bob', 'Zelda')
('Bob', 'Aaron')
*/