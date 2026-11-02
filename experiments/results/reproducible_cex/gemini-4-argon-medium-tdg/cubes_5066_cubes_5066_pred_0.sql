-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Metro', 100000.0, '10001');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Rural', 25000.0, '10002');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (1, 2000.0, 'Dem', 'Gov_Alpha', 'LG_1', 'Comp_1', 'Zelda', 'Sen_1');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (2, 2004.0, 'Dem', 'Gov_Beta', 'LG_2', 'Comp_2', 'Zelda', 'Sen_2');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (3, 2008.0, 'Rep', 'Gov_Alpha', 'LG_3', 'Comp_3', 'Arthur', 'Sen_3');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (4, 2012.0, 'Rep', 'Gov_Alpha', 'LG_4', 'Comp_4', 'Arthur', 'Sen_4');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (5, 2016.0, 'Ind', 'Gov_Gamma', 'LG_5', 'Comp_5', 'Bob', 'Sen_5');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 1, 5, 'Metro', 'Del_1', 2016.0, 'Finance');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (2, 2, 5, 'Rural', 'Del_2', 2016.0, 'Health');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (3, 1, 5, 'Metro', 'Del_3', 2018.0, 'Rules');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (4, 1, 1, 'Metro', 'Del_4', 2000.0, 'Finance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT attorney_general AS governor FROM (SELECT LHS.attorney_general AS attorney_general, LHS.n AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general)) AS RHS ON (LHS.n = RHS.n)) ORDER BY governor;

/*
Gold Result:
('Arthur',)
('Zelda',)
*/

-- Prediction Query
SELECT Governor FROM party GROUP BY Governor ORDER BY COUNT(*) DESC, Governor NULLS LAST LIMIT 1;

/*
Prediction Result:
('Gov_Alpha',)
*/