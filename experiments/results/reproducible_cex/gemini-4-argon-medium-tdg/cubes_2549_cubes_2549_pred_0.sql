-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (0, 'Zero County', 1000.0, '00000');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'One County', 50000.0, '11111');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Two County', 75000.0, '22222');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (10, 2020.0, 'Democratic', 'Gov A', 'Lt A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 0, 10, '00.0', 'Wrong_Dist_0_But_ID_1', 2010.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (2, 2, 10, '02.0', 'Wrong_Dist_2', 2012.0, 'Finance');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (3, NULL, 10, 'None', 'Wrong_Dist_NULL', 2014.0, 'Rules');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (4, 1, 10, '01.1', 'Zelda', 2018.0, 'Health');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (5, 1, 10, '01.2', 'Alice', 2008.0, 'Education');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (6, 1, 10, '01.3', 'Bob', 2016.0, 'Ways and Means');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate FROM election WHERE (district = 1) ORDER BY delegate, election.election_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Zelda',)
*/

-- Prediction Query
SELECT Delegate FROM election WHERE District = 1;

/*
Prediction Result:
('Zelda',)
('Alice',)
('Bob',)
*/