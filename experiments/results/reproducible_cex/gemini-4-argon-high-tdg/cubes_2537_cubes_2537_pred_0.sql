-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (10, 'Howard', 287085.0, '21042');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (20, 'Montgomery', 971777.0, '20850');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (30, 'Talbot', 37782.0, '21601');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (100, 1998.0, 'Democratic', 'Parris Glendening', 'Kathleen Kennedy Townsend', 'William Donald Schaefer', 'J. Joseph Curran Jr.', 'Barbara Mikulski');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (200, 2002.0, 'Republican', 'Bob Ehrlich', 'Michael Steele', 'William Donald Schaefer', 'J. Joseph Curran Jr.', 'Paul Sarbanes');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (300, 2006.0, 'Democratic', 'Martin O''Malley', 'Anthony G. Brown', 'Peter Franchot', 'Doug Gansler', 'Ben Cardin');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (10, 10, 200, '04', 'A_Delegate', 2010.0, 'Judiciary');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 30, 100, '01', 'D_Delegate', 1998.0, 'Appropriations');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 20, 300, '03', 'C_Delegate', 2004.0, 'Ways and Means');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (25, 20, 100, '02', 'B_Delegate', 2002.0, 'Health');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT election_id, counties_represented, district, delegate, party, first_elected, committee FROM election ORDER BY election_id;

/*
Gold Result:
(1, '03', 20, 'C_Delegate', 300, 2004.0, 'Ways and Means')
(2, '01', 30, 'D_Delegate', 100, 1998.0, 'Appropriations')
(10, '04', 10, 'A_Delegate', 200, 2010.0, 'Judiciary')
(25, '02', 20, 'B_Delegate', 100, 2002.0, 'Health')
*/

-- Prediction Query
SELECT * FROM election;

/*
Prediction Result:
(1, 20, 300, '03', 'C_Delegate', 2004.0, 'Ways and Means')
(2, 30, 100, '01', 'D_Delegate', 1998.0, 'Appropriations')
(10, 10, 200, '04', 'A_Delegate', 2010.0, 'Judiciary')
(25, 20, 100, '02', 'B_Delegate', 2002.0, 'Health')
*/