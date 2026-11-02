-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. SELECT DISTINCT vs SELECT ALL (duplicate Year 2006 for 'Eliot Spitzer')
-- 2. ORDER BY ASC vs DESC and missing ORDER BY (Years inserted out of order: 2010, 2002, 2006)
-- 3. NULLS LAST vs NULLS FIRST (Row with NULL Year for 'Eliot Spitzer')
-- 4. WHERE clause filtering vs no WHERE or wrong operator (Rows with other governors and NULL governor)
-- 5. Wrong column referenced in WHERE (e.g., 'Eliot Spitzer' in Lieutenant_Governor or Comptroller instead of Governor)
-- 6. Unnecessary INNER JOIN with "election" (Party_ID 1, 2, 3 have no matching rows in "election"; only Party_ID 4 is referenced)
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Albany', 300000.0, '12201');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (1, 2010.0, 'Democratic', 'Eliot Spitzer', 'David Paterson', 'Thomas DiNapoli', 'Andrew Cuomo', 'Chuck Schumer');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (2, 2002.0, 'Working Families', 'Eliot Spitzer', 'David Paterson', 'Alan Hevesi', 'Eliot Spitzer', 'Hillary Clinton');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (3, NULL, 'Independence', 'Eliot Spitzer', 'David Paterson', 'Alan Hevesi', 'Andrew Cuomo', 'Chuck Schumer');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (4, 2006.0, 'Democratic', 'Eliot Spitzer', 'David Paterson', 'Alan Hevesi', 'Andrew Cuomo', 'Hillary Clinton');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (5, 2006.0, 'Working Families', 'Eliot Spitzer', 'David Paterson', 'Alan Hevesi', 'Andrew Cuomo', 'Hillary Clinton');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (6, 1998.0, 'Republican', 'George Pataki', 'Eliot Spitzer', 'Eliot Spitzer', 'Eliot Spitzer', 'Eliot Spitzer');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (7, 2014.0, 'Democratic', NULL, 'Kathy Hochul', 'Thomas DiNapoli', 'Eric Schneiderman', 'Kirsten Gillibrand');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 1, 4, 'Albany', 'John Doe', 2000.0, 'Finance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "year" FROM "party" WHERE ("governor" = 'Eliot Spitzer') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(None,)
(2002.0,)
(2006.0,)
(2010.0,)
*/

-- Prediction Query
SELECT DISTINCT YEAR FROM party WHERE Governor = 'Eliot Spitzer';

/*
Prediction Result:
(2010.0,)
(2002.0,)
(None,)
(2006.0,)
*/