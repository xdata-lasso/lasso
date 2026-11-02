-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1016, 'Kimberly Robinson', 1017.5, 1018.5, 'perform');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1019, 'Sean Blake', 1020.5, 1021.5, 'collection');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1022, 'Sean Blake', 1020.5, 1021.5, 'collection');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1023, 'Gina Moore', NULL, 1025.5, 'source');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1026, 'Brandon Davis', NULL, 1028.5, 'throw');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1029, 'Brandon Davis', NULL, 1028.5, 'throw');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight FROM (SELECT LHS.height AS height, RHS.people_id AS people_id, RHS.name AS name, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM (SELECT MIN(height) AS height FROM people) AS LHS LEFT JOIN people AS RHS ON (LHS.height = RHS.height)) ORDER BY weight;

/*
Gold Result:
(1018.5,)
*/

-- Prediction Query
SELECT Weight FROM people ORDER BY Height ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1025.5,)
*/