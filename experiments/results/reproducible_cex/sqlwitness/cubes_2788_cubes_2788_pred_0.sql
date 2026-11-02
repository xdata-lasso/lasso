-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, date_of_birth) VALUES (0, 'default1', NULL, NULL, 'Rachel Elnaugh'), (1, 'Rachel Elnaugh', NULL, 1.0, NULL), (2, NULL, 1.0, NULL, NULL), (3, 'Rachel Elnaugh', NULL, 1.0, NULL), (4, NULL, 1.0, NULL, 'Rachel Elnaugh'), (5, 'default2', 1.0, NULL, NULL);
INSERT INTO entrepreneur (entrepreneur_id, people_id, company, money_requested, investor) VALUES (0, NULL, 'default2', NULL, NULL), (1, NULL, 'Rachel Elnaugh', 0.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."entrepreneur_id" AS "entrepreneur_id", "LHS"."people_id" AS "people_id", "LHS"."company" AS "company", "LHS"."money_requested" AS "money_requested", "LHS"."investor" AS "investor", "RHS"."name" AS "name", "RHS"."height" AS "height", "RHS"."weight" AS "weight", "RHS"."date_of_birth" AS "date_of_birth" FROM (SELECT * FROM "entrepreneur" WHERE ("investor" <> 'Rachel Elnaugh')) AS LHS LEFT JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Investor <> 'Rachel Elnaugh';

/*
Prediction Result:
*/