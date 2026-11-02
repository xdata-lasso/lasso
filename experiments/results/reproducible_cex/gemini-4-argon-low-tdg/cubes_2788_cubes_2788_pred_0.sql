-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Zoe', 165.0, 60.0, '1990-01-01');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (2, 'Alice', 170.0, 65.0, '1985-05-12');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (3, 'Bob', 180.0, 80.0, '1978-11-23');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (4, 'Charlie', 175.0, 75.0, '1992-07-15');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (10, 1, 'TechCorp', 100000.0, 'Peter Jones');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (20, 2, 'BioHealth', 250000.0, 'Deborah Meaden');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (30, 3, 'EcoGoods', 50000.0, 'Rachel Elnaugh');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."entrepreneur_id" AS "entrepreneur_id", "LHS"."people_id" AS "people_id", "LHS"."company" AS "company", "LHS"."money_requested" AS "money_requested", "LHS"."investor" AS "investor", "RHS"."name" AS "name", "RHS"."height" AS "height", "RHS"."weight" AS "weight", "RHS"."date_of_birth" AS "date_of_birth" FROM (SELECT * FROM "entrepreneur" WHERE ("investor" <> 'Rachel Elnaugh')) AS LHS LEFT JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Investor <> 'Rachel Elnaugh';

/*
Prediction Result:
('Zoe',)
('Alice',)
*/