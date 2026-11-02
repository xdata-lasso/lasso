-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Albany', 304204.0, '12201');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (1, 2006.0, 'Democratic', 'Eliot Spitzer', 'David Paterson', 'Alan Hevesi', 'Andrew Cuomo', 'Hillary Clinton');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (2, 2006.0, 'Independence', 'Eliot Spitzer', 'David Paterson', 'Alan Hevesi', 'Andrew Cuomo', 'Hillary Clinton');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (3, 2002.0, 'Democratic', 'Eliot Spitzer', 'David Paterson', 'H. Carl McCall', 'Eliot Spitzer', 'Charles Schumer');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (4, 1998.0, 'Republican', 'George Pataki', 'Mary Donohue', 'John Faso', 'Dennis Vacco', 'Al D''Amato');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 1, 1, 'Albany', 'Jack McEneny', 1992.0, 'Ways and Means');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (2, 1, 4, 'Albany', 'John Faso', 1986.0, 'Codes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "year" FROM "party" WHERE ("governor" = 'Eliot Spitzer') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(2002.0,)
(2006.0,)
*/

-- Prediction Query
SELECT DISTINCT YEAR FROM party WHERE Governor = 'Eliot Spitzer';

/*
Prediction Result:
(2006.0,)
(2002.0,)
*/