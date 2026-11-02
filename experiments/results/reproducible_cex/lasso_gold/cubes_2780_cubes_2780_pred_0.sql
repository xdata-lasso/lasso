-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1012, 'Cristian Santos', 1013.5, 1014.5, 'offer');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1017, 'Olivia Moore', 1018.5, 1019.5, 'knowledge');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1015, 1012, 'Robinson-Lawrence', 1016.5, 'source');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1020, 1017, 'Garcia-James', 1017.5, 'table');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, investor FROM entrepreneur ORDER BY company, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('Garcia-James', 'table')
('Robinson-Lawrence', 'source')
*/

-- Prediction Query
SELECT Company, Investor FROM entrepreneur;

/*
Prediction Result:
('Robinson-Lawrence', 'source')
('Garcia-James', 'table')
*/