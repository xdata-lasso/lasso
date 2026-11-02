-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Bob', 180.0, 75.0, '1980-01-01');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (2, 'Alice', 165.0, 60.0, '1985-05-05');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (1, 1, 'Company A', 10000.0, 'Peter Jones');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (2, 2, 'Company B', 20000.0, 'Peter Jones');
INSERT INTO "entrepreneur" ("Entrepreneur_ID", "People_ID", "Company", "Money_Requested", "Investor") VALUES (3, NULL, 'Company C', 30000.0, 'Peter Jones');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."entrepreneur_id" AS "entrepreneur_id", "LHS"."people_id" AS "people_id", "LHS"."company" AS "company", "LHS"."money_requested" AS "money_requested", "LHS"."investor" AS "investor", "RHS"."name" AS "name", "RHS"."height" AS "height", "RHS"."weight" AS "weight", "RHS"."date_of_birth" AS "date_of_birth" FROM (SELECT * FROM "entrepreneur" WHERE ("investor" <> 'Rachel Elnaugh')) AS LHS LEFT JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Investor <> 'Rachel Elnaugh';

/*
Prediction Result:
('Bob',)
('Alice',)
*/