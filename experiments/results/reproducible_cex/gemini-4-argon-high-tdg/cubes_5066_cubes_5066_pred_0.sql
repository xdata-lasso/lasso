-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'Allegany', 75000.0, '21502');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Anne Arundel', 550000.0, '21401');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2000.0, 'Democratic', 'Glendening', 'Townsend', 'Schaefer', 'Brown', 'Sarbanes');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (2, 2000.0, 'Democratic', 'O''Malley', 'Townsend', 'Franchot', 'Brown', 'Mikulski');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (3, 2000.0, 'Democratic', 'Ehrlich', 'Steele', 'Schaefer', 'Brown', 'Cardin');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (4, 2004.0, 'Republican', 'Hogan', 'Rutherford', 'Schaefer', 'Smith', 'Mikulski');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (5, 2008.0, 'Independent', 'Hogan', 'Rutherford', 'Franchot', 'Smith', 'Mikulski');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (6, 2012.0, 'Green', 'Hogan', 'Townsend', 'Schaefer', 'Adams', 'Mikulski');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 1, 4, 'Allegany', 'Miller', 1998.0, 'Appropriations');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 1, 5, 'Allegany', 'Jones', 2002.0, 'Ways and Means');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (3, 2, 6, 'Anne Arundel', 'Davis', 2006.0, 'Judiciary');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (4, 2, 6, 'Anne Arundel', 'Wilson', 2006.0, 'Judiciary');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (5, 1, 6, 'Allegany', 'Taylor', 2010.0, 'Health');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (6, 2, 6, 'Anne Arundel', 'Moore', 2010.0, 'Rules');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT attorney_general AS governor FROM (SELECT LHS.attorney_general AS attorney_general, LHS.n AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general)) AS RHS ON (LHS.n = RHS.n)) ORDER BY governor;

/*
Gold Result:
('Brown',)
*/

-- Prediction Query
SELECT Governor FROM party GROUP BY Governor ORDER BY COUNT(*) DESC, Governor NULLS LAST LIMIT 1;

/*
Prediction Result:
('Hogan',)
*/