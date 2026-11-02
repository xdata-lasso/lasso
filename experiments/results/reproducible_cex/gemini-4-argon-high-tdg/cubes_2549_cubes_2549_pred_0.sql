-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (0, 'Zero County', 1000.0, '00000');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'First County', 5000.0, '11111');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Second County', 8000.0, '22222');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2020.0, 'Dem', 'Gov A', 'Lt A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (2, 2020.0, 'Rep', 'Gov B', 'Lt B', 'Comp B', 'AG B', 'Sen B');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (10, 1, 1, 'First County', 'Charlie', 2010.0, 'Finance');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (20, 1, 2, 'First County', 'Alice', 2012.0, 'Rules');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (5, 1, 1, 'First County', 'Alice', 2018.0, 'Health');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (15, 1, NULL, 'First County', 'Bob', 2014.0, 'Education');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 2, 1, 'Second County', 'David', 2016.0, 'ways');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 0, 1, 'Zero County', 'Eve', 2016.0, 'Ways');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (3, NULL, 1, 'None', 'Frank', 2016.0, 'Ways');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate FROM election WHERE (district = 1) ORDER BY delegate, election.election_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Delegate FROM election WHERE District = 1;

/*
Prediction Result:
('Alice',)
('Charlie',)
('Bob',)
('Alice',)
*/